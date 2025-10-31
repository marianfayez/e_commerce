import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/main/profile/domain/use_cases/profile_use-case.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_state.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileUseCase profileUseCase;

  ProfileBloc(this.profileUseCase) : super(ProfileInitial()) {
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
        print("✅ success response with user data: ${result.user?.name}");
        emit(state.copyWith(
          getDataRequestState: RequestState.success,
          authModel: result
        ));
      });
    });
  }
}
