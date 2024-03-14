
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convertor/screen/provider/desh_provider.dart';

import 'package:platform_convertor/screen/provider/platform_provider.dart';
import 'package:platform_convertor/utils/routs/routs.dart';
import 'package:platform_convertor/utils/theme/theme_ios.dart';
import 'package:provider/provider.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: PlatformProvider()),
          ChangeNotifierProvider.value(value: DashProvider()),

        ],
        child: Consumer<PlatformProvider>(
          builder: (context, value, child) {
             value.getTheme();
             value.isLight= value.changeTheme;
            return value.isAndroid?MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: value.mode,
              routes: app_routes,
            )
                :CupertinoApp(
              debugShowCheckedModeBanner: false,
              routes: app_routs_ios,
              theme: value.changeTheme?dark:light,

            );
          },
        ),
      )
  );
}
