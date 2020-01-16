import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/todoelement.dart';

class TodoList extends StatefulWidget{
  TodoList(this.update);
  final Function update;

  @override
  State<StatefulWidget> createState() {
    return _TodoList();
  }
}

class _TodoList extends State<TodoList>{

  @override
  Widget build(BuildContext context) {
    final List<TodoData> todoList = ScopedModel.of<TodoScope>(context).todolist;
    List<TodoElement> elemtenList = List<TodoElement>();
    final Function update = widget.update;

    todoList.asMap().forEach(
      (index, value) => elemtenList.add(TodoElement(todoData: value,index: index,))
    );

    return ListView(
      children: elemtenList,
    );
  }

}









