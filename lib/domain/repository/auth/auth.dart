import 'package:spotify/data/models/auth/create_user-req.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> signup(CreateUserReq createUserReq);
  Future<bool> isAuthenticated();
  Future<String?> getAccessToken();
}