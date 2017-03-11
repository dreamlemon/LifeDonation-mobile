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
        body: new ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {

                },
                children: <ExpansionPanel> [
                  new ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return new Text("¿Por qué debemos donar sangre?");
                      },
                      body: new Text("hla")
                  )]
            )

      );
  }
}