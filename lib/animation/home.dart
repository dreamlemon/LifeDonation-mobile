// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Based on https://material.uplabs.com/posts/google-newsstand-navigation-pattern
// See also: https://material-motion.github.io/material-motion/documentation/

import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'sections.dart';
import 'widgets.dart';

const Color _kAppBackgroundColor = const Color(0xFF353662);

// This app's contents start out at _kHeadingMaxHeight and they function like
// an appbar. Initially the appbar occupies most of the screen and its section
// headings are laid out in a column. By the time its height has been
// reduced to _kAppBarMidHeight, its layout is horizontal, only one section
// heading is visible, and the section's list of details is visible below the
// heading. The appbar's height can be reduced to no more than _kAppBarMinHeight.
const double _kAppBarMinHeight = 90.0;
const double _kAppBarMidHeight = 256.0;
// The AppBar's max height depends on the screen, see _AnimationDemoHomeState._buildBody()

// Initially occupies the same space as the status bar and gets smaller as
// the primary scrollable scrolls upwards.
// TODO(hansmuller): it would be worth adding something like this to the framework.
class _RenderStatusBarPaddingSliver extends RenderSliver {
  _RenderStatusBarPaddingSliver({
    double maxHeight,
    double scrollFactor,
  }) : _maxHeight = maxHeight, _scrollFactor = scrollFactor {
    assert(maxHeight != null && maxHeight >= 0.0);
    assert(scrollFactor != null && scrollFactor >= 1.0);
  }

  // The height of the status bar
  double get maxHeight => _maxHeight;
  double _maxHeight;
  set maxHeight (double value) {
    assert(maxHeight != null && maxHeight >= 0.0);
    if (_maxHeight == value)
      return;
    _maxHeight = value;
    markNeedsLayout();
  }

  // That rate at which this renderer's height shrinks when the scroll
  // offset changes.
  double get scrollFactor => _scrollFactor;
  double _scrollFactor;
  set scrollFactor (double value) {
    assert(scrollFactor != null && scrollFactor >= 1.0);
    if (_scrollFactor == value)
      return;
    _scrollFactor = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final double height = (maxHeight - constraints.scrollOffset / scrollFactor).clamp(0.0, maxHeight);
    geometry = new SliverGeometry(
      paintExtent: math.min(height, constraints.remainingPaintExtent),
      scrollExtent: maxHeight,
      maxPaintExtent: maxHeight,
    );
  }
}

class _StatusBarPaddingSliver extends SingleChildRenderObjectWidget {
  _StatusBarPaddingSliver({
    Key key,
    @required this.maxHeight,
    this.scrollFactor: 5.0,
  }) : super(key: key) {
    assert(maxHeight != null && maxHeight >= 0.0);
    assert(scrollFactor != null && scrollFactor >= 1.0);
  }

  final double maxHeight;
  final double scrollFactor;

  @override
  _RenderStatusBarPaddingSliver createRenderObject(BuildContext context) {
    return new _RenderStatusBarPaddingSliver(
      maxHeight: maxHeight,
      scrollFactor: scrollFactor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderStatusBarPaddingSliver renderObject) {
    renderObject
      ..maxHeight = maxHeight
      ..scrollFactor = scrollFactor;
  }

  @override
  void debugFillDescription(List<String> description) {
    super.debugFillDescription(description);
    description.add('maxHeight: $maxHeight');
    description.add('scrollFactor: $scrollFactor');
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override double get minExtent => minHeight;
  @override double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight
        || minHeight != oldDelegate.minHeight
        || child != oldDelegate.child;
  }

  @override
  String toString() => '_SliverAppBarDelegate';
}

// Arrange the section titles, indicators, and cards. The cards are only included when
// the layout is transitioning between vertical and horizontal. Once the layout is
// horizontal the cards are laid out by a PageView.
//
// The layout of the section cards, titles, and indicators is defined by the
// two 0.0-1.0 "t" parameters, both of which are based on the layout's height:
// - tColumnToRow
//   0.0 when height is maxHeight and the layout is a column
//   1.0 when the height is midHeight and the layout is a row
// - tCollapsed
//   0.0 when height is midHeight and the layout is a row
//   1.0 when height is minHeight and the layout is a (still) row
//
// minHeight < midHeight < maxHeight
//
// The general approach here is to compute the column layout and row size
// and position of each element and then interpolate between them using
// tColumnToRow. Once tColumnToRow reaches 1.0, the layout changes are
// defined by tCollapsed. As tCollapsed increases the titles spread out
// until only one title is visible and the indicators cluster together
// until they're all visible.
class _AllSectionsLayout extends MultiChildLayoutDelegate {
  _AllSectionsLayout({
    this.translation,
    this.tColumnToRow,
    this.tCollapsed,
    this.cardCount,
    this.selectedIndex,
  });

  final FractionalOffset translation;
  final double tColumnToRow;
  final double tCollapsed;
  final int cardCount;
  final double selectedIndex;

  Rect _interpolateRect(Rect begin, Rect end) {
    return Rect.lerp(begin, end, tColumnToRow);
  }

  Point _interpolatePoint(Point begin, Point end) {
    return Point.lerp(begin, end, tColumnToRow);
  }

  @override
  void performLayout(Size size) {
    final double columnCardX = size.width / 5.0;
    final double columnCardWidth = size.width - columnCardX;
    final double columnCardHeight = size.height / cardCount;
    final double rowCardWidth = size.width;
    final Offset offset = translation.alongSize(size);
    double columnCardY = 0.0;
    double rowCardX = -(selectedIndex * rowCardWidth);

    // When tCollapsed > 0 the titles spread apart
    final double columnTitleX = size.width / 10.0;
    final double rowTitleWidth = size.width * ((1 + tCollapsed) / 2.25);
    double rowTitleX = (size.width - rowTitleWidth) / 2.0 - selectedIndex * rowTitleWidth;

    // When tCollapsed > 0, the indicators move closer together
    //final double rowIndicatorWidth = 48.0 + (1.0 - tCollapsed) * (rowTitleWidth - 48.0);
    final double paddedSectionIndicatorWidth = kSectionIndicatorWidth + 8.0;
    final double rowIndicatorWidth = paddedSectionIndicatorWidth +
      (1.0 - tCollapsed) * (rowTitleWidth - paddedSectionIndicatorWidth);
    double rowIndicatorX = (size.width - rowIndicatorWidth) / 2.0 - selectedIndex * rowIndicatorWidth;

    // Compute the size and origin of each card, title, and indicator for the maxHeight
    // "column" layout, and the midHeight "row" layout. The actual layout is just the
    // interpolated value between the column and row layouts for t.
    for (int index = 0; index < cardCount; index++) {

      // Layout the card for index.
      final Rect columnCardRect = new Rect.fromLTWH(columnCardX, columnCardY, columnCardWidth, columnCardHeight);
      final Rect rowCardRect = new Rect.fromLTWH(rowCardX, 0.0, rowCardWidth, size.height);
      final Rect cardRect = _interpolateRect(columnCardRect, rowCardRect).shift(offset);
      final String cardId = 'card$index';
      if (hasChild(cardId)) {
        // Add a small horizontal gap between the cards.
        final Rect insetRect = new Rect.fromLTWH(
          cardRect.left + 0.5, cardRect.top, cardRect.width - 1.0, cardRect.height
        );
        layoutChild(cardId, new BoxConstraints.tight(insetRect.size));
        positionChild(cardId, insetRect.topLeft.toOffset());
      }

      // Layout the title for index.
      final Size titleSize = layoutChild('title$index', new BoxConstraints.loose(cardRect.size));
      final double columnTitleY = columnCardRect.centerLeft.y - titleSize.height / 2.0;
      final double rowTitleY = rowCardRect.centerLeft.y - titleSize.height / 2.0;
      final double centeredRowTitleX = rowTitleX + (rowTitleWidth - titleSize.width) / 2.0;
      final Point columnTitleOrigin = new Point(columnTitleX, columnTitleY);
      final Point rowTitleOrigin = new Point(centeredRowTitleX, rowTitleY);
      final Point titleOrigin = _interpolatePoint(columnTitleOrigin, rowTitleOrigin);
      positionChild('title$index', titleOrigin.toOffset() + offset);

      // Layout the selection indicator for index.
      final Size indicatorSize = layoutChild('indicator$index', new BoxConstraints.loose(cardRect.size));
      final double columnIndicatorX = cardRect.centerRight.x - indicatorSize.width - 16.0;
      final double columnIndicatorY = cardRect.bottomRight.y - indicatorSize.height - 16.0;
      final Point columnIndicatorOrigin = new Point(columnIndicatorX, columnIndicatorY);
      final Rect titleRect = new Rect.fromPoints(titleOrigin, titleSize.bottomRight(titleOrigin));
      final double centeredRowIndicatorX = rowIndicatorX + (rowIndicatorWidth - indicatorSize.width) / 2.0;
      final double rowIndicatorY = titleRect.bottomCenter.y + 16.0;
      final Point rowIndicatorOrigin = new Point(centeredRowIndicatorX, rowIndicatorY);
      final Point indicatorOrigin = _interpolatePoint(columnIndicatorOrigin, rowIndicatorOrigin);
      positionChild('indicator$index', indicatorOrigin.toOffset() + offset);

      columnCardY += columnCardHeight;
      rowCardX += rowCardWidth;
      rowTitleX += rowTitleWidth;
      rowIndicatorX += rowIndicatorWidth;
    }
  }

  @override
  bool shouldRelayout(_AllSectionsLayout oldDelegate) {
    return tColumnToRow != oldDelegate.tColumnToRow
      || cardCount != oldDelegate.cardCount
      || selectedIndex != oldDelegate.selectedIndex;
  }
}

class _AllSectionsView extends AnimatedWidget {
  _AllSectionsView({
    Key key,
    this.sectionIndex,
    this.sections,
    this.selectedIndex,
    this.minHeight,
    this.midHeight,
    this.maxHeight,
    this.sectionCards: const <Widget>[],
  }) : super(key: key, listenable: selectedIndex) {
    assert(sections != null);
    assert(sectionCards != null);
    assert(sectionCards.length == sections.length);
    assert(sectionIndex >= 0 && sectionIndex < sections.length);
    assert(selectedIndex != null);
    assert(selectedIndex.value >= 0.0 && selectedIndex.value < sections.length.toDouble());
  }

  final int sectionIndex;
  final List<Section> sections;
  final ValueNotifier<double> selectedIndex;
  final double minHeight;
  final double midHeight;
  final double maxHeight;
  final List<Widget> sectionCards;

  double _selectedIndexDelta(int index) {
    return (index.toDouble() - selectedIndex.value).abs().clamp(0.0, 1.0);
  }

  Widget _build(BuildContext context, BoxConstraints constraints) {
    final Size size = constraints.biggest;

    // The layout's progress from from a column to a row. Its value is
    // 0.0 when size.height equals the maxHeight, 1.0 when the size.height
    // equals the midHeight.
    // The layout's progress from from a column to a row. Its value is
    // 0.0 when size.height equals the maxHeight, 1.0 when the size.height
    // equals the midHeight.
    final double tColumnToRow =
      1.0 - ((size.height - midHeight) /
             (maxHeight - midHeight)).clamp(0.0, 1.0);


    // The layout's progress from from the midHeight row layout to
    // a minHeight row layout. Its value is 0.0 when size.height equals
    // midHeight and 1.0 when size.height equals minHeight.
    final double tCollapsed =
      1.0 - ((size.height - minHeight) /
             (midHeight - minHeight)).clamp(0.0, 1.0);

    double _indicatorOpacity(int index) {
      return 1.0 - _selectedIndexDelta(index) * tColumnToRow * 0.5;
    }

    double _titleOpacity(int index) {
      return 1.0 - _selectedIndexDelta(index) * tColumnToRow * 0.5;
    }

    double _titleScale(int index) {
      return 1.0 - _selectedIndexDelta(index) * tColumnToRow * 0.15;
    }

    final List<Widget> children = new List<Widget>.from(sectionCards);

    for (int index = 0; index < sections.length; index++) {
      final Section section = sections[index];
      children.add(new LayoutId(
        id: 'title$index',
        child: new SectionTitle(
          section: section,
          scale: _titleScale(index),
          opacity: _titleOpacity(index),
        ),
      ));
    }

    for (int index = 0; index < sections.length; index++) {
      children.add(new LayoutId(
        id: 'indicator$index',
        child: new SectionIndicator(
          opacity: _indicatorOpacity(index),
        ),
      ));
    }

    return new CustomMultiChildLayout(
      delegate: new _AllSectionsLayout(
        translation: new FractionalOffset(selectedIndex.value - sectionIndex, 0.0),
        tColumnToRow: tColumnToRow,
        tCollapsed: tCollapsed,
        cardCount: sections.length,
        selectedIndex: selectedIndex.value,
      ),
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: _build);
  }
}

class AnimationDemoHome extends StatefulWidget {
  AnimationDemoHome({ Key key }) : super(key: key);

  static const String routeName = '/animation';

  @override
  _AnimationDemoHomeState createState() => new _AnimationDemoHomeState();
}

class _AnimationDemoHomeState extends State<AnimationDemoHome> {
  final ScrollController _scrollController = new ScrollController();
  final PageController _headingPageController = new PageController();
  final PageController _detailsPageController = new PageController();
  ValueNotifier<double> selectedIndex = new ValueNotifier<double>(0.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: _kAppBackgroundColor,
      body: new Builder(
        // Insert an element so that _buildBody can find the PrimaryScrollController.
        builder: (BuildContext context) => _buildBody(context),
      ),
    );
  }

  void _maybeScroll(double midScrollOffset, int pageIndex, double xOffset) {
    const Duration duration = const Duration(milliseconds: 400);
    const Curve curve = Curves.fastOutSlowIn;
    if (_scrollController.offset < midScrollOffset) {
      // Scroll the overall list to the point where only one section card shows.
      // At the same time scroll the PageViews to the page at pageIndex.
      _headingPageController.animateToPage(pageIndex, curve: curve, duration: duration);
      _scrollController.animateTo(midScrollOffset, curve: curve, duration: duration);
    } else {
      // One one section card is showing: scroll one page forward or back.
      final double centerX = _headingPageController.position.viewportDimension / 2.0;
      final int newPageIndex = xOffset > centerX ? pageIndex + 1 : pageIndex - 1;
      _headingPageController.animateToPage(newPageIndex, curve: curve, duration: duration);
    }
  }

  bool _handlePageNotification(ScrollNotification notification, PageController leader, PageController follower) {
    if (notification.depth == 0 && notification is ScrollUpdateNotification) {
      selectedIndex.value = leader.page;
      if (follower.page != leader.page)
        follower.position.jumpTo(leader.position.pixels, settle: false);
    }
    return false;
  }

  Iterable<Widget> _detailItemsFor(Section section) {
    final Iterable<Widget> detailItems = section.details.map((SectionDetail detail) {
      return new SectionDetailView(detail: detail);
    });
    return ListItem.divideItems(context: context, items: detailItems).map((Widget item) {
        return new SliverToBoxAdapter(child: item);
    });
  }

  Iterable<Widget> _allHeadingItems(double maxHeight, double midScrollOffset) {
    final List<Widget> sectionCards = <Widget>[];
    for (int index = 0; index < allSections.length; index++) {
      sectionCards.add(new LayoutId(
        id: 'card$index',
        child: new GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: new SectionCard(section: allSections[index]),
          onTapUp: (TapUpDetails details) {
            final double xOffset = details.globalPosition.x;
            setState(() {
              _maybeScroll(midScrollOffset, index, xOffset);
            });
          }
        ),
      ));
    }

    final List<Widget> headings = <Widget>[];
    for (int index = 0; index < allSections.length; index++) {
      headings.add(new Container(
          decoration: const BoxDecoration(backgroundColor: _kAppBackgroundColor),
          child: new ClipRect(
            child: new _AllSectionsView(
              sectionIndex: index,
              sections: allSections,
              selectedIndex: selectedIndex,
              minHeight: _kAppBarMinHeight,
              midHeight: _kAppBarMidHeight,
              maxHeight: maxHeight,
              sectionCards: sectionCards,
            ),
          ),
        )
      );
    }
    return headings;
  }

  Widget _buildBody(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double statusBarHeight = mediaQueryData.padding.top;
    final double screenHeight = mediaQueryData.size.height;
    final double appBarMaxHeight = screenHeight - statusBarHeight;

    // The scrolloffset that reveals the appBarMidHeight appbar.
    final double appBarMidScrollOffset = statusBarHeight + appBarMaxHeight - _kAppBarMidHeight;

    return new SizedBox.expand(
      child: new Stack(
        children: <Widget>[
          new CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              // Start out below the status bar, gradually move to the top of the screen.
              new _StatusBarPaddingSliver(
                maxHeight: statusBarHeight,
                scrollFactor: 7.0,
              ),
              // Section Headings
              new SliverPersistentHeader(
                pinned: true,
                delegate: new _SliverAppBarDelegate(
                  minHeight: _kAppBarMinHeight,
                  maxHeight: appBarMaxHeight,
                  child: new NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      return _handlePageNotification(notification, _headingPageController, _detailsPageController);
                    },
                    child: new PageView(
                      controller: _headingPageController,
                      children: _allHeadingItems(appBarMaxHeight, appBarMidScrollOffset),
                    ),
                  ),
                ),
              ),
              // Details
              new SliverToBoxAdapter(
                child: new SizedBox(
                  height: 610.0,
                  child: new NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      return _handlePageNotification(notification, _detailsPageController, _headingPageController);
                    },
                    child: new PageView(
                      controller: _detailsPageController,
                      children: allSections.map((Section section) {
                        return new CustomScrollView(
                          slivers: _detailItemsFor(section).toList(),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Positioned(
            top: statusBarHeight,
            left: 0.0,
            child: new IconTheme(
              data: const IconThemeData(color: Colors.white),
              child: const BackButton(),
            ),
          ),
        ],
      ),
    );
  }
}
