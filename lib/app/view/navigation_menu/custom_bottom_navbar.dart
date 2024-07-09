import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<String> titles;
  final List<String> imgUrls;

  const CustomBottomNavigationBar({
    super.key,
    this.defaultSelectedIndex = 0,
    required this.onChange,
    required this.titles,
    required this.imgUrls,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<String> _titles = [];
  List<String> _imgUrls = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
    _titles = widget.titles;
    _imgUrls = widget.imgUrls;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> navBarItemList = [];

    for (var i = 0; i < _titles.length; i++) {
      navBarItemList.add(buildNavBarItem(
        i,
        _titles[i],
        _imgUrls[i],
      ));
    }

    return Container(
      height: 92,
      decoration: const BoxDecoration(
        color: ColorPalette.antiFlashWhite,
        border: Border(top: BorderSide(color: ColorPalette.silver2, width: 1)),
      ),
      child: buildBlur(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.only(bottom: 2, left: 2, right: 2),
          width: screenWidth >= 600 ? 500 : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navBarItemList,
          ),
        ),
      ),
    );
  }

  Widget buildBlur({
    required Widget child,
    BorderRadius? borderRadius,
    double sigmaX = 10,
    double sigmaY = 10,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: child,
      ),
    );
  }

  Widget buildNavBarItem(int index, String title, String imgUrl) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: Column(
            children: [
              const SizedBox(height: 10),
              CircleAvatar(
                radius: (index == 2 ? 32 : 22),
                backgroundColor: ColorPalette.black,
                child: CircleAvatar(
                  radius: index == 2 ? 30 : 20,
                  backgroundColor: index == 2 ? ColorPalette.liteOrange : ColorPalette.liteWhite,
                  child: Image.asset(
                    imgUrl,
                    width: 22,
                    height: 22,
                    color: ColorPalette.black,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  color: ColorPalette.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
