import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_hive_project/todo_feature/logic/bloc/todo_bloc.dart';
import 'package:flutter_bloc_hive_project/todo_feature/model/todo_model.dart';
import 'package:flutter_bloc_hive_project/todo_feature/screens/add_todo_screen.dart';
import 'package:flutter_bloc_hive_project/tools/loading_widget.dart';
import 'package:flutter_bloc_hive_project/tools/style/shapes.dart';
import 'package:flutter_bloc_hive_project/tools/theme/colors.dart';

import '../widget/empty_widget.dart';
import '../widget/filter_widget.dart';
import '../widget/show_todos_item.dart';

class ShowTodoScreen extends StatefulWidget {
  const ShowTodoScreen({Key? key}) : super(key: key);
  static const String screenId = '/show_todo_screen';

  @override
  State<ShowTodoScreen> createState() => _ShowTodoScreenState();
}

class _ShowTodoScreenState extends State<ShowTodoScreen> {
  @override
  void initState() {
    context.read<TodoBloc>().add(FetchTaskTodoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddTodoScreen.screenId);
        },
        child: const Icon(Icons.add,color: whiteColor,),
      ),
      appBar: AppBar(
        title: const Text('وظایف من'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: getTopShapeWidget(10),
                backgroundColor: whiteColor,
                useSafeArea: true,
                builder: (context) {
                  return const FilterModalWidget();
                },
              );
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.todoEvent is LoadingTodoEvent) {
            return const LoadingWidget();
          }
          if (state.todoEvent is CompletedTodoEvent) {
            final CompletedTodoEvent event = state.todoEvent as CompletedTodoEvent;
            List<TodoModel> todoModel = event.todoModel;
            return todoModel.isEmpty
                ? const EmptyWidget()
                : ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: todoModel.length,
                    itemBuilder: (context, index) {
                      final helper = todoModel[index];
                      return ShowTodosItems(helper: helper, index: index);
                    },
                  );
          }

          return Container();
        },
      ),
    );
  }
}
