import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/main/profile/domain/use_cases/add_address_use_case.dart';
import 'package:e_commerce_app/features/main/profile/domain/use_cases/profile_use-case.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_state.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileUseCase profileUseCase;
  AddAddressUseCase addAddressUseCase;

  ProfileBloc(this.profileUseCase,this.addAddressUseCase) : super(ProfileInitial()) {
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
      var result = await addAddressUseCase.call( event.name,event.city, event.details,event.phone);
      print("📬 Adding address: ${event.name}, ${event.details}, ${event.phone}, ${event.city}");

      return result.fold((error) {
        print("error response");
        print("❌ Error: $error");

        emit(state.copyWith(
            addAddressRequestState: RequestState.error, addAddressFailures: error));
      }, (result) {
        emit(state.copyWith(
            addAddressRequestState: RequestState.success,
            addressModel: result
        ));
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

  }
}
