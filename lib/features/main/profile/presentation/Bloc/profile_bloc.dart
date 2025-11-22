import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/changePassword.dart';
import 'package:e_commerce_app/features/main/profile/domain/use_cases/add_address_use_case.dart';
import 'package:e_commerce_app/features/main/profile/domain/use_cases/change_password_usecase.dart';
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
  ChangePasswordUseCase changePasswordUseCase;

  ProfileBloc(this.profileUseCase, this.addAddressUseCase,
      this.deleteAddressUseCase, this.changePasswordUseCase)
      : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetData>((event, emit) async {
      emit(state.copyWith(getDataRequestState: RequestState.loading));
      var result = await profileUseCase.call();

      return result.fold((error) {
        print("🔴 Error while fetching profile: $error");
        if (error is UnauthorizedFailure) {
          return  add(LogoutEvent());
        }

        emit(state.copyWith(
            getDataRequestState: RequestState.error, routeFailures: error));
      }, (result) {
        print("🟢 Profile fetched successfully");
        emit(state.copyWith(
            getDataRequestState: RequestState.success, authModel: result));
      });
    });

    on<AddAddress>((event, emit) async {
      emit(state.copyWith(addAddressRequestState: RequestState.loading));
      var result = await addAddressUseCase.call(model: event.model);
      return result.fold((error) {
        print("🔴 Failed to add address: $error");
        if (error is UnauthorizedFailure) {
          return  add(LogoutEvent());
        }
        emit(state.copyWith(
            addAddressRequestState: RequestState.error,
            addAddressFailures: error));
      }, (result) async {
        print("🟢 Address added successfully, refreshing...");
        result.data?.removeWhere((address) => address.id == null);
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
          // await Future.delayed(const Duration(milliseconds: 300));
          // emit(state.copyWith(addAddressRequestState: RequestState.init));
        });
      });
    });

    on<GetAddresses>((event, emit) async {
      emit(state.copyWith(getAddressRequestState: RequestState.loading));
      var result = await addAddressUseCase.getAddress();
      return result.fold((error) {

        print("🔴 Error while fetching addresses: $error");
        if (error is UnauthorizedFailure) {
        return  add(LogoutEvent());
        }
        emit(state.copyWith(
            getAddressRequestState: RequestState.error,
            getAddressFailures: error));
      }, (result) {
        print(
            "🟢 Addresses fetched successfully (${result.data?.length ?? 0})");
        emit(state.copyWith(
            getAddressRequestState: RequestState.success,
            addressModel: result));
      });
    });

    on<LogoutEvent>((event, emit) async {
      print("🔴 Unauthorized! Logging out user...");
      final prefs = await SharedPrefsHelper.getInstance();
      await prefs.clear();
      print("old logout = ${state.isLoggedOut}");
      emit(state.copyWith(isLoggedOut: true));
      print("new logout = ${state.isLoggedOut}");
    });

    on<DeleteAddressEvent>((event, emit) async {
      emit(state.copyWith(deleteAddressRequestState: RequestState.loading));
      var result = await deleteAddressUseCase.deleteAddress(event.id);
      return result.fold((error) {
        print("🔴 Failed to delete address: $error");
        if (error is UnauthorizedFailure) {
          return  add(LogoutEvent());
        }
        emit(state.copyWith(
            deleteAddressRequestState: RequestState.error,
            deleteAddressFailures: error));
      }, (success) async {
        print("🟢 Address deleted successfully, refreshing...");

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

    on<UpdateUserProfileEvent>((event, emit) async {
      emit(state.copyWith(updateProfileRequestState: RequestState.loading));
      final result = await profileUseCase.updateUserProfile(
          name: event.name, email: event.email, phone: event.phone);
      return result.fold((error) {
        print("🔴 Error updating profile: $error");
        if (error is UnauthorizedFailure) {
          return  add(LogoutEvent());
        }
        emit(state.copyWith(
            updateProfileRequestState: RequestState.error,
            updateProfileFailures: error));
      }, (result) async {
        print("🟢 Profile updated successfully");
        print("🟢 ${event.phone}");

        emit(state.copyWith(
            updateProfileRequestState: RequestState.success,
            authModel: result));
        final refreshResult = await profileUseCase.call();
        refreshResult.fold((err) {
          print("🔴 Error while refreshing data after update: $err");

          emit(state.copyWith(
            getDataRequestState: RequestState.error,
            routeFailures: err,
          ));
        }, (freshData) async {
          print("🔁 Profile data refreshed successfully");
          emit(state.copyWith(
            authModel: freshData,
            getDataRequestState: RequestState.success,
          ));
        });
      });
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(state.copyWith(changePasswordRequestState: RequestState.loading));
      var result = await changePasswordUseCase.call(event.model);

      return result.fold((error) {
        print("🔴 Error while changing password: $error");
        if (error is UnauthorizedFailure) {
          return  add(LogoutEvent());
        }
        emit(state.copyWith(
            changePasswordRequestState: RequestState.error,
            changePasswordFailures: error));
      }, (result) async{
        print("🟢 password changed successfully");
        emit(state.copyWith(
            changePasswordRequestState: RequestState.success,
            authModel: result));
        final prefs = await SharedPrefsHelper.getInstance();
        await prefs.clear();
        emit(state.copyWith(isLoggedOut: true));
      });
    });
  }
}
