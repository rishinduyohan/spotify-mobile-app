import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create-user-req.dart';

abstract class AuthFirebaseService {
  Stream<User?> authStateChanges();

  User? get currentUser;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  });

  Future<Either> signUp(CreateUserReq createUserReq);

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
  Future<Either> signUp(CreateUserReq createUserReq) async {
   try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: createUserReq.email, password: createUserReq.password) ;
    return const Right("SignUp successfully");

   }on FirebaseException catch(e){
      String message ='';

      if(e.code=="weak-password"){
        message = 'Password provided is too weak';
      }else if(e.code=='email-already-in-use'){
        message='Email is already used';
      }
      return Left(message);
   }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}