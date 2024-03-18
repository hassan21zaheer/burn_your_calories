import 'package:burnyourcalories/widgets/page.dart' as CustomPage;
import 'package:burnyourcalories/widgets/rectangle_indicator.dart';
import 'package:flutter/material.dart';

class MenuPager extends StatefulWidget {
  final List<CustomPage.Page> children;

  MenuPager({required this.children});

  @override
  _MenuPagerState createState() => _MenuPagerState();
}

const double _kViewportFraction = 0.75;

class _MenuPagerState extends State<MenuPager> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          if (widget.children.isNotEmpty)
            _renderBackground(widget.children[selectedPageIndex].background!),
          if (widget.children.isNotEmpty)
            _renderTitle(widget.children[selectedPageIndex].title!),
          _renderBottomNav(
            widget.children.map((page) => page.icon!).toList(),
          ),
          _renderContents(
              widget.children, selectedPageIndex, this.handlePageChanged),
        ],
      ),
    );
  }

  void handlePageChanged(int pageIndex) {
    setState(() {
      selectedPageIndex = pageIndex;
    });
  }

  Widget _renderContents(List<CustomPage.Page> pages, int selectedPageIndex,
      void onPageChanged(int pageIndex)) {
    return PageView(
      controller: PageController(
          initialPage: selectedPageIndex, viewportFraction: _kViewportFraction),
      children: List<Widget>.generate(pages.length, (index) {
        return _renderPage(pages[index], index, selectedPageIndex);
      }, growable: false),
      onPageChanged: onPageChanged,
    );
  }

  Widget _renderPage(CustomPage.Page page, int index, int selectedPageIndex) {
    var resizeFactor = 1 - ((selectedPageIndex - index).abs() * 0.2).clamp(0.0, 1.0);
    return Center(
      child: Container(
        alignment: Alignment.center +
            Alignment((selectedPageIndex - index) * _kViewportFraction, 0.0),
        width: 350.0 * resizeFactor,
        height: 600.0 * resizeFactor,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: page,
          ),
        ),
      ),
    );
  }

  Widget _renderBottomNav(List<String> iconImages) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.0),
        child: FittedBox(
          alignment: FractionalOffset.bottomCenter,
          child: RectangleIndicator(
            icons: iconImages,
            selectedIndex: selectedPageIndex,
          ),
        ),
      ),
    );
  }

  Widget _renderTitle(String? titleText) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Text(
          titleText ?? '', // Null check for titleText
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Dosis',
          ),
        ),
      ),
    );
  }

  Widget _renderBackground(LinearGradient? gradient2) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient2 ?? LinearGradient(colors: [Colors.white, Colors.white]), // Null check for gradient2
        ),
      ),
    );
  }
}
