import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_hive_project/tools/popup/snack_bar_widget.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../tools/media_query.dart';
import '../../tools/popup/awesome_alert.dart';
import '../../tools/responsive.dart';
import '../../tools/text_form_fileds/text_form_field_multi_line.dart';
import '../../tools/text_form_fileds/text_form_field_name.dart';
import '../../tools/theme/colors.dart';
import '../logic/bloc/todo_bloc.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.desc,
    required this.submitDate,
    required this.goalDate,
    required this.isDone,
    required this.index,
  }) : super(key: key);

  final String id;
  final String title;
  final String desc;
  final String submitDate;
  final String goalDate;
  final bool isDone;
  final int index;
  static const String screenId = '/edit_todo_screen';

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final _formValidation = GlobalKey<FormState>();
  Jalali? picked;

  @override
  void initState() {
    _titleController.text = widget.title;
    _descController.text = widget.desc;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('ویرایش وظیفه')),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.todoEvent is CompletedTodoEvent) {
            Navigator.pop(context);
            getSnackBarWidget(context, 'با موفقیت ویرایش شد', Colors.green);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
                      labelText: 'توضیحات',
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
                          backgroundColor: textFieldColor),
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

                      /// if date change, show new date, else show the picked date
                      child: picked == null
                          ? Text(widget.goalDate, style: theme.textTheme.bodyMedium)
                          : Text(picked!.formatCompactDate(),
                              style: theme.textTheme.bodyMedium),
                    ),
                    SizedBox(height: getWidth(context, 0.1)),

                    /// submit button
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
                                EditTaskTodoEvent(
                                  id: widget.id,
                                  title: _titleController.text,
                                  desc: _descController.text,
                                  goalDate: picked == null
                                      ? widget.goalDate
                                      : picked!.formatCompactDate(),
                                  submitDate: Jalali.now().formatCompactDate(),
                                  isDone: widget.isDone,
                                  index: widget.index,
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
          );
        },
      ),
    );
  }
}
