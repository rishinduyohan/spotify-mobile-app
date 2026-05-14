import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create-user-req.dart';
import 'package:spotify/data/models/auth/signin-user-req.dart';

abstract class AuthRepository {
  Future<void> logout();
  Future<Either> signIn(SigninUserReq signinUserReq);
  Future<Either> signup(CreateUserReq createUserReq);
  Future<bool> isAuthenticated();
  Future<String?> getAccessToken();
}