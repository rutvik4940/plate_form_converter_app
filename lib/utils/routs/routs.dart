import 'package:flutter/material.dart';

import 'package:platform_convertor/screen/addcontact/addcontact_ios_screen.dart';
import 'package:platform_convertor/screen/dash/dash_ios_screen.dart';
import 'package:platform_convertor/screen/detail/detail_ios_screen.dart';
import 'package:platform_convertor/screen/detail/detail_android_screen.dart';
import 'package:platform_convertor/screen/home/home_ios_screen.dart';
import 'package:platform_convertor/screen/setting/setting_ios_screen.dart';
import 'package:platform_convertor/screen/setting/setting_android_screen.dart';

import '../../screen/addcontact/addcontact_android_screen.dart';
import '../../screen/dash/dash_android_screen.dart';
import '../../screen/home/home_android_screen.dart';
Map<String,WidgetBuilder>app_routes=
{
     "/":(context) => DashScreen(),
    "home":(context) => HomeScreen(),
   "detail":(context) => DetailScreen(),
   "add":(context) => AddcontactScreen(),
   "setting":(context) => SettingScreen(),
};
Map<String,WidgetBuilder>app_routs_ios={
  "/":(context) => DashIosScreen(),
  "home":(context) => HomeIosScreen(),
  "iosdetail":(context) => DetailIosScreen(),
  "iosadd":(context) => AddcontactIosScreen(),
  "settings":(context) => SettingIosScreen(),

};