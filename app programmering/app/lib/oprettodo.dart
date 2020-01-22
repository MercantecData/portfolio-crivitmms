import 'package:app/todoelement.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
      TodoElement td = TodoElement(titel: titelControl.text, beskrivelse: beskrivelsesControl.text,);
      ScopedModel.of<TodoScope>(context).todolist.add(td);
      ScopedModel.of<TodoScope>(context).update();
      ScopedModel.of<TodoScope>(context).save();
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
            Container(
              margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
              child: TextField(
                controller: titelControl,
                decoration: InputDecoration(
                  labelText: 'Titel',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25)
                  )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
              child: TextField(
                controller: beskrivelsesControl,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Beskrivelse',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25)
                  )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25, left: 50, right: 50),
              child: ButtonTheme(
                minWidth: double.infinity,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  child: Text("Gem"),
                  onPressed: opretTodo,
                ),
              ),
            )
          ],
        ),
      )
    );
  }

}






