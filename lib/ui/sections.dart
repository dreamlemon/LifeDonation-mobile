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

final SectionDetail _graficas = new SectionDetail(
  body: new DecoratedBox(
    decoration: new BoxDecoration(backgroundColor: CColors.boxDecoration),
    child: new Text("Hola")
  )
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


final List<Section> allSections = <Section>[
  new Section(
    title: 'HOME',
      leftColor: CColors.mediumPurple,
      rightColor: CColors.mariner,
    backgroundAsset: 'assets/homeImage.jpeg',
    details: <SectionDetail>[
      _graficas
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
  const Section(
    title: 'DONAR AHORA',
      leftColor: CColors.mySin,
      rightColor: CColors.tomato,
    backgroundAsset: 'assets/donateImage.jpeg',
    details: const <SectionDetail>[

    ]
  ),
  const Section(
    title: 'PERFIL',
    leftColor: Colors.white,
    rightColor: CColors.tomato,
    backgroundAsset: 'assets/profileImage.jpeg',
    details: const <SectionDetail>[

    ]
  ),
];
