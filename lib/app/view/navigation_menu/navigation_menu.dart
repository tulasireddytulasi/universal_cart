import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/assets_path.dart';
import 'package:universal_cart/app/view/history/history.dart';
import 'package:universal_cart/app/view/home/home.dart';
import 'package:universal_cart/app/view/navigation_menu/custom_bottom_navbar.dart';
import 'package:universal_cart/app/view/profile/profile.dart';
import 'package:universal_cart/app/view/qr_scanner/qr_scanner.dart';
import 'package:universal_cart/app/view/statistics/statistics.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late ValueNotifier<int> _currentScreenNo;
  final _screens = [
    const HomeScreen(),
    const StatisticsScreen(),
    const QrScannerScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  final List<String> bottomBarTitles = ["Home", "Statistics", "Scanner", "History", "Profile"];
  final List<String> iconAssetPaths = [
    Assets.homeIcon,
    Assets.statisticsIcon,
    Assets.scannerIcon,
    Assets.historyIcon,
    Assets.userIcon,
  ];

  @override
  void initState() {
    super.initState();
    _currentScreenNo = ValueNotifier<int>(0);
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: _currentScreenNo,
            builder: (context, hasConsent, child) {
              return IndexedStack(
                index: _currentScreenNo.value,
                children: _screens,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: (_screenWidth <= 750)
          ? CustomBottomNavigationBar(
        defaultSelectedIndex: 0,
        onChange: (value) {
          _currentScreenNo.value = value;
        },
        titles: bottomBarTitles,
        imgUrls: iconAssetPaths,
      )
          : const SizedBox.shrink(),
    );
  }
}
