import 'package:flutter/material.dart';
import 'todoelement.dart';
import 'oprettodo/oprettodo.dart';
import 'package:scoped_model/scoped_model.dart';
import 'todolist.dart';


void main(){
  
  TodoScope todoScope = TodoScope();

  runApp(
    ScopedModel<TodoScope>(
      model: todoScope,
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void navigate(){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => OpretTodo())
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: Center(
        child: TodoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigate,
        tooltip: 'Ny todo',
        child: Icon(Icons.add),
      ),
    );
  }
}

