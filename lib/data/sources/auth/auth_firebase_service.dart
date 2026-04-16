import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user-req.dart';

abstract class AuthFirebaseService {
  Stream<User?> authStateChanges();

  User? get currentUser;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  });

  Future<UserCredential> signUp(CreateUserReq createUserReq);

  Future<void> signOut();

  Future<void> sendPasswordResetEmail(String email);
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  final FirebaseAuth _firebaseAuth;

  AuthFirebaseServiceImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> signUp(CreateUserReq createUserReq) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: createUserReq.email,
      password: createUserReq.password,
    );
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}