import 'package:flutter/material.dart';
import 'todoelement.dart';
import 'oprettodo.dart';
import 'package:scoped_model/scoped_model.dart';


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

  void update(){
    _todolist = ScopedModel.of<TodoScope>(context).todolist; 
    setState(() {
      List<Widget> newlist = new List();
      _todolist.asMap().forEach(
        (index, value){
          newlist.add(value);
        });
      list = ListView(children: newlist ?? [Text("ingen todo")]);
    });
  }

  List<Widget> _todolist;
  ListView list;

  @override
  void initState() {
    ScopedModel.of<TodoScope>(context).load();
    ScopedModel.of<TodoScope>(context).addListener(update);
    _todolist = ScopedModel.of<TodoScope>(context).todolist; 
    super.initState();
  }

  @override
  void dispose() {
    ScopedModel.of<TodoScope>(context).removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: Center(
        child: list ?? Text("ingen todo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigate,
        tooltip: 'Ny todo',
        child: Icon(Icons.add),
      ),
    );
  }
}

