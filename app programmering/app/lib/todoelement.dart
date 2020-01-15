import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class TodoScope extends Model{

  List<TodoData> todolist;

}

class TodoData{

  String _titel;
  String _beskrivelse;

  TodoData(this._titel, this._beskrivelse);

  void editTitel(String str){
    _titel = str;
  }

  void editBeskrivelse(String str){
    _beskrivelse = str;
  }

  String getTitel(){
    return _titel;
  }

  String getBeskrivelse(){
    return _beskrivelse;
  }

}

class TodoElement extends StatefulWidget{

  const TodoElement({Key key, this.todoData}): super(key: key);
  final TodoData todoData;

  @override
  _TodoElement createState() => _TodoElement();
}


class _TodoElement extends State<TodoElement>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Text(widget.todoData.getTitel()),
          Text(widget.todoData.getBeskrivelse())
        ],
      ),
    );
  }

}


