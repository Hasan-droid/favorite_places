import 'package:flutter/material.dart';

class newItem extends StatelessWidget {
  const newItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("new item")),
      body: Column(
        children: [
          TextField(decoration: InputDecoration(label: Text("new item"))),
          ElevatedButton(onPressed: () {}, child: Text("add new item")),
        ],
      ),
    );
  }
}
