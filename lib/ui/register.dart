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

  int _currentStepPosition = 0;

  String name;
  String ubication;
  int bloodType;

  String dropdown1Value = ' --- ';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
          children: [
            new Container(
              child: new Image.asset(
                  'assets/blood_trans.png',
                  width: 85.0
              ),
              margin: new EdgeInsets.all(60.0)
            ),
            new Container(
                child: new Stepper(
                    currentStep: _currentStepPosition,
                    steps: [
                      new Step(
                          title: new Text("¿Como te vamos a llamar?"),
                          content: new Input()
                      ),
                      new Step(
                          title: new Text("¿Donde vives?"),
                          content: new Input()
                      ),
                      new Step(
                          title: new Text("¿Conoces tu sangre?"),
                          content: new Container(
                              child: new DropdownButton<String>(
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdown1Value = newValue;
                                    });
                                  },
                                  items: <String>['AB+', 'AB-', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-'].map((String value) {
                                    return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                    );
                                  }).toList())
                          )
                      )
                    ],
                    onStepContinue: () {
                      setState(() {
                        if(_currentStepPosition < 2) {
                          _currentStepPosition++;
                        } else {

                        }
                      });
                    },
                    onStepTapped: (position) {
                      setState(() {
                        _currentStepPosition = position;
                      });
                    }
                ),
                margin: new EdgeInsets.all(15.0)
            )
          ]
        )
      );
  }
}