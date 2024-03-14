import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/platform_provider.dart';

class SettingIosScreen extends StatefulWidget {
  const SettingIosScreen({super.key});

  @override
  State<SettingIosScreen> createState() => _SettingIosScreenState();
}

class _SettingIosScreenState extends State<SettingIosScreen> {
  PlatformProvider? providerR;
  PlatformProvider? providerW;
  @override
  Widget build(BuildContext context) {
    providerR = context.read<PlatformProvider>();
    providerW = context.watch<PlatformProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Setting"),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Change Ui",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                CupertinoSwitch(
                  value: providerW!.isAndroid,
                  onChanged: (value) {
                    providerR!.changeui();
                  },
                ),
              ],
            ),
            Divider(color: Colors.black12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Change Mode",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                CupertinoButton(
                  child: Icon(providerW!.isLight==false?Icons.dark_mode:Icons.light_mode),
                  onPressed: () {
                    providerW!.setTheme();
                  },
                ),
              ],
            ),
            Divider(color: Colors.black12,),
          ],
        ),
      ),
    );
  }
}
