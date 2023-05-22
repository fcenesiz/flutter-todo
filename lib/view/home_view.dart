import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:get/get.dart';
import 'package:todo/controller/home_controller.dart';

import '../model/todo.dart';

class HomeView extends StatelessWidget {

  HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: controller.textController,
            decoration: InputDecoration(
              hintText: "content"
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: AlignmentDirectional.centerEnd,
            child: ElevatedButton(
              onPressed: (){
              controller.insertNew();
            },child: Text("Add", style: TextStyle(fontSize: 18),),
            ),
          ),
        ),
        Obx( () {
          return TodoList(controller.todos, controller.options, controller);
        }),

      ],
    );
  }
}

Widget TodoList(List<Todo> todos, Options options, HomeController controller){
  return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: todos.map((todo) =>
          GestureDetector(
            onDoubleTap: (){controller.deleteTodo(todo.id);},
            child: Card(
              shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(todo.content, style: TextStyle(fontSize: 28,
                color: HexColor(RandomColor.getColor(options))
                ),
                ),
              ),),
          )
      ).toList());
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}