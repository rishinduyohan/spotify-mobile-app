import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create-user-req.dart';
import 'package:spotify/data/models/auth/signin-user-req.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signIn(SigninUserReq signinUserReq) async {
    return await getIt<AuthFirebaseService>().signIn(signinUserReq);
  }

  @override
  Future<void> logout() async {
    // Implement logout logic here
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await getIt<AuthFirebaseService>().signUp(createUserReq);
  }

  @override
  Future<bool> isAuthenticated() async {
    // Implement authentication check logic here
    return false;
  }

  @override
  Future<String?> getAccessToken() async {
    // Implement access token retrieval logic here
    return null;
  }
}