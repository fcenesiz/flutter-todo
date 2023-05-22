import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/di/app_module.dart';
import 'package:todo/model/repository/todo_repository_impl.dart';
import '../domain/resource/resource.dart';
import '../model/todo.dart';

class HomeController extends GetxController{

  TextEditingController textController = TextEditingController();
  RxList<Todo> todos = <Todo>[].obs;

  TodoRepositoryImpl repository = TodoRepositoryImpl(AppModule.dbHelper);

  HomeController(){init();}

  void init() async{
    Resource<List<Todo>> resource = await repository.retrieveTodos();
    if(resource.data != null){
      resource.data?.forEach((todo) { todos.add(todo);});
    }
  }

  void insertNew() async{
    if(textController.text == "")
      return;
    Todo todo = Todo(textController.text, 0);

    int id = (await repository.createTodo(todo)).data!!;
    todo.id = id;
    todos.add(todo);
    textController.clear();
    todos.refresh();
  }

  void checkDone(Todo todo, bool value){
    for (int i = 0; i < todos.length; i++) {
      if(todos[i].id == todo.id){
        todos[i].done = value ? 1 : 0;
        todos.refresh();
        repository.updateTodoById(todo.id, todos[i]);
        return;
      }
    }
  }

  void deleteTodo(int id){
    repository.deleteTodoById(id);
    for (var todo in todos) {
      if(todo.id == id){
        todos.remove(todo);
        todos.refresh();
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