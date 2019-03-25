import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Todo extends Equatable {
  final bool complete;
  final String uid;
  final String note;
  final String task;

  Todo(this.task, {String uid, this.complete = false, String note = ''})
      : this.note = note ?? '',
        this.uid = uid,
        super([complete, uid, note, task]);

  Todo copyWith({bool complete, String id, String note, String task}) {
    return Todo(
      task ?? this.task,
      uid: id ?? this.uid,
      complete: complete ?? this.complete,
      note: note ?? this.note,
    );
  }

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $uid }';
  }

  Map<String, dynamic> toMap(String uid) {
    return {
      'task': this.task,
      'id': uid,
      'note': this.note,
      'complete': this.complete,
    };
  }

  static Todo fromMap(Map todo) {
    return Todo(
      todo['task'],
      uid: todo['uid'],
      complete: todo['complete'] ?? false,
      note: todo['note'],
    );
  }
}
