import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class TodoScope extends Model{
  List<TodoData> todolist = List<TodoData>();
}

class TodoData{
  String titel;
  String beskrivelse;
  bool isDone = false;

  TodoData(this.titel, this.beskrivelse);
}

class TodoElement extends StatefulWidget{

  final TodoData todoData;
  final int index;
  final Function update;

  const TodoElement({Key key, this.todoData, this.index, this.update}): super(key: key);

  @override
  _TodoElement createState() => _TodoElement();
}

class _TodoElement extends State<TodoElement>{

  Color color = Colors.blueAccent;

  void delete(){
    Navigator.of(context).pop();
    ScopedModel.of<TodoScope>(context).todolist.removeAt(widget.index);
    widget.update();
  }

  void popup(){
    showDialog(
      context: context,
      builder: (BuildContext context) => popupside(
        context, 
        widget.todoData,
        delete
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: popup,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
              width: 2
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Text(
            widget.todoData.titel,
            textAlign: TextAlign.center,
          ),
        ),
      )
    );
  }
}

Widget popupside(BuildContext context, TodoData todoData, Function funck) {

  return AlertDialog(
    title: Row(
      children: <Widget>[
        Text(todoData.titel),
        FlatButton(
          onPressed: funck,
          child: Text("Fjern"),
        )
      ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(todoData.beskrivelse)
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text("Tilbage"),
      )
    ],
  );
}
