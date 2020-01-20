import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TodoScope extends Model{
  List<TodoElement> todolist = List<TodoElement>();

  void update(){
    todolist.asMap().forEach(
      (index,value){
        todolist[index].index = index;
      }
    );
    notifyListeners();
  }

}

class TodoElement extends StatefulWidget{

  final String titel;
  final String beskrivelse;
  final bool isDone = false;
  int index;
  

  TodoElement({Key key, this.beskrivelse, this.titel}): super(key: key);

  @override
  _TodoElement createState() => _TodoElement();
}

class _TodoElement extends State<TodoElement>{
  static const Color color = Colors.blueAccent;

  void fjern(){
    ScopedModel.of<TodoScope>(context).todolist.removeAt(widget.index);
    ScopedModel.of<TodoScope>(context).update();
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
