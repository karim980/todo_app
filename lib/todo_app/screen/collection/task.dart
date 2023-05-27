import 'package:cource/todo_app/to%20do%20cubit/cubit.dart';
import 'package:cource/todo_app/to%20do%20cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tasks extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener:(context, state) {

      },
      builder: (context, state) {

        var tasks = ToDoCubit.get(context).tasks;

      return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:const AssetImage('img/Vector-Clock-Transparent-Background-PNG.png') ,
                    radius: 50,
                    child: Text(tasks[index]['time'],style: TextStyle(color: Colors.indigo),),
                  ),
                  const SizedBox(width:20.0 ,),
                  Expanded(
                    child: Container(width: 200,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(tasks[index]['title'], maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text(tasks[index]['date'],style: TextStyle(fontSize: 16,color: Colors.indigo)),
                        ],),
                    ),
                  ),
                  const SizedBox(width:10.0 ,),
                  IconButton(onPressed: (){
                    ToDoCubit.get(context).deletTask(id:tasks[index]['id']);
                  }, icon: Icon(Icons.check_box,color: Colors.green,)),

                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 20, left: 30),
            child: Container(
              width: double.infinity,
              color: Colors.grey[400],
              height: 1,
            ),
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
