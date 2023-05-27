import 'package:flutter/material.dart';

class GridViewScreen extends StatelessWidget {
  Widget _info({
    required Color color1,
    required Color color2,
    required text}) =>
      Container(
        child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 23),
            )),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              color1.withOpacity(0.5),
              color2
            ], begin:Alignment.topLeft, end:Alignment.bottomRight,),
            borderRadius: BorderRadius.circular(25)
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: EdgeInsets.only(top: 20),
          child: GridView(
            children: <Widget>[
              _info(color1: Colors.red ,color2: Colors.red, text: 'text1'),

            ],
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
          )),
    );
  }
}
