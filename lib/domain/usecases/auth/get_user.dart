import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class GetUserInfoUseCase implements UseCase<Either,dynamic> {

  @override
  Future<Either> call({params}) async {
    return await getIt<AuthRepository>().getUser();
  }
}
