import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebaseauth/todos/model.dart';

class TodosRepository {
  final _firestore = Firestore.instance;
  final String todoCollection = 'todos';

  Future<void> createTodo(String userUid, Todo todo) async {
    try {
      DocumentReference doc =
          _firestore.collection(todoCollection).document('userUid');
      await doc.setData({
        'todos': FieldValue.arrayUnion([todo.toMap(doc.documentID)])
      }, merge: true);
    } catch (error) {
      throw error;
    }
  }

  Stream<List<Todo>> streamOfTodos(String userUid) {
    try {
      return _firestore
          .collection(todoCollection)
          .document('userUid')
          .snapshots()
          .map((snapshot) {
        List<Todo> list = [];
        snapshot.data['todos'].forEach((v){
          list.add(Todo.fromMap(v));
        });
        return list;
      });
    } catch (error) {
      throw error;
    }
  }
}
