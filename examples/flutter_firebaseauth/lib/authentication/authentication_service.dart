import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebaseauth/authentication/authentication_repository.dart';

class FirebaseAuthService {
  FirebaseUser currentUser;
  final UserRepository _userRepository;

  FirebaseAuthService(this._userRepository);

  Future<FirebaseUser> getInitialSignInState() async {
    currentUser = await _userRepository.getInitialSignInState();
    return currentUser;
  }

  Future<FirebaseUser> signIn() async {
    return await _userRepository.signInWithGoogle();
  }

  Future signOut() async {
    return await _userRepository.signOutFromGoogle();
  }
}
