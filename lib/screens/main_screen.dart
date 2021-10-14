import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/firebase_services/auth_service.dart';
import 'package:volink/models/chats_list_data.dart';
import 'package:volink/screens/chats_listed_screen.dart';
import 'package:volink/screens/search_users_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:volink/models/chats_list_data.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: kBackgroundColor,
            titleTextStyle: TextStyle(color: kGeneralColor),
            contentTextStyle: TextStyle(color: kGeneralColor),
            title: Text('Confirm'),
            content: Text('Are you sure you want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(color: kTextGradientColor1),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Yes',
                  style: TextStyle(color: kTextGradientColor2),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.chat_bubble_2_fill),
        title: ("Chats"),
        activeColorPrimary: kGeneralColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.search),
        title: ("Search"),
        activeColorPrimary: kGeneralColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> buildScreens() {
    return [ChatsListedScreen(), SearchUsersScreen()];
  }

  @override
  Widget build(BuildContext context) {
    print(AuthService().currentUser().displayName);
    final _controller = PersistentTabController(initialIndex: 0);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: kButtonBackgroundColor, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}
