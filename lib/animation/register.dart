import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class RegisterView extends StatefulWidget {

  @override
  _RegisterViewState createState() => new _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: new Color(0xfffd347b),
        body: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Container(
                child:new Text("HOLA"),
                alignment: new FractionalOffset(0.5,1.0)
              ),
              new Text("HOLA")
              ]
        )
      );
  }
}