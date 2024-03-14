import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/model.dart';
import '../provider/desh_provider.dart';
import '../provider/platform_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  PlatformProvider? providerR;
  PlatformProvider? providerW;
  DashProvider? providerS;
  TextEditingController txtname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtcontact = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    providerR = context.read<PlatformProvider>();
    providerW = context.watch<PlatformProvider>();
    providerS = context.read<DashProvider>();
    return SafeArea(
      child: Form(
        key: key,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Setting"),
          ),
          body:  Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Change Ui",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                   SizedBox(width: 10,),
                   Spacer(),
                   Switch(
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
                    IconButton(onPressed:() {
                      providerW!.setTheme();
                    },  icon: Icon(providerW!.isLight==false?Icons.dark_mode:Icons.light_mode)),
                  ],
                ),
                Divider(color: Colors.black12,),
               IconButton(onPressed: () {
                 showDialog(
                   context: context,
                   builder: (context) =>
                    AlertDialog(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          providerR!.path == null
                              ? const CircleAvatar(
                            radius: 60,
                          )
                              : CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(providerW!.path!)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? image =
                                  await picker.pickImage(source: ImageSource.camera);
                                  providerR!.addPath(image!.path);
                                },
                                icon: const Icon(Icons.camera_alt),
                              ),
                              IconButton(
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? image =
                                  await picker.pickImage(source: ImageSource.gallery);
                                  providerR!.addPath(image!.path);
                                },
                                icon: const Icon(Icons.photo),
                              ),
                            ],
                          ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                          TextFormField(
                          controller: txtname,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "name is required";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Name",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtcontact,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "mobile no. is required";
                            } else if (value!.length != 10) {
                              return "Enter the valid number";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Mobile Number",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtemail,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required ";
                            } else if (!RegExp(
                                "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                                .hasMatch(value)) {
                              return "enter the valid email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Email id",
                              border: OutlineInputBorder()),
                        ),
                            ElevatedButton(onPressed: () {
                              if (key.currentState!.validate()) {
                                DataModel d1 = DataModel(
                                  name: txtname.text,
                                  email: txtemail.text,
                                  call: txtcontact.text,
                                  image: providerR!.path,
                                  date: "${providerR!.d1.day}/${providerR!.d1.month}/${providerR!.d1.year}",
                                  time: "${providerR!.t1.minute}-${providerR!.t1.hour}",
                                );
                                providerR!.adddata(d1);
                                txtname.clear();
                                txtemail.clear();
                                txtcontact.clear();
                                providerS!.pageIndex=0;
                                providerW!.path="";
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Your data is save"),
                                  ),
                                );
                              }
                            }, child:Text("Save"),
                            ),
                        ]
                   ),
                 )
                        ]
                    )
                    ),
                 );
               }, icon: Text("Create Account"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
