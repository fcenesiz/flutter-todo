import 'dart:ffi';

import 'package:todo/domain/resource/resource.dart';
import 'package:todo/domain/util/db_helper.dart';

import '../../model/todo.dart';


abstract class TodoRepository{

  DbHelper dbHelper;

  TodoRepository(this.dbHelper);

  Future<Resource<int>> createTodo(Todo todo);
  Future<Resource<List<Todo>>> retrieveTodos();
  Future<Resource<Todo>> updateTodoById(int id, Todo todo);
  Future<Resource<bool>> deleteTodoById(int id);

}