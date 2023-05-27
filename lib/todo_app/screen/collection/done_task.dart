import 'package:flutter/material.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('Soon...',style: TextStyle(fontSize: 26),))
      ],
    );
  }
}
