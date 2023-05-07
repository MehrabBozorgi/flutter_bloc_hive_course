import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_hive_project/tools/media_query.dart';
import 'package:flutter_bloc_hive_project/tools/popup/awesome_alert.dart';
import 'package:flutter_bloc_hive_project/tools/popup/snack_bar_widget.dart';
import 'package:flutter_bloc_hive_project/tools/responsive.dart';
import 'package:flutter_bloc_hive_project/tools/text_form_fileds/text_form_field_multi_line.dart';
import 'package:flutter_bloc_hive_project/tools/text_form_fileds/text_form_field_name.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../tools/theme/colors.dart';
import '../logic/bloc/todo_bloc.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);
  static const String screenId = '/add_todo_screen';

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final _formValidation = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Jalali? picked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('افزودن وظیفه'),
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.todoEvent is CompletedTodoEvent) {
            Navigator.pop(context);
            getSnackBarWidget(context, 'وظیفه با موفقیت اضافه شد', Colors.green);
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formValidation,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.04)),
              child: Column(
                children: [
                  SizedBox(height: getWidth(context, 0.05)),
                  /// title text field
                  TextFormFieldNameWidget(
                    maxLength: 100,
                    labelText: 'عنوان',
                    icon: const Icon(Icons.edit_outlined),
                    textInputAction: TextInputAction.next,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _titleController,
                  ),
                  SizedBox(height: getWidth(context, 0.03)),
                  /// description text field
                  TextFormFieldMultiLine(
                    minLine: 5,
                    maxLine: 8,
                    labelText: 'توصیحات',
                    textInputAction: TextInputAction.newline,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _descController,
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  /// date picker
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        getAllWidth(context),
                        Responsive.isMobile(context) ? 45 : 75,
                      ),
                      backgroundColor: textFieldColor,
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      picked = await showPersianDatePicker(
                        context: context,
                        initialDate: Jalali.now(),
                        firstDate: Jalali(1385, 8),
                        lastDate: Jalali(1450, 9),
                      );
                      setState(() {});
                    },
                    /// if date is not pick show text ,else show date
                    child: picked == null
                        ? Text('تاریخ پیکر', style: theme.textTheme.bodyMedium)
                        : Text(picked!.formatCompactDate(), style: theme.textTheme.bodyMedium),
                  ),
                  SizedBox(height: getWidth(context, 0.1)),

                  ///submit button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        getAllWidth(context),
                        Responsive.isMobile(context) ? 45 : 75,
                      ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (!_formValidation.currentState!.validate()) {
                        alertDialogError(context, 'مشکل', 'برخی از فیلدها خالی می باشند');
                      } else {
                        context.read<TodoBloc>().add(
                              AddTaskTodoEvent(
                                title: _titleController.text,
                                desc: _descController.text,
                                submitDate: Jalali.now().formatCompactDate(),
                                goalDate: picked!.formatCompactDate(),
                              ),
                            );
                      }
                    },
                    child: const Text('ثبت وظیفه'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
