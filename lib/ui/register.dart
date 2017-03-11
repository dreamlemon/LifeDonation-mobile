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
        body: new Container(
          child: new Stepper(
            steps: [
              new Step(
                title: new Text("Nombre"),
                content: new Text("Hosac")
              ),
              new Step(
                title: new Text("Apellido"),
                content: new Text("Hosac")
              ),
              new Step(
                title: new Text("Tipo de sangre"),
                content: new Text("Hosac")
              )
            ]
          ),
          margin: new EdgeInsets.all(15.0)
        )
      );
  }
}