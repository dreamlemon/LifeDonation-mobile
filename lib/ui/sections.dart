import 'package:flutter/material.dart';

import 'package:project_hack_forgood/resources/resources.dart';
import 'package:project_hack_forgood/ui/widgets.dart';

// MODELS
class SectionDetail {
  SectionDetail({ this.body });
  final Widget body;
}

class Section {
  const Section({ this.title, this.backgroundAsset, this.leftColor, this.rightColor, this.details });
  final String title;
  final String backgroundAsset;
  final Color leftColor;
  final Color rightColor;
  final List<SectionDetail> details;

  @override
  bool operator==(Object other) {
    if (other is! Section)
      return false;
    final Section otherSection = other;
    return title == otherSection.title;
  }

  @override
  int get hashCode => title.hashCode;
}

class ExpansionItemDetail {

  ExpansionItemDetail({ this.title, this.description });

  final String title;
  final String description;

  bool isExpanded = false;
}

// DATA
final SectionDetail _home = new SectionDetail(
      body: new Column(
          children: <Widget>[
        new DecoratedBox(
        decoration: new BoxDecoration(
            backgroundColor: Colors.white12,),
             child: new Row(
                children: <Widget>[
                  new Container(
                    child: new Text("PORCENTAJE DE DONACIONES REALIZADAS",
                      style: new TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.center
                    ),
                    margin: new EdgeInsets.all(20.0)
                  )
                ]
            )),
        new Divider(color: Colors.transparent, height: 5.0),
        new DecoratedBox(
            decoration: new BoxDecoration(
              backgroundColor: Colors.white12,),
            child: new Row(
              children: <Widget>[
                new BloodView(image: 'assets/abM.png', porcent: '60%'),
                new BloodView(image: 'assets/abN.png', porcent: '60%'),
                new BloodView(image: 'assets/aM.png', porcent: '60%'),
                new BloodView(image: 'assets/ON.png', porcent: '60%')
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround
            )),
        new DecoratedBox(
            decoration: new BoxDecoration(
              backgroundColor: Colors.white12,),
            child: new Row(
                children: <Widget>[
                  new BloodView(image: 'assets/aN.png', porcent: '60%'),
                  new BloodView(image: 'assets/bM.png', porcent: '60%'),
                  new BloodView(image: 'assets/bN.png', porcent: '60%'),
                  new BloodView(image: 'assets/OM.png', porcent: '60%')
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround
            )),
        new Divider(color: Colors.transparent, height: 10.0),
        new DecoratedBox(
            decoration: new BoxDecoration(
                backgroundColor: Colors.white12,),
            child: new Row(
                children: <Widget>[
                  new Text('DONAR AHORA',
                      style: new TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.center
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround
            )),
        new Divider(color: Colors.transparent, height: 5.0),
        new DecoratedBox(
            decoration: new BoxDecoration(
                backgroundColor: Colors.white12,),
            child: new Row(
                children: <Widget>[
                  new Text('',
                      style: new TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.center
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround
            )),
          ])
);

List<ExpansionItemDetail> itemsData = [
  new ExpansionItemDetail(title: "¿Por qué debemos donar sangre?",
      description: CTexts.whyDonate),
  new ExpansionItemDetail(title: "¿Cómo me debo preparar para donar sangre?",
      description: CTexts.howToDonate),
  new ExpansionItemDetail(title: "¿En qué consiste el proceso de donación?",
      description: CTexts.donateProcess),
  new ExpansionItemDetail(title: "Requisitos para donar sangre",
      description: CTexts.requisites),
  new ExpansionItemDetail(title: "Situaciones de riesgo",
      description: CTexts.danger)
];

final SectionDetail info = new SectionDetail(
    body: new ExpansionPanelView(items: itemsData)
);

String tipoSangre = "O-";

final SectionDetail _profile = new SectionDetail(
  body:new Column(
      children: <Widget>[new DecoratedBox(
            decoration: new BoxDecoration(
                backgroundColor: Colors.white12,),
                child: new Container(
                    child:new Row(
                      children: <Widget>[
                        new Text('Puntos por donación: ',
                            style: new TextStyle(color: Colors.white, fontSize: 16.0)
                        ),
                        new Image.asset(
                            'assets/pointIcon.png',
                            width: 30.0
                        ),

                        new Image.asset(
                            'assets/pointIcon.png',
                            width: 30.0
                        ),
                        new Image.asset(
                            'assets/pointIcon.png',
                            width: 30.0
                        ),
                        new Image.asset(
                            'assets/pointIcon.png',
                            width: 30.0
                        ),
                        new Image.asset(
                            'assets/pointIcon.png',
                            width: 30.0
                        ),

                      ]
                    ),
                  margin: new EdgeInsets.all(20.0)
                ),
            ),
      new Divider(color: Colors.transparent, height: 5.0),
      new DecoratedBox(
          decoration: new BoxDecoration(
              backgroundColor: Colors.white12,),
          child: new Container(
              child:new Row(
                  children: <Widget>[
                    new Text('Eres '+tipoSangre+ '. '+typeOfBlood(tipoSangre),
                        style: new TextStyle(color: Colors.white, fontSize: 16.0)
                    ),

                  ]
              ),
              margin: new EdgeInsets.all(20.0)
          ),
      ),
      ]
  )
);

String typeOfBlood(String tipoSangre) {
  String texto = "";
  switch (tipoSangre){
    case ("AB+"):
      texto = "Puedes donar a AB+ y eres \nreceptor universal. Tu grupo abarca \nel 3% de la población.";
      break;
    case ("AB-"):
      texto = "Puedes donar a AB± eres \nreceptor de A-, B-, AB- y O-. Tu grupo \nabarca el 1% de la población.";
      break;
    case ("A+"):
      texto = "Puedes donar a A+ y AB+ y \neres receptor de A± y O±. Tu grupo \nabarca el 37% de la población.";
      break;
    case ("A-"):
      texto = "Puedes donar a A± y AB± y \neres receptor de A- y O-. Tu grupo \nabarca el 7% de la población.";
      break;
    case ("B+"):
      texto = "Puedes donar a B+ y AB+ y \neres receptor de B± y O±. Tu grupo \nabarca el 9% de la población.";
      break;
    case ("B-"):
      texto = "Puedes donar a B± y AB± y \neres receptor de B- y O-. Tu grupo \nabarca el 1% de la población.";
      break;
    case ("O+"):
      texto = "Puedes donar a A+, B+, AB+ \ny O+ y eres receptor de O±. Tu grupo \nabarca el 36% de la población.";
      break;
    case ("O-"):
      texto = "Felicidades, eres donante \nuniversal y receptor de O-. Tu grupo \nabarca el 6% de la población.";
      break;
  }
  return texto;

}


final List<Section> allSections = <Section>[
  new Section(
    title: 'HOME',
      leftColor: CColors.mediumPurple,
      rightColor: CColors.mariner,
    backgroundAsset: 'assets/homeImage.jpeg',
    details: <SectionDetail>[
      _home
    ]
  ),
  new Section(
    title: 'ACERCA DE',
      leftColor: CColors.tomato,
      rightColor: CColors.mediumPurple,
    backgroundAsset: 'assets/infoImage.jpeg',
    details: <SectionDetail>[
      info
    ]
  ),
  new Section(
    title: 'ALERTAS',
      leftColor: CColors.mySin,
      rightColor: CColors.tomato,
    backgroundAsset: 'assets/donateImage.jpeg',
    details: <SectionDetail>[

    ]
  ),
  new Section(
    title: 'PERFIL',
    leftColor: Colors.white,
    rightColor: CColors.tomato,
    backgroundAsset: 'assets/profileImage.jpeg',
    details: <SectionDetail>[
      _profile

    ]
  ),
];
