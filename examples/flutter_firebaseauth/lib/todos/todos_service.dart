import 'package:flutter_firebaseauth/todos/model.dart';
import 'package:flutter_firebaseauth/todos/todos_repository.dart';

class TodosService {
  TodosRepository _todosRepository;
  String userUid;

  TodosService(this._todosRepository);

  Future<void> createTodo(Todo todo) async {
    return _todosRepository.createTodo(userUid, todo);
  }

  Stream<List<Todo>> streamOfTodos() {
    return _todosRepository.streamOfTodos(userUid);
  }
}
