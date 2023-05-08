import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/enums.dart';
import '../../tools/media_query.dart';
import '../../tools/responsive.dart';
import '../logic/bloc/todo_bloc.dart';
import '../model/todo_model.dart';

class FilterModalWidget extends StatelessWidget {
  const FilterModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final helper = context.read<TodoBloc>();
    return Container(
      width: getAllWidth(context),
      height: Responsive.isMobile(context) ? 360 : 460,
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(context, 0.05),
        vertical: getWidth(context, 0.02),
      ),
      child: Column(
        children: [
          ListTileWidget(
              title: 'تاریخ ثبت',
              function: () => helper.add(SortTasksTodoTask(sort: Sort.sortBySubmitDate))),
          ListTileWidget(
              title: 'تاریخ انجام',
              function: () => helper.add(SortTasksTodoTask(sort: Sort.sortByGoalDate))),
          ListTileWidget(
              title: 'انجام شده ها',
              function: () => helper.add(SortTasksTodoTask(sort: Sort.sortByIsDone))),
          ListTileWidget(
              title: 'انجام نشده ها',
              function: () => helper.add(SortTasksTodoTask(sort: Sort.sortByIsNotDone))),
          const DeleteAllButton(),
        ],
      ),
    );
  }
}
class ListTileWidget extends StatelessWidget {
  const ListTileWidget({super.key, required this.title, required this.function});

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          title: Text(title, style: theme.textTheme.bodyMedium),
          onTap: () {
            function();
            Navigator.pop(context);
          },
        ),
        Divider(),
      ],
    );
  }
}

class DeleteAllButton extends StatelessWidget {
  const DeleteAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state.todoEvent is CompletedTodoEvent) {
          final CompletedTodoEvent event = state.todoEvent as CompletedTodoEvent;
          List<TodoModel> todoModel = event.todoModel;
          return todoModel.isEmpty
              ? const SizedBox.shrink()
              : ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              fixedSize:
              Size(getAllWidth(context), Responsive.isMobile(context) ? 45 : 75),
            ),
            onPressed: () {
              ///delete
              context.read<TodoBloc>().add(DeleteAllTaskEvent());
            },
            icon: const Icon(Icons.delete_forever),
            label: Text('حذف وظایف', style: theme.textTheme.titleSmall),
          );
        }
        return Container();
      },
    );
  }
}