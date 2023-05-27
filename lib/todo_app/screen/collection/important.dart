import 'package:flutter/material.dart';

class Important extends StatelessWidget {
  const Important({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('صلي علي النبي',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),))
      ],
    );
  }
}
