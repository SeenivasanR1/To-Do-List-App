import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model class/todo_model.dart';

class ToDoController extends GetxController {
  RxList<ToDoModel> todoList = <ToDoModel>[].obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void addTodo(String title, String subTitle) {
    todoList.add(ToDoModel(title: title, subTitle: subTitle));
    saveData();
  }

  void deleteTodo(int index) {
    todoList.removeAt(index);
    saveData();
  }

  void toggle(int index) {
    todoList[index].isCompleted = !todoList[index].isCompleted;
    todoList.refresh();
    saveData();
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        todoList.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList('todo_list', jsonList);
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('todo_list');

    todoList.value =
        jsonList!.map((item) => ToDoModel.fromJson(jsonDecode(item))).toList();
  }
}
