import 'package:flutter/material.dart';

import 'package:project_hack_forgood/resources/colors.dart';
import 'package:project_hack_forgood/ui/faq.dart';
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
            new Row(
              children: <Widget>[
                new BloodView(image: 'assets/abM.png', porcent: '60%'),
                new BloodView(image: 'assets/abM.png', porcent: '60%'),
                new BloodView(image: 'assets/abM.png', porcent: '60%')
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround
            ),
            new Row(
                children: <Widget>[
                  new BloodView(image: 'assets/abM.png', porcent: '60%'),
                  new BloodView(image: 'assets/abM.png', porcent: '60%'),
                  new BloodView(image: 'assets/abM.png', porcent: '60%'),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround
            )
          ])
);

List<ExpansionItemDetail> itemsData = [
  new ExpansionItemDetail(title: "title", description: "description")
];

final SectionDetail info = new SectionDetail(
    body: new ExpansionPanelView(items: itemsData)
);

final SectionDetail _profile = new SectionDetail(
  body: new Container(
    child: new Row(
      children: <Widget>[
        new Text('Puntos por donación: ',
            style: new TextStyle(color: Colors.white, fontSize: 16.0)
        ),
        new DecoratedBox(
        position: DecorationPosition.foreground,
        child: new Image.asset(
            'assets/pointIcon.png',
            width: 30.0
        ),
        decoration: new BoxDecoration(backgroundColor: Colors.black)),
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

  )
);


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
    title: 'DONAR AHORA',
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
