import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebaseauth/authentication/authentication.dart';
import 'package:flutter_firebaseauth/authentication/authentication_repository.dart';
import 'package:flutter_firebaseauth/authentication/authentication_service.dart';
import 'package:flutter_firebaseauth/home_page.dart';
import 'package:flutter_firebaseauth/login_page.dart';
import 'package:flutter_firebaseauth/todos/todos.dart';
import 'package:flutter_firebaseauth/todos/todos_repository.dart';
import 'package:flutter_firebaseauth/todos/todos_service.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;
  TodosBloc _todosBloc;
  TodosService _todosService;
  FirebaseAuthService _firebaseAuthService;
  UserRepository _userRepository;
  TodosRepository _todosRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
    _todosRepository = TodosRepository();
    _firebaseAuthService = FirebaseAuthService(_userRepository);
    _todosService = TodosService(_todosRepository);
    _authenticationBloc =
        AuthenticationBloc(firebaseAuthService: _firebaseAuthService);
    _todosBloc = TodosBloc(todosService:_todosService);
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<AuthenticationBloc>(
          bloc: _authenticationBloc,
        ),
        BlocProvider<TodosBloc>(
          bloc: _todosBloc,
        ),
      ],
      child: MaterialApp(
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationAuthenticated) {
              return HomePage(currentUser: state.user);
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage();
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
