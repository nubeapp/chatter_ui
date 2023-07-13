import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/extensions/extensions.dart';
import 'package:ui/presentation/pages/pages.dart';

class HomeScreen extends StatelessWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> pageTitle = ValueNotifier('Messages');

  final pages = const [
    MainScreen(),
    FavouriteScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          },
        ),
        Positioned(
          bottom: context.h * 0.04,
          child: BottomNavBar(
            onItemSelected: _onNavigationItemSelected,
          ),
        ),
      ],
    );
  }

  void _onNavigationItemSelected(index) {
    pageIndex.value = index;
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  // We will pass it to parent widget
  final ValueChanged<int> onItemSelected;

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: context.w - 48,
        height: context.h * 0.08,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        margin: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NavBarItem(
              index: 0,
              icon: CupertinoIcons.home,
              onTap: handleItemSelected,
              isSelected: selectedIndex == 0,
            ),
            NavBarItem(
              index: 1,
              icon: CupertinoIcons.heart,
              onTap: handleItemSelected,
              isSelected: selectedIndex == 1,
            ),
            NavBarItem(
              index: 2,
              icon: CupertinoIcons.cart,
              onTap: handleItemSelected,
              isSelected: selectedIndex == 2,
            ),
            NavBarItem(
              index: 3,
              icon: CupertinoIcons.person,
              onTap: handleItemSelected,
              isSelected: selectedIndex == 3,
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({Key? key, required this.icon, required this.index, required this.onTap, this.isSelected = false}) : super(key: key);

  final ValueChanged<int> onTap; // We will pass it to parent widget
  final int index;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Icon(
          icon,
          size: isSelected ? 27 : 20,
          color: isSelected ? Colors.black : Colors.black38,
        ),
      ),
    );
  }
}
