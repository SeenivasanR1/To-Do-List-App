import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/view/todo_listpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListpage(),
    );
  }
}
