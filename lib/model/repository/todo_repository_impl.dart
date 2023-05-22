import 'dart:ffi';

import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/di/app_module.dart';
import 'package:todo/domain/repository/todo_repository.dart';
import 'package:todo/domain/resource/resource.dart';
import 'package:todo/domain/util/db_helper.dart';
import 'package:todo/model/todo.dart';

class TodoRepositoryImpl extends TodoRepository{
  
  TodoRepositoryImpl(super.dbHelper);

  @override
  Future<Resource<int>> createTodo(Todo todo) async{
    Database db = dbHelper.db;

    int id = 0;
    try{
      id = await db.insert(DbHelper.DATABASE_NAME, todo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace
      );
    }on Exception catch(e){
      return Failure(e.toString());
    }
    return Success(id);
  }

  @override
  Future<Resource<List<Todo>>> retrieveTodos() async{
    Database db = dbHelper.db;

    late List<Todo> todos;

    try{
      final List<Map<String,dynamic>> maps = await db.query(DbHelper.DATABASE_NAME);

      todos = List.generate(maps.length, (i) =>
          Todo.withId(id: maps[i]["id"], content: maps[i]["content"], done: maps[i]["done"])
      );
    }on Exception catch(e){
      return Failure(e.toString());
    }
    return Success(todos);
  }

  @override
  Future<Resource<bool>> deleteTodoById(int id) async{
    Database db = dbHelper.db;
    
    bool isRemoved = false;
    try{
      await db.delete(DbHelper.DATABASE_NAME, where: "id = ?", whereArgs: [id]);
      isRemoved = true;
    }on Exception catch(e){
      return Failure(e.toString());
    }
    return Success(isRemoved);
  }

  @override
  Future<Resource<Todo>> updateTodoById(int id, Todo todo) async{
    Database db = dbHelper.db;

    try{
      await db.update(DbHelper.DATABASE_NAME, todo.toMap(), where: "id = ?", whereArgs: [todo.id]);
    }on Exception catch(e){
      return Failure(e.toString());
    }
    return Success(todo);

  }



}