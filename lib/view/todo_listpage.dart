import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/todo_controller.dart';

class TodoListpage extends StatefulWidget {
  const TodoListpage({super.key});

  @override
  State<TodoListpage> createState() => _TodoListpageState();
}

class _TodoListpageState extends State<TodoListpage> {
  final ToDoController controller = Get.put(ToDoController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();

 void showAddDialog() {
    Get.defaultDialog(
      title: "Add To-Do",
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: subTitleController,
            decoration: const InputDecoration(labelText: "Sub Title"),
          ),
        ],
      ),
      textConfirm: "Add",
      onConfirm: () {
        if (titleController.text.isNotEmpty && subTitleController.text.isNotEmpty) {
          controller.addTodo(titleController.text, subTitleController.text);
          titleController.clear();
          subTitleController.clear();
          Get.back();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
      ),
      body:  Obx(() => ListView.builder(
            itemCount: controller.todoList.length,
            itemBuilder: (context, index) {
              final todo = controller.todoList[index];

              return Dismissible(
                key: Key(todo.title), // Unique key for each item
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  controller.deleteTodo(index);
                },
                child: ListTile(
                  title: Text(todo.title,
                      style: TextStyle(
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null)),
                  subtitle: Text(todo.subTitle),
                  trailing: Icon(
                    todo.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                    color: todo.isCompleted ? Colors.green : Colors.grey,
                  ),
                  onTap: () {
                    controller.toggle(index);
                  },
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade100,
        onPressed: showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}


