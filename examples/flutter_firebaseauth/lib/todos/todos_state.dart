import 'package:equatable/equatable.dart';
import 'package:flutter_firebaseauth/todos/model.dart';
import 'package:meta/meta.dart';

class TodosState extends Equatable {

  final bool isLoading;
  final List<Todo> listOfTodoNames;
  final String error;

  TodosState({
    @required this.isLoading,
    @required this.listOfTodoNames,
    @required this.error,
  }) : super([isLoading, listOfTodoNames, error]);

  factory TodosState.initial() {
    return TodosState(
      isLoading: false,
      listOfTodoNames: [],
      error: '',
    );
  }

  TodosState copyWith({
    bool isLoading,
    List<Todo> listOfTodoNames,
    String error,
  }) {
    return TodosState(
      isLoading: isLoading ?? this.isLoading,
      listOfTodoNames: listOfTodoNames ?? this.listOfTodoNames,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'TodoState [isLoading: $isLoading, error: $error, todos: ${listOfTodoNames.length}]';
}
