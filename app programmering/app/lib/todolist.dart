import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/todoelement.dart';

class TodoList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _TodoList();
  }
}

class _TodoList extends State{


  @override
  Widget build(BuildContext context) {
    List<TodoData> todoList = ScopedModel.of<TodoScope>(context).todolist;
    List<TodoElement> elemtenList = List<TodoElement>();
    for (TodoData item in todoList) {
      elemtenList.add(TodoElement(todoData: item));
    }

    return ListView(
      children: elemtenList,
    );
  }

}









