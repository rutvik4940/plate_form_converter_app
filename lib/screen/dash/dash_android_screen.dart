import 'package:flutter/material.dart';
import 'package:platform_convertor/screen/addcontact/addcontact_android_screen.dart';
import 'package:platform_convertor/screen/provider/desh_provider.dart';
import 'package:platform_convertor/screen/home/home_android_screen.dart';
import 'package:platform_convertor/screen/setting/setting_android_screen.dart';
import 'package:provider/provider.dart';



class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  DashProvider? providerR;
  DashProvider? providerW;
  List<Widget> l1 = [
    const HomeScreen(),
    const AddcontactScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    providerR = context.read<DashProvider>();
    providerW = context.watch<DashProvider>();
    return Scaffold(
      body: l1[providerW!.pageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          const NavigationDestination(
              icon: Icon(Icons.person_add), label: "Add Contact"),
          const NavigationDestination(
              icon: Icon(Icons.settings), label: "Setting"),
        ],
        onDestinationSelected: (value) {
          providerR!.changePage(index: value);
        },
        selectedIndex: providerW!.pageIndex,
      ),
    );
  }
}
