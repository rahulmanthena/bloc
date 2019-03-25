import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebaseauth/authentication/authentication.dart';
import 'package:flutter_firebaseauth/todos/model.dart';
import 'package:flutter_firebaseauth/todos/todos.dart';

class HomePage extends StatelessWidget {
  final FirebaseUser currentUser;

  const HomePage({Key key, this.currentUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    final TodosBloc _todoBloc = BlocProvider.of<TodosBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<TodosEvent, TodosState>(
        bloc: _todoBloc,
        builder: (context, state) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: state.listOfTodoNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.listOfTodoNames[index].task),
                  );
                },
              ),
              state.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _todoBloc.dispatch(
            AddTodo(
              Todo(
                DateTime.now().toString(),
              ),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      endDrawer: RaisedButton(
        child: Text('logout'),
        onPressed: () {
          authenticationBloc.dispatch(Logout());
        },
      ),
      /*body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome,\n${currentUser.displayName}',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              child: Text('logout'),
              onPressed: () {
                authenticationBloc.dispatch(Logout());
              },
            ),
          ],
        )),
      ),*/
    );
  }
}
