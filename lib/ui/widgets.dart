import 'package:flutter/material.dart';

import 'sections.dart';

const double kSectionIndicatorWidth = 32.0;

// The card for a single section. Displays the section's gradient and background image.
class SectionCard extends StatelessWidget {
  SectionCard({ Key key, this.section }) : super(key: key) {
    assert(section != null);
  }

  final Section section;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: new DecoratedBox(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(4.0),
          gradient: new LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.topRight,
            colors: <Color>[
              section.leftColor,
              section.rightColor,
            ],
          ),
        ),
        child: new Opacity(
          opacity: 0.35,
          child: new Image.asset(
            section.backgroundAsset,
            fit: ImageFit.cover,
          ),
        ),
      ),
    );
  }
}

// The title is rendered with two overlapping text widgets that are vertically
// offset a little. It's supposed to look sort-of 3D.
class SectionTitle extends StatelessWidget {
  static const TextStyle sectionTitleStyle = const TextStyle(
    fontFamily: 'Raleway',
    inherit: false,// This app's contents sta
// an appbar. Initially th
// headings are laid out i
// reduced to _kAppBarMidH
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    textBaseline: TextBaseline.alphabetic,
  );

  static final TextStyle sectionTitleShadowStyle = sectionTitleStyle.copyWith(
    color: const Color(0x19000000),
  );

  SectionTitle({ Key key, this.section, this.scale, this.opacity }) : super(key: key) {
    assert(section != null);
    assert(scale != null);
    assert(opacity != null && opacity >= 0.0 && opacity <= 1.0);
  }

  final Section section;
  final double scale;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return new IgnorePointer(
      child: new Opacity(
        opacity: opacity,
        child: new Transform(
          transform: new Matrix4.identity()..scale(scale),
          alignment: FractionalOffset.center,
          child: new Stack(
            children: <Widget>[
              new Positioned(
                top: 4.0,
                child: new Text(section.title, style: sectionTitleShadowStyle),
              ),
              new Text(section.title, style: sectionTitleStyle),
            ],
          ),
        ),
      ),
    );
  }
}

// Small horizontal bar that indicates the selected section.
class SectionIndicator extends StatelessWidget {
  SectionIndicator({ Key key, this.opacity: 1.0 }) : super(key: key);

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return new IgnorePointer(
      child: new Container(
        width: kSectionIndicatorWidth,
        height: 3.0,
        decoration: new BoxDecoration(
          backgroundColor: Colors.white.withOpacity(opacity),
        ),
      ),
    );
  }
}

// Display a single SectionDetail.
class SectionDetailView extends StatelessWidget {

  final SectionDetail detail;

  SectionDetailView({ Key key, this.detail }) : super(key: key) {
    // assert(detail != null && detail.imageAsset != null);
    // assert((detail.imageAsset ?? detail.title) != null);
  }

  @override
  Widget build(BuildContext context) {
    return detail.body;
  }

}

class ExpansionPanelView extends StatefulWidget {

  ExpansionPanelView({ this.items });

  List<ExpansionItemDetail> items;

  @override
  ExpansionPanelViewState createState() => new ExpansionPanelViewState(items);
}

// Display Expansions panel list.
class ExpansionPanelViewState extends State<ExpansionPanelView> {

  ExpansionPanelViewState(this.itemsc);

  List<ExpansionItemDetail> itemsc;

  @override
  Widget build(BuildContext context) {
    return new ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            itemsc[index].isExpanded = !isExpanded;
          });
        },
        children: itemsc.map((ExpansionItem item) {
          return new ExpansionPanel(
              isExpanded: item.isExpanded,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return new Text(item.title);
              },
              body: new Text(item.description));
        }).toList()
    );
  }

}