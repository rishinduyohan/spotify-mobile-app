import 'package:spotify/data/models/auth/create_user-req.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> login(String email, String password) async {
    // Implement login logic here
  }

  @override
  Future<void> logout() async {
    // Implement logout logic here
  }

  @override
  Future<void> signup(CreateUserReq createUserReq) async {
    await getIt<AuthFirebaseService>().signUp(createUserReq);
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