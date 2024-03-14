import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor/screen/provider/desh_provider.dart';
import 'package:platform_convertor/screen/provider/platform_provider.dart';
import 'package:provider/provider.dart';

import '../../model/model.dart';

class AddcontactScreen extends StatefulWidget {
  const AddcontactScreen({super.key});

  @override
  State<AddcontactScreen> createState() => _AddcontactScreenState();
}

class _AddcontactScreenState extends State<AddcontactScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtcontact = TextEditingController();
  String path="";
  File? imageFile;
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
        child: Scaffold(
          appBar: AppBar(
            title: Text("New Contact",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
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
                  TextFormField(
                    controller: txtname,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Valid Name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Full Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtemail,
                    keyboardType: TextInputType.emailAddress,

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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtcontact,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Valid Contact";
                      }
                      else if (value!.length != 10) {
                        return "Enter the valid number";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Phone Number",
                      prefixIcon: Icon(Icons.phone_rounded),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                     IconButton(onPressed: () async{
                       DateTime? d1= await showDatePicker(context: context, firstDate: DateTime(2020), lastDate: DateTime(2050));
                       providerR!.changdate(d1!);
                     }, icon: Icon(Icons.calendar_month_outlined)),
                    Text("Date: ${providerR!.d1.day}-${providerR!.d1.month}-${providerR!.d1.year}")
                      ]
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () async{
                        TimeOfDay? t1= await showTimePicker(context: context, initialTime:providerR!.t1);
                        TimeOfDay t2=TimeOfDay(hour: t1!.hour, minute: t1!.minute);
                        providerR!.changetime(t2!);
                      }, icon: Icon(Icons.timer)),
                      Text("${providerR!.t1.hour}:${providerR!.t1.minute}")
              
                    ],
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
            ),
          ),
        ),
      ),
    );
  }
}
