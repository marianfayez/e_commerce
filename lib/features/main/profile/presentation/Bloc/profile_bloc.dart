import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/domain/use_cases/add_address_use_case.dart';
import 'package:e_commerce_app/features/main/profile/domain/use_cases/delete_address_use_case.dart';
import 'package:e_commerce_app/features/main/profile/domain/use_cases/profile_use-case.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_state.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileUseCase profileUseCase;
  AddAddressUseCase addAddressUseCase;
  DeleteAddressUseCase deleteAddressUseCase;

  ProfileBloc(this.profileUseCase,this.addAddressUseCase,this.deleteAddressUseCase) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetData>((event, emit) async {
      emit(state.copyWith(getDataRequestState: RequestState.loading));
      var result = await profileUseCase.call();
      print(result);

      return result.fold((error) {
        print("error response");
        print("❌ Error: $error");

        emit(state.copyWith(
            getDataRequestState: RequestState.error, routeFailures: error));
      }, (result) {
        print("✅ success response with user data: ${result.user?.phone}");
        emit(state.copyWith(
          getDataRequestState: RequestState.success,
          authModel: result
        ));
      });
    });

    on<AddAddress>((event, emit) async {
      emit(state.copyWith(addAddressRequestState: RequestState.loading));
      var result = await addAddressUseCase.call( model: event.model);

      return result.fold((error) {
        print("error response");
        print("❌ Error: $error");

        emit(state.copyWith(
            addAddressRequestState: RequestState.error, addAddressFailures: error));
      }, (result) async {
        result.data?.removeWhere((address) => address.id == null);

        print("✅ Address added, now refreshing...");
        final refreshedAddress = await addAddressUseCase.getAddress();
        refreshedAddress.fold((err) {
          emit(state.copyWith(
            getAddressRequestState: RequestState.error,
            getAddressFailures: err,
          ));
        }, (updatedAddress) async {
          print("✅ Item updated successfully");
          emit(state.copyWith(
            addAddressRequestState: RequestState.success,
            getAddressRequestState: RequestState.success,
            addressModel: updatedAddress,
          ));
        });
      });
    });
    on<GetAddresses>((event, emit) async {
      emit(state.copyWith(getDataRequestState: RequestState.loading));
      var result = await addAddressUseCase.getAddress();
      print(result);

      return result.fold((error) {
        print("error response");
        print("❌ Error: $error");

        emit(state.copyWith(
            getAddressRequestState: RequestState.error, getAddressFailures: error));
      }, (result) {
        emit(state.copyWith(
            getAddressRequestState: RequestState.success,
            addressModel: result
        ));
      });
    });

    on<DeleteAddressEvent>((event, emit) async {
      emit(state.copyWith(
          deleteAddressRequestState: RequestState.loading));
      var result = await deleteAddressUseCase.deleteAddress(event.id);
      return result.fold((error) {
        print("error response");
        print("❌ Error: $error");

        emit(state.copyWith(
           deleteAddressRequestState: RequestState.error,
            deleteAddressFailures: error));
      }, (success) async {
        print("✅ Address removed, now refreshing...");

        // بعد نجاح الحذف، نعيد تحميل السلة مباشرة
        final refreshedAddress = await addAddressUseCase.getAddress();
        refreshedAddress.fold((err) {
          emit(state.copyWith(
            deleteAddressRequestState: RequestState.error,
            deleteAddressFailures: err,
          ));
        }, (updatedAddress) async {
          print("✅ Item removed successfully");
          emit(state.copyWith(
           deleteAddressRequestState: RequestState.success,
            getAddressRequestState: RequestState.success,
            addressModel: updatedAddress,
          ));
        });
      });
    });

  }
}
