import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_firebaseauth/todos/model.dart';
import 'package:flutter_firebaseauth/todos/todos_event.dart';
import 'package:flutter_firebaseauth/todos/todos_repository.dart';
import 'package:flutter_firebaseauth/todos/todos_service.dart';
import 'package:flutter_firebaseauth/todos/todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosService todosService;
  StreamSubscription _subscription;

  TodosBloc({this.todosService}) {
    _subscription = this.todosService.streamOfTodos().listen((todos) {
      todos?.forEach((todo) {
        dispatch(SyncTodo(todo));
      });
    });
  }

  @override
  TodosState get initialState => TodosState.initial();

  @override
  void onTransition(Transition<TodosEvent, TodosState> transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is AddTodo) {
      yield currentState.copyWith(isLoading: true);
      await todosService.createTodo(event.todo);
    }

    if (event is SyncTodo) {
      List<Todo> _listOfTodoNames = currentState.listOfTodoNames
        ..add(event.todo);
      yield currentState.copyWith(
          isLoading: false, listOfTodoNames: _listOfTodoNames);
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
