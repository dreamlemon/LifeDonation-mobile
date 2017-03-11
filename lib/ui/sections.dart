import 'package:flutter/material.dart';
import 'package:project_hack_forgood/resources/colors.dart';
import 'package:project_hack_forgood/ui/faq.dart';

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

final SectionDetail _home = new SectionDetail(
      body:
      new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  child: new Column(
                    children: <Widget>[
                      new Image.asset(
                          'assets/abM.png',
                          width: 50.0
                      ),
                      new Container(
                        child: new Text('60%',
                            style: new TextStyle(color: Colors.white, fontSize: 17.0)
                        ),
                        margin:  new EdgeInsets.all(10.0)
                      )
                      ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween
                  ),
                  margin: new EdgeInsets.all(20.0),
                ),
                new Container(
                    child: new Image.asset(
                        'assets/abM.png',
                        width: 60.0
                    ),
                    margin: new EdgeInsets.all(20.0),
                ),
                new Container(
                    child: new Image.asset(
                        'assets/abM.png',
                        width: 60.0
                    ),
                    margin: new EdgeInsets.all(20.0),
                ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround
            ),
            new Row(
                children: <Widget>[
                  new Container(
                      child: new Image.asset(
                          'assets/abM.png',
                          width: 60.0
                      ),
                      margin: new EdgeInsets.all(20.0),
                  ),
                  new Container(
                      child: new Image.asset(
                          'assets/abM.png',
                          width: 60.0
                      ),
                      margin: new EdgeInsets.all(20.0),
                  ),
                  new Container(
                      child: new Image.asset(
                          'assets/abM.png',
                          width: 60.0
                      ),
                      margin: new EdgeInsets.all(20.0),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround
            ),

  ])
);


final SectionDetail info = new SectionDetail(
    body: new SingleChildScrollView(
        child: new Container(
            margin: const EdgeInsets.all(24.0),
            child: new ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {

                },
                children: <ExpansionPanel> [
                  new ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return new Text("¿Por qué debemos donar sangre?");
                      },
                      body: new Column(
                          children: <Widget>[
                      new Container(
                      margin: const EdgeInsets.only(
                          left: 24.0,
                          right: 24.0,
                          bottom: 24.0
                      ),
            child: new Center(
                child: new Text("Hola")
            )
        )])
                  )]
            )
        )
    )
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
    details:  <SectionDetail>[
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
