import 'package:flutter/material.dart';

class OpretTodo extends StatefulWidget{

  @override
  _OpretTodo createState()=> _OpretTodo();
}


class _OpretTodo extends State{

  final titelControl = TextEditingController();
  final beskrivelsesControl = TextEditingController();

  @override
  void dispose(){
    titelControl.dispose();
    beskrivelsesControl.dispose();
    super.dispose();
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
              onPressed: null,
              child: Text("Gem"),
            )
          ],
        ),
      )
    );
  }

}






