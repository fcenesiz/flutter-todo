import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:get/get.dart';
import 'package:todo/di/app_module.dart';
import 'package:todo/model/repository/todo_repository_impl.dart';
import '../domain/resource/resource.dart';
import '../model/todo.dart';

class HomeController extends GetxController{

  Options options = Options(format: Format.hex, luminosity: Luminosity.dark, alpha: 0.5);
  TextEditingController textController = TextEditingController();
  List<Todo> todos = <Todo>[].obs;

  TodoRepositoryImpl repository = TodoRepositoryImpl(AppModule.dbHelper);

  HomeController(){init();}

  void init() async{
    Resource<List<Todo>> resource = await repository.retrieveTodos();
    if(resource.data != null){
      resource.data?.forEach((element) { todos.add(element);});
    }
    print("todos:");
    print("todos = $todos");
  }

  void insertNew(){
    if(textController.text == "")
      return;
    Todo todo = Todo(textController.text, 0);
    todos.add(todo);
    repository.createTodo(todo);
    textController.clear();
  }

  void deleteTodo(int id){
    repository.deleteTodoById(id);
    for (var todo in todos) {
      if(todo.id == id){
        todos.remove(todo);
        return;
      }
    }
  }

  void navigateToCreateTodoScreen(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Container()),
    );
  }

}