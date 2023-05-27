import 'package:cource/multi%20screen/Screen1.dart';
import 'package:cource/multi%20screen/scrren2.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void selectScreen(BuildContext cx,int screen) {
    Navigator.of(cx).push(MaterialPageRoute(builder: (_) {
     if(screen==1) return Screen1();
     return Screen2();

    }

    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () => selectScreen(context,1),
                child: Text('Go to Screen 1', style: TextStyle(fontSize: 30))),
            SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () => selectScreen(context,2),
                child: Text('Go to Screen 2', style: TextStyle(fontSize: 30))),
          ],
        ),
      ),
    );
  }
}
