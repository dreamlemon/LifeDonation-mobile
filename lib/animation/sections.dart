import 'package:flutter/material.dart';
import 'package:project_hack_forgood/colors.dart';

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

/*
const SectionDetail _eyeglassesDetail = const SectionDetail(
  imageAsset: 'packages/flutter_gallery_assets/shrine/products/sunnies.png',
  title: 'Flutter enables interactive animation',
  subtitle: '3K views - 5 days',
);

const SectionDetail _eyeglassesImageDetail = const SectionDetail(
  imageAsset: 'packages/flutter_gallery_assets/shrine/products/sunnies.png',
);

const SectionDetail _seatingDetail = const SectionDetail(
  imageAsset: 'packages/flutter_gallery_assets/shrine/products/lawn_chair.png',
  title: 'Flutter enables interactive animation',
  subtitle: '3K views - 5 days',
);

const SectionDetail _seatingImageDetail = const SectionDetail(
  imageAsset: 'packages/flutter_gallery_assets/shrine/products/lawn_chair.png',
);

const SectionDetail _decorationDetail = const SectionDetail(
  imageAsset: 'packages/flutter_gallery_assets/shrine/products/lipstick.png',
  title: 'Flutter enables interactive animation',
  subtitle: '3K views - 5 days',
);

const SectionDetail _decorationImageDetail = const SectionDetail(
  imageAsset: 'packages/flutter_gallery_assets/shrine/products/lipstick.png',
);

const SectionDetail _protectionDetail = const SectionDetail(
  imageAsset: 'packages/flutter_gallery_assets/shrine/products/helmet.png',
  title: 'Flutter enables interactive animation',
  subtitle: '3K views - 5 days',
);

const SectionDetail _protectionImageDetail = const SectionDetail(
  imageAsset: 'packages/flutter_gallery_assets/shrine/products/helmet.png',
);
*/

final SectionDetail _homeScreen = new SectionDetail(
  body: new Text("Hola")
);

final List<Section> allSections = <Section>[
  const Section(
    title: 'HOME',
    leftColor: CColors.lightblue,
    rightColor: CColors.blue,
    backgroundAsset: 'assets/homeImage.jpeg',
    details: const <SectionDetail>[

    ],
  ),
  const Section(
    title: 'ACERCA DE',
    leftColor: CColors.tomato,
    rightColor: CColors.lightblue,
    backgroundAsset: 'assets/infoImage.jpeg',
    details: const <SectionDetail>[

    ],
  ),
  const Section(
    title: 'DONAR AHORA',
    leftColor: CColors.mySin,
    rightColor: CColors.tomato,
    backgroundAsset: 'assets/donateImage.jpeg',
    details: const <SectionDetail>[

    ],
  ),
  const Section(
    title: 'PERFIL',
    leftColor: Colors.white,
    rightColor: CColors.tomato,
    backgroundAsset: 'assets/profileImage.jpg',
    details: const <SectionDetail>[

    ],
  ),
];
