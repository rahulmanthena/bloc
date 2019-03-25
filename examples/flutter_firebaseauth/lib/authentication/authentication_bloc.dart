import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:flutter_firebaseauth/authentication/authentication.dart';
import 'package:flutter_firebaseauth/authentication/authentication_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuthService firebaseAuthService;

  AuthenticationBloc({this.firebaseAuthService});
  @override
  AuthenticationState get initialState => AuthenticationLoading();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final user = await this.firebaseAuthService.getInitialSignInState();
      if (user == null)
        yield AuthenticationUnauthenticated();
      else
        yield AuthenticationAuthenticated(user: user);
    }

    if (event is Login) {
      try {
        yield AuthenticationLoading();
        final user = await this.firebaseAuthService.signIn();

        if (user == null) {
          yield AuthenticationUnauthenticated();
        } else {
          yield AuthenticationAuthenticated(user: user);
        }
      } catch (e) {
        print(e.toString());
        return;
      }
    }

    if (event is Logout) {
      yield AuthenticationLoading();
      //logout user
      await this.firebaseAuthService.signOut();
      yield AuthenticationUnauthenticated();
    }
  }
}
