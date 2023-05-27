import 'package:flutter/material.dart';

import '../model/model.dart';
import '../repository/database_repository.dart';
import '../widget/todo_widget.dart';
import 'add_todo_screen.dart';


class AppToDoHomeScreen extends StatefulWidget {
  const AppToDoHomeScreen({Key? key}) : super(key: key);

  @override
  State<AppToDoHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AppToDoHomeScreen> {
  @override
  void initState() {
    initDb();
    getTodos();
    super.initState();
  }

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  List<ToDoModel> myTodos = [];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getTodos();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: gotoAddScreen,
        ),
        appBar: AppBar(
          title: const Text('My todos'),
        ),
        body: myTodos.isEmpty
            ? const Center(child: const Text('You don\'t have any todos yet'))
            : ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final todo = myTodos[index];
                  return TodoWidget(
                    todo: todo,
                    onDeletePressed: () {
                      delete(todo: todo, context: context);
                      getTodos();
                    },
                  );
                },
                itemCount: myTodos.length,
              ),
      ),
    );
  }

  void getTodos() async {
    await DatabaseRepository.instance.getAllTodos().then((value) {
      setState(() {
        myTodos = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }

  void gotoAddScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddTodoScreen();
    }));
  }

  void delete({required ToDoModel todo, required BuildContext context}) async {
    DatabaseRepository.instance.delete(todo.id!).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Deleted')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}
