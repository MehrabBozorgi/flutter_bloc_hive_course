part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class InitialTodoEvent extends TodoEvent {}

class LoadingTodoEvent extends TodoEvent {}

class FetchTaskTodoEvent extends TodoEvent {}

class CompletedTodoEvent extends TodoEvent {
  final List<TodoModel> todoModel;

  CompletedTodoEvent(this.todoModel);
}

class AddTaskTodoEvent extends TodoEvent {
  final String title;
  final String desc;
  final String submitDate;
  final String goalDate;

  AddTaskTodoEvent({
    required this.title,
    required this.desc,
    required this.submitDate,
    required this.goalDate,
  });
}

class EditTaskTodoEvent extends TodoEvent {
  final String id;
  final String title;
  final String desc;
  final String submitDate;
  final String goalDate;
  final bool isDone;
  final int index;

  EditTaskTodoEvent({
    required this.id,
    required this.title,
    required this.desc,
    required this.goalDate,
    required this.submitDate,
    required this.isDone,
    required this.index,
  });
}

class DeleteTaskByIndex extends TodoEvent {
  final int index;

  DeleteTaskByIndex({required this.index});
}

class DeleteAllTaskEvent extends TodoEvent {}

class SortTasksTodoTask extends TodoEvent {
  final Sort sort;

  SortTasksTodoTask({required this.sort});
}

class DoneTaskTodoEvent extends TodoEvent{
  final TodoModel todoModel;
  final int index;

  DoneTaskTodoEvent({required this.index,required this.todoModel});

}