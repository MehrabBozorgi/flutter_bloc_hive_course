import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../tools/media_query.dart';
import '../../tools/responsive.dart';
import '../../tools/style/radius.dart';
import '../../tools/theme/colors.dart';
import '../logic/bloc/todo_bloc.dart';
import '../model/todo_model.dart';
import '../screens/edit_todo_screen.dart';

class ShowTodosItems extends StatelessWidget {
  const ShowTodosItems({
    super.key,
    required this.helper,
    required this.index,
  });

  final TodoModel helper;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoBloc>();
    final theme = Theme.of(context);
    return Dismissible(
      key: ValueKey(helper.id),
      direction: DismissDirection.horizontal,
      background: Container(
        width: getAllWidth(context),
        height: Responsive.isMobile(context) ? 45 : 75,
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: getWidth(context, 0.03)),
        child: Icon(
          Icons.delete_forever_outlined,
          color: whiteColor,
          size: getWidth(context, 0.07),
        ),
      ),
      secondaryBackground: Container(
        width: getAllWidth(context),
        height: Responsive.isMobile(context) ? 45 : 75,
        color: helper.isDone ? Colors.blue : Colors.green,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: getWidth(context, 0.03)),
        child: Icon(
          helper.isDone ? Icons.refresh : Icons.check,
          color: whiteColor,
          size: getWidth(context, 0.07),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          ///Delete
          bloc.add(DeleteTaskByIndex(index: index));
        } else if (direction == DismissDirection.endToStart) {
          ///done
          bloc.add(DoneTaskTodoEvent(index: index, todoModel: helper));
        }
        return null;
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getWidth(context, 0.03), vertical: getWidth(context, 0.02)),
        margin: EdgeInsets.all(getWidth(context, 0.015)),
        decoration: BoxDecoration(
          color: helper.isDone ? Colors.greenAccent : whiteColor,
          borderRadius: getBorderRadiusWidget(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 5,
                  child: Text(
                    helper.title,
                    style: theme.textTheme.bodyLarge,
                    maxLines: 2,
                  ),
                ),
                Flexible(
                  child: IconButton(
                    onPressed: () {
                      ///navigate
                      Navigator.pushNamed(
                        context,
                        EditTodoScreen.screenId,
                        arguments: [
                          helper.id,
                          helper.title,
                          helper.description,
                          helper.submitDate,
                          helper.goalDate,
                          helper.isDone,
                          index,
                        ],
                      );
                    },
                    icon: Icon(Icons.edit_outlined, color: primaryColor),
                  ),
                ),
              ],
            ),
            Text(helper.description, style: theme.textTheme.bodySmall),
            Container(
              height: getWidth(context, 0.15),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'هدف: ', style: theme.textTheme.labelMedium),
                          TextSpan(text: helper.goalDate, style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'ثبت: ', style: theme.textTheme.labelMedium),
                          TextSpan(text: helper.submitDate, style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}