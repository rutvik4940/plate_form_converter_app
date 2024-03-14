import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/model.dart';
import '../provider/desh_provider.dart';
import '../provider/platform_provider.dart';

class AddcontactIosScreen extends StatefulWidget {
  const AddcontactIosScreen({super.key});

  @override
  State<AddcontactIosScreen> createState() => _AddcontactIosScreenState();
}

class _AddcontactIosScreenState extends State<AddcontactIosScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtcontact = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  PlatformProvider? providerR;
  PlatformProvider? providerW;
  DashProvider? providerS;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<PlatformProvider>();
    providerW = context.watch<PlatformProvider>();
    providerS = context.read<DashProvider>();
    return SafeArea(
      child: Form(
        key: key,
        child: CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text(" Add Contact "),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                ),
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
                    CupertinoButton(
                      child: Icon(CupertinoIcons.camera),
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        providerR!.addPath(image!.path);
                      },
                    ),
                    CupertinoButton(
                      child: Icon(CupertinoIcons.photo),
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        providerR!.addPath(image!.path);
                      },
                    )
                  ],
                ),
                CupertinoTextFormFieldRow(
                  controller: txtname,
                  keyboardType: TextInputType.name,
                  prefix: Icon(CupertinoIcons.person),
                  placeholder: 'Required',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Valid Name";
                    }
                    return null;
                  },
                  decoration: BoxDecoration(border: Border.all()),
                ),
                CupertinoTextFormFieldRow(
                  controller: txtemail,
                  keyboardType: TextInputType.emailAddress,
                  prefix: Icon(CupertinoIcons.mail),
                  placeholder: 'Required',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please valid email";
                    } else if (!RegExp(
                            "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                        .hasMatch(value)) {
                      return "enter the valid email";
                    }
                    return null;
                  },
                  decoration: BoxDecoration(border: Border.all()),
                ),
                CupertinoTextFormFieldRow(
                  controller: txtcontact,
                  keyboardType: TextInputType.number,
                  prefix: Icon(CupertinoIcons.phone),
                  placeholder: 'Required',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Valid Contact";
                    } else if (value!.length != 10) {
                      return "Enter the valid number";
                    }
                    return null;
                  },
                  decoration: BoxDecoration(border: Border.all()),
                ),
                Row(
                  children: [
                    CupertinoButton(
                      child: Icon(CupertinoIcons.calendar),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                           Container(
                             height: 200,
                             color: Colors.white,
                             child: CupertinoDatePicker(
                              initialDateTime: providerR!.d1,
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (value) {
                                providerR!.changdate(value);
                              },
                             ),
                           ),
                        );
                      },
                    ),
                    Text("Date: ${providerR!.d1.day}-${providerR!.d1.month}-${providerR!.d1.year}"),
                  ],
                ),
                Row(
                  children: [
                    CupertinoButton(child: Icon(CupertinoIcons.time), onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) =>
                            Container(
                                height: 200,
                                color: Colors.white,
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  mode: CupertinoDatePickerMode.time,
                                  onDateTimeChanged: (value) {
                                    TimeOfDay? t1=TimeOfDay(hour: value.hour, minute: value.minute);
                                    providerR!.changetime(t1!);
                                  },
                                )
                            ),
                      );
                    }
    ),
                    Text("${providerR!.t1.hour}:${providerR!.t1.minute}",style: TextStyle(color: Colors.black),)
                  ],
                ),
                CupertinoButton(
                  child: const Text(
                    "save",
                  ),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      DataModel d1 = DataModel(
                        name: txtname.text,
                        email: txtemail.text,
                        call: txtcontact.text,
                        time: "",
                        date: "",
                        image: providerR!.path,
                      );
                      txtname.clear();
                      txtemail.clear();
                      txtcontact.clear();
                      providerR!.adddata(d1);
                      providerR!.path = "";
                      providerS!.pageIndex=0;
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
