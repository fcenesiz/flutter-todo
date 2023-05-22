import 'package:flutter/material.dart';
import 'package:todo/di/app_module.dart';
import 'package:todo/view/home_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppModule.dbHelper.init();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Todos"),
        ),
        body: HomeView(),
      ),
    );
  }
}