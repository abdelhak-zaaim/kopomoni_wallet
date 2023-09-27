import 'package:six_cash/view/screens/history/history_screen.dart';
import 'package:six_cash/view/screens/home/home_screen.dart';
import 'package:six_cash/view/screens/notification/notification_screen.dart';
import 'package:six_cash/view/screens/profile/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItemController extends GetxController implements GetxService{
  int _currentTab = 0;
  int get currentTab => _currentTab;
  final List<Widget> screen = [
    const HomeScreen(),
    HistoryScreen(),
    const NotificationScreen(),
    const ProfileScreen()
  ];
  Widget _currentScreen = const HomeScreen();
  Widget get currentScreen => _currentScreen;

  resetNavBar(){
    _currentScreen = const HomeScreen();
    _currentTab = 0;
  }

  selectHomePage({bool isUpdate = true}) {
    _currentScreen = const HomeScreen();
    _currentTab = 0;
    if(isUpdate) {
      update();
    }
  }

  selectHistoryPage() {
    _currentScreen = HistoryScreen();
    _currentTab = 1;
    update();
  }

  selectNotificationPage() {
    _currentScreen = const NotificationScreen();
    _currentTab = 2;
    update();
  }

  selectProfilePage() {
    _currentScreen = const ProfileScreen();
    _currentTab = 3;
    update();
  }
}
