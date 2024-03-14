import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/platform_provider.dart';

class HomeIosScreen extends StatefulWidget {
  const HomeIosScreen({super.key});

  @override
  State<HomeIosScreen> createState() => _HomeIosScreenState();
}

class _HomeIosScreenState extends State<HomeIosScreen> {
  PlatformProvider? providerR;
  PlatformProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<PlatformProvider>();
    providerW = context.watch<PlatformProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(" Home Screen"),
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.add),
          onPressed: () {
            Navigator.pushNamed(context, 'iosadd');
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: providerW!.platformList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'iosdetail',arguments: index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    height: 80,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            providerW!.platformList[index].image==null?
                            CircleAvatar(
                              radius: 30,
                            )
                            :CircleAvatar(
                              radius: 30,
                              backgroundImage: FileImage(File(
                                  "${providerW!.platformList[index].image}")),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${providerW!.platformList[index].name}",
                                    style: const TextStyle(fontSize: 20)),
                                Text("${providerW!.platformList[index].call}",
                                    style: const TextStyle(fontSize: 15)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
