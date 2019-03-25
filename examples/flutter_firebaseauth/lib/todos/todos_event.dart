import 'package:equatable/equatable.dart';
import 'package:flutter_firebaseauth/todos/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosEvent extends Equatable {
  TodosEvent([List props = const []]) : super(props);
}

class AddTodo extends TodosEvent {
  final Todo todo;

  AddTodo(this.todo): super([todo]);
}

class SyncTodo extends TodosEvent {
  final Todo todo;

  SyncTodo(this.todo) : super([todo]);
}
