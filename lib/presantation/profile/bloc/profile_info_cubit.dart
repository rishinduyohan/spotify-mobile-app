import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/data/models/auth/user.dart';
import 'package:spotify/domain/usecases/auth/get_user.dart';
import 'package:spotify/service_locator.dart';

abstract class ProfileInfoState {}

class ProfileInfoLoading extends ProfileInfoState {}

class ProfileInfoLoaded extends ProfileInfoState {
  final UserModel userModel;
  ProfileInfoLoaded({required this.userModel});
}

class ProfileInfoFailure extends ProfileInfoState {}

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await getIt<GetUserInfoUseCase>().call();
    user.fold(
      (l) {
        emit(ProfileInfoFailure());
      },
      (userModel) {
        emit(ProfileInfoLoaded(userModel: userModel));
      }
    );
  }
}
