import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create-user-req.dart';
import 'package:spotify/data/models/auth/signin-user-req.dart';
import 'package:spotify/data/models/auth/user.dart';

abstract class AuthFirebaseService {
  Stream<User?> authStateChanges();

  User? get currentUser;

  Future<Either> signIn(SigninUserReq signinUserReq);

  Future<Either> signUp(CreateUserReq createUserReq);

  Future<void> signOut();

  Future<void> sendPasswordResetEmail(String email);

  Future<Either> getUser();
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
  Future<Either> signIn(SigninUserReq signinUserReq) async {
    try {
      var data = await _firebaseAuth.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );
      
      // Auto-create Firestore document if it doesn't exist (for existing accounts mapped without Firestore)
      if (data.user != null) {
        try {
          var userDoc = await FirebaseFirestore.instance.collection('Users').doc(data.user!.uid).get();
          if (!userDoc.exists) {
            await FirebaseFirestore.instance.collection('Users').doc(data.user!.uid).set({
              'name': data.user!.displayName ?? 'User',
              'email': data.user!.email,
            });
          }
        } catch (e) {
          // If Firestore fails (e.g., missing Google Play Services on emulator or network issue)
          // we still allow the sign in, since authentication succeeded.
          print('Firestore user sync failed: $e');
        }
      }

      return const Right("SignIn successfully");
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'user-not-found') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid email or password';
      } else {
        message = e.message ?? 'SignIn failed';
      }

      return Left(message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      var data = await _firebaseAuth.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password
      );

      try {
        await FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
          'name': createUserReq.name,
          'email': data.user?.email,
        });
      } catch (e) {
        // If Firestore fails (e.g. missing Google Play Services), keep the user authenticated 
        // anyway so the sign up flow isn't entirely blocked.
        print('Firestore user sync failed during signup: $e');
      }

      return const Right("SignUp successfully");
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == "weak-password") {
        message = 'Password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email is already used';
      } else {
        message = e.message ?? 'SignUp failed';
      }
      return Left(message);
    } catch (e) {
       return Left(e.toString());
    }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      var user = await firestore.collection('Users').doc(_firebaseAuth.currentUser?.uid).get();
      if (!user.exists) {
        return const Left('User not found');
      }
      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageURL = _firebaseAuth.currentUser?.photoURL ?? 'https://cdn-icons-png.flaticon.com/512/10542/10542486.png';
      return Right(userModel);
    } catch (e) {
      return const Left('An error occurred');
    }
  }
}
