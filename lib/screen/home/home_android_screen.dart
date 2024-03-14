import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/platform_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlatformProvider? providerR;
  PlatformProvider? providerW;
  @override
  Widget build(BuildContext context) {
    providerR = context.read<PlatformProvider>();
    providerW = context.watch<PlatformProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Screen"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: providerR!.platformList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'detail',arguments: index);
                    },

                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      height: 80,
                      child: Column(children: [
                        Row(
                            children: [
                              providerW!.platformList[index].image==null?
                           CircleAvatar(
                          radius: 30,
                         )
                          :CircleAvatar(
                            radius: 30,
                            backgroundImage: FileImage(
                                File("${providerW!.platformList[index].image}")),
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
                        ]),
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
