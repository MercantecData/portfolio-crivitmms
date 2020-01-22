import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/localdata.dart';
import 'dart:convert';

class TodoScope extends Model{
  List<TodoElement> todolist = List<TodoElement>();

  final LocalStorage ls = LocalStorage("test.json");

  TodoScope();

  void update(){
    notifyListeners();
  }

  void load() async {
    String str = await ls.read();
    if (str.isNotEmpty) {
      todolist = TodoScope.fromJson(json.decode(str)).todolist;
      update();
    }
  }

  void save() async {
    ls.write(
      json.encode(
        toJson()
      )
    );
  }

  TodoScope.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      todolist = new List<TodoElement>();
      json['list'].forEach((v) {
        todolist.add(_todoElementFromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.todolist != null) {
      data['list'] = this.todolist.map((v) => v.toJson()).toList();
    }
    return data;
  }

  TodoElement _todoElementFromJson(Map<String, dynamic> json) {
    return TodoElement(beskrivelse: json['beskrivelse'], titel: json['titel'], isDone: json['isDone'],);
  }

}

class TodoElement extends StatefulWidget{

  final String titel;
  final String beskrivelse;
  final bool isDone;

  TodoElement({Key key, this.beskrivelse, this.titel, this.isDone = false}): super(key: key);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titel'] = this.titel;
    data['beskrivelse'] = this.beskrivelse;
    data['isDone'] = this.isDone;
    return data;
  }

  @override
  _TodoElement createState() => _TodoElement();
}

class _TodoElement extends State<TodoElement>{
  static const Color color = Colors.blueAccent;

  void fjern(){
    ScopedModel.of<TodoScope>(context).todolist.removeWhere((item) => item.hashCode == widget.hashCode);
    ScopedModel.of<TodoScope>(context).update();
    ScopedModel.of<TodoScope>(context).save();
    Navigator.of(context).pop();
  }

  void popup(){
    showDialog(
      context: context,
      builder: (BuildContext context) => popupside(
        context, 
        widget.titel,
        widget.beskrivelse,
        fjern
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
            widget.titel,
            textAlign: TextAlign.center,
          ),
        ),
      )
    );
  }
}

Widget popupside(BuildContext context, String titel, String beskrivelse, Function fjern) {

  return AlertDialog(
    title: Row(
      children: <Widget>[
        Text(titel),
        FlatButton(
          onPressed: fjern,
          child: Text("Fjern"),
        )
      ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(beskrivelse)
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
