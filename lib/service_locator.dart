import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
 
 getIt.registerLazySingleton<AuthFirebaseService>(() => AuthFirebaseServiceImpl());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());


}