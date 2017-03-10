import 'package:flutter/material.dart';
import 'package:project_hack_forgood/resources/colors.dart';

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

final List<Section> allSections = <Section>[
  new Section(
    title: 'HOME',
    leftColor: CColors.lightblue,
    rightColor: CColors.blue,
    backgroundAsset: 'assets/homeImage.jpeg',
    details: <SectionDetail>[
      _graficas
    ]
  ),
  const Section(
    title: 'ACERCA DE',
    leftColor: CColors.pink,
    rightColor: CColors.lightblue,
    backgroundAsset: 'assets/infoImage.jpeg',
    details: const <SectionDetail>[

    ]
  ),
  const Section(
    title: 'DONAR AHORA',
    leftColor: CColors.lightblue,
    rightColor: CColors.darkRed,
    backgroundAsset: 'assets/donateImage.jpeg',
    details: const <SectionDetail>[

    ]
  ),
  const Section(
    title: 'PERFIL',
    leftColor: CColors.darkRed,
    rightColor: CColors.lightblue,
    backgroundAsset: 'assets/profileImage.jpg',
    details: const <SectionDetail>[

    ]
  ),
];
