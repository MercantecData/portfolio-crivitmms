import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/todoelement.dart';

class OpretTodo extends StatefulWidget{

  @override
  _OpretTodo createState()=> _OpretTodo();
}


class _OpretTodo extends State{

  final titelControl = TextEditingController();
  final beskrivelsesControl = TextEditingController();
  bool fejlBeskedBool = false;
  String fejlBesked = "";

  @override
  void dispose(){
    titelControl.dispose();
    beskrivelsesControl.dispose();
    super.dispose();
  }

  void opretTodo(){
    if (titelControl.text.length <= 3) {
      setState(() {
        fejlBesked = "Angiv en titel på mere end 3 tegn";
        fejlBeskedBool = true;
      });
    }else{
      TodoScope scope = ScopedModel.of<TodoScope>(context);
      TodoData td = TodoData(titelControl.text, beskrivelsesControl.text);
      scope.todolist.add(td);
      Navigator.pop(context);
    }
  }

  Widget fejlBeskedWidget(){
    if (fejlBeskedBool) {
      return Text(fejlBesked);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Opret todo"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            fejlBeskedWidget(),
            TextField(
              controller: titelControl,
              decoration: InputDecoration(
                labelText: 'Titel'
              ),
            ),
            TextField(
              controller: beskrivelsesControl,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Beskrivelse'
              ),
            ),
            FlatButton(
              onPressed: opretTodo,
              child: Text("Gem"),
            )
          ],
        ),
      )
    );
  }

}






