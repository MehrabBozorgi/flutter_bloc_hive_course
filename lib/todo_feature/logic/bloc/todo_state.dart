part of 'todo_bloc.dart';

class TodoState {
  final TodoEvent todoEvent;

  TodoState({required this.todoEvent});

  TodoState copyWith({TodoEvent? todoEvent}) {
    return TodoState(todoEvent: todoEvent ?? this.todoEvent);
  }


}
