import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cource/todo_app/screen/collection/important.dart';
import 'package:cource/todo_app/screen/collection/done_task.dart';
import 'package:cource/todo_app/screen/collection/task.dart';
import 'package:cource/todo_app/to%20do%20cubit/cubit.dart';
import 'package:cource/todo_app/to%20do%20cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../core/constants.dart';
import '../widget/def_form_field.dart';

class ToDOHomeScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ToDoCubit()..createDatabase(),
      child: BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (BuildContext context, ToDoStates state) {
          if (state is AppInsertDatabase) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, ToDoStates state) {
          ToDoCubit cubit = ToDoCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text('To Do List'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomsheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                      );
                      // insertToDatabase(
                      //   title: titleController.text,
                      //   time: timeController.text,
                      //   date: dateController.text,
                      // ).then((value) {
                      //   getDateFromDatabase(database).then((value) {
                      //     Navigator.pop(context);
                      //     // setState((){
                      //     //   isBottomsheetShown = false;
                      //     //   fabIcon = Icons.edit;
                      //     //
                      //     //   tasks=value;
                      //     //   debugPrint(tasks.toString());
                      //     // });
                      //     debugPrint('database opened');
                      //   });
                      //   debugPrint(value.toString());
                      // }).catchError((error) {
                      //   debugPrint(error.toString());
                      // });
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                            (context) => Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ReusableTextFormField(
                                          labelText: 'Task Title',
                                          prefixIcon: Icons.title,
                                          keyboardType: TextInputType.text,
                                          hintText: 'example',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'title must not be empty';
                                            }
                                            return null;
                                          },
                                          controller: titleController,
                                          onTap: () {},
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ReusableTextFormField(
                                          labelText: 'Task Time',
                                          prefixIcon: Icons.access_time,
                                          keyboardType: TextInputType.datetime,
                                          hintText: '12:00 pm',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'time must not be empty';
                                            }
                                            return null;
                                          },
                                          controller: timeController,
                                          onTap: () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now())
                                                .then((value) {
                                              timeController.text =
                                                  value!.format(context);
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ReusableTextFormField(
                                          labelText: 'Task Date',
                                          prefixIcon: Icons.date_range,
                                          keyboardType: TextInputType.datetime,
                                          hintText: '15/5/2030',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'time must not be empty';
                                            }
                                            return null;
                                          },
                                          controller: dateController,
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2030),
                                            ).then((value) {
                                              dateController.text =
                                                  DateFormat.yMMMd()
                                                      .format(value!);
                                            }).catchError((error) {});
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            elevation: 30)
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    });

                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  }
                },
                child: Icon(cubit.fabIcon),
              ),
              body: ConditionalBuilder(
                condition: state is! AppGetDatabaseLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) => Center(child: CircularProgressIndicator(),),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list_alt,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.done_outline_sharp),
                    label: 'Done Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Important',
                  ),
                ],
              ));
        },
      ),
    );
  }
}
