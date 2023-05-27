import 'package:bloc/bloc.dart';
import 'package:cource/todo_app/to%20do%20cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../screen/collection/important.dart';
import '../screen/collection/done_task.dart';
import '../screen/collection/task.dart';

class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(ToDoInitialState());

  static ToDoCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [Tasks(), DoneTasks(), Important()];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;

  List<Map> tasks = [];

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      debugPrint('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT, time TEXT, status TEXT)')
          .then((value) {
        debugPrint('table create');
      }).catchError((error) {
        debugPrint('error when creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      getDateFromDatabase(database).then((value) {
        tasks = value;
        debugPrint(tasks.toString());
        emit(AppGetDatabase());
      });
      debugPrint('database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    final database = this.database;
    if (database != null) {
      await database.transaction((txn) {
        txn
            .rawInsert(
                'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
            .then((value) {
          debugPrint('inserted1: $value');
          emit(AppInsertDatabase());

          getDateFromDatabase(database).then((value) {
            tasks = value;
            debugPrint(tasks.toString());
            emit(AppGetDatabase());
          });
        }).catchError((error) {
          debugPrint('errorr: ${error.toString()}');
        });
        return Future(() => null);
      });
    } else {
      debugPrint('Error: database isnull');
    }
  }

  Future<List<Map>> getDateFromDatabase(database) async {
    emit(AppGetDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM tasks');
  }

  void deletAllFormDatabase(database) async {
    await database.rawDelete('DELETE FROM tasks');
  }
  void deletTask({required int id}) async {
    await database?.rawDelete('DELETE FROM tasks WHERE id = $id');
    emit(AppDeleteDatabase());
    getDateFromDatabase(database).then((value) {
      tasks = value;
      debugPrint(tasks.toString());
      emit(AppGetDatabase());
    });
  }

  void updateData(
      {
    required String status,
    required int id,
}) async {
   database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      emit(AppUpdateDatabase());

   });

  }

  bool isBottomsheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomsheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
