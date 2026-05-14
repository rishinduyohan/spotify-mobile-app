import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/domain/usecases/auth/signin.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerLazySingleton<AuthFirebaseService>(
    () => AuthFirebaseServiceImpl(),
  );
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<SignupUseCase>(() => SignupUseCase());
    getIt.registerLazySingleton<SigninUseCase>(() => SigninUseCase());

}
