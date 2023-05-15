import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../constant/enums.dart';
import '../../../constant/hive.dart';
import '../../model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState(todoEvent: InitialTodoEvent())) {
    on<FetchTaskTodoEvent>(_fetchTask);
    on<AddTaskTodoEvent>(_addTask);
    on<EditTaskTodoEvent>(_editTask);
    on<DeleteTaskByIndex>(_deleteByIndexTask);
    on<DeleteAllTaskEvent>(_deleteAll);
    on<SortTasksTodoTask>(_sortTask);
    on<DoneTaskTodoEvent>(_doneTask);
  }

  FutureOr<void> _fetchTask(FetchTaskTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(todoEvent: LoadingTodoEvent()));

    await Hive.openBox<TodoModel>(boxName);

    final box = Hive.box<TodoModel>(boxName);

    emit(state.copyWith(todoEvent: CompletedTodoEvent(box.values.toList())));
  }

  FutureOr<void> _addTask(AddTaskTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(todoEvent: LoadingTodoEvent()));
    final box = Hive.box<TodoModel>(boxName);

    final value = TodoModel(
      id: const Uuid().v1(),
      title: event.title,
      description: event.desc,
      submitDate: event.submitDate,
      goalDate: event.goalDate,
      isDone: false,
    );
    await box.add(value);

    emit(state.copyWith(todoEvent: CompletedTodoEvent(box.values.toList())));
  }

  FutureOr<void> _editTask(EditTaskTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(todoEvent: LoadingTodoEvent()));
    final box = Hive.box<TodoModel>(boxName);

    final value = TodoModel(
      id: event.id,
      title: event.title,
      description: event.desc,
      submitDate: event.submitDate,
      goalDate: event.goalDate,
      isDone: event.isDone,
    );

    box.putAt(event.index, value);
    emit(state.copyWith(todoEvent: CompletedTodoEvent(box.values.toList())));
  }

  FutureOr<void> _deleteByIndexTask(DeleteTaskByIndex event, Emitter<TodoState> emit) {
    emit(state.copyWith(todoEvent: LoadingTodoEvent()));
    final box = Hive.box<TodoModel>(boxName);
    box.deleteAt(event.index);
    emit(state.copyWith(todoEvent: CompletedTodoEvent(box.values.toList())));
  }

  FutureOr<void> _deleteAll(DeleteAllTaskEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(todoEvent: LoadingTodoEvent()));
    final box = Hive.box<TodoModel>(boxName);

    await box.clear();
    emit(state.copyWith(todoEvent: CompletedTodoEvent(box.values.toList())));
  }

  FutureOr<void> _sortTask(SortTasksTodoTask event, Emitter<TodoState> emit) {
    emit(state.copyWith(todoEvent: LoadingTodoEvent()));
    final box = Hive.box<TodoModel>(boxName);

    if (event.sort == Sort.sortByGoalDate) {
      final sortedList = box.values.toList()..sort((a, b) => a.goalDate.compareTo(b.goalDate));

      emit(state.copyWith(todoEvent: CompletedTodoEvent(sortedList)));
    } else if (event.sort == Sort.sortBySubmitDate) {
      final sortedList = box.values.toList()
        ..sort((a, b) => a.submitDate.compareTo(b.submitDate));

      emit(state.copyWith(todoEvent: CompletedTodoEvent(sortedList)));
    } else if (event.sort == Sort.sortByIsDone) {
      final sortedList = box.values.toList()..sort((a, b) => a.isDone ? -1 : 1);

      emit(state.copyWith(todoEvent: CompletedTodoEvent(sortedList)));
    } else if (event.sort == Sort.sortByIsNotDone) {
      final sortedList = box.values.toList()..sort((a, b) => a.isDone ? 1 : -1);

      emit(state.copyWith(todoEvent: CompletedTodoEvent(sortedList)));
    }
  }

  FutureOr<void> _doneTask(DoneTaskTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(todoEvent: LoadingTodoEvent()));
    final box = Hive.box<TodoModel>(boxName);

    final value = TodoModel(
      id: event.todoModel.id,
      title: event.todoModel.title,
      description: event.todoModel.description,
      submitDate: event.todoModel.submitDate,
      goalDate: event.todoModel.goalDate,
      isDone: event.todoModel.isDone ? false : true,
    );
    await box.put(event.index, value);
    emit(state.copyWith(todoEvent: CompletedTodoEvent(box.values.toList())));
  }
}
