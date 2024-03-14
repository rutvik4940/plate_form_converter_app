import 'package:flutter/cupertino.dart';
import 'package:platform_convertor/screen/addcontact/addcontact_ios_screen.dart';
import 'package:platform_convertor/screen/home/home_ios_screen.dart';
import 'package:platform_convertor/screen/setting/setting_ios_screen.dart';
import 'package:provider/provider.dart';

import '../provider/desh_provider.dart';

class DashIosScreen extends StatefulWidget {
  const DashIosScreen({super.key});

  @override
  State<DashIosScreen> createState() => _DashIosScreenState();
}

class _DashIosScreenState extends State<DashIosScreen> {
  DashProvider? providerR;
  DashProvider? providerW;
  List<Widget> l1 = [
    const HomeIosScreen(),
    const AddcontactIosScreen(),
    const SettingIosScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    providerR = context.read<DashProvider>();
    providerW = context.watch<DashProvider>();
    return   CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: providerR!.pageIndex,
        onTap: (value) {
          int index=value;
          providerR!.changePage(index: index);

        },
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_add),label: 'Add Contact'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings),label: 'Setting'),

        ],
      ), tabBuilder: (BuildContext context, int index){return l1[providerR!.pageIndex];},

    );


  }
}

