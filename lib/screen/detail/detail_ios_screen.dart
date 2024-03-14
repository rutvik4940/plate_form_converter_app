import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/model.dart';
import '../provider/platform_provider.dart';

class DetailIosScreen extends StatefulWidget {
  const DetailIosScreen({super.key});

  @override
  State<DetailIosScreen> createState() => _DetailIosScreenState();
}

class _DetailIosScreenState extends State<DetailIosScreen> {
  int index = 0;
  String path = "";
  TextEditingController txtname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtcontact = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  PlatformProvider? providerR;
  PlatformProvider? providerW;

  @override
  Widget build(BuildContext context) {
    index = ModalRoute.of(context)!.settings.arguments as int;
    providerR = context.read<PlatformProvider>();
    providerW = context.watch<PlatformProvider>();
    return SafeArea(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(" Detail "),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                child: Icon(CupertinoIcons.eyedropper),
                onPressed: () {
                  editDialog(context, index);
                },
              ),
              CupertinoButton(
                child: Icon(CupertinoIcons.delete),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text("Alert"),
                      content: Text("Are You Sure?"),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('NO'),
                          isDestructiveAction: true,
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () {
                            providerR!.deleteContact(index);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('YES'),
                        ),

                 ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              providerW!.platformList[index].image==null?
              Center(
                child: CircleAvatar(
                  radius: 50,
                ),
              )
             : Center(
               child: CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(
                      File("${providerW!.platformList[index].image}")),
                ),
             ),
              SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${providerW!.platformList[index].name}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CupertinoButton(
                  child: Icon(CupertinoIcons.phone),
                  onPressed: () async {
                    String link =
                        "tel:+91${providerR!.platformList[index].call}";
                    await launchUrl(Uri.parse(link));
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                CupertinoButton(
                  child: Icon(CupertinoIcons.text_bubble_fill),
                  onPressed: () async {
                    String link =
                        "sms:+91${providerR!.platformList[index].call}";
                    await launchUrl(Uri.parse(link));
                  },
                ),
                CupertinoButton(
                  child: Icon(CupertinoIcons.share),
                  onPressed: () async {
                    Share.share(
                        "${providerW!.platformList[index].name}-${providerW!.platformList[index].call}");
                  },
                ),
              ],),
              SizedBox(
                height: 20,
              ),
              Text("Contact info",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(CupertinoIcons.phone),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("${providerW!.platformList[index].call}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(CupertinoIcons.mail),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${providerW!.platformList[index].email}",
                    style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editDialog(BuildContext context, int index) {
    txtcontact.text = providerR!.platformList[index].call!;
    txtemail.text = providerR!.platformList[index].email!;
    txtname.text = providerR!.platformList[index].name!;
    // providerR!.edit(providerR!.platformList[index].image!);
    if(providerR!.platformList[index].image==null)
    {
      providerR!.editI("");
    }
    else
    {
      providerR!.editI(providerR!.platformList[index].image!);
    }

    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Form(
            key: key,
            child: SingleChildScrollView(
              child: CupertinoAlertDialog(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          providerW!.editimage!.isEmpty
                              ? const CircleAvatar(
                            radius: 50,
                          )
                              : CircleAvatar(
                            radius: 50,
                            backgroundImage:
                            FileImage(File(providerW!.editimage!)),
                          ),
                          Align(
                            alignment: const Alignment(0.5, 0.5),
                            child: IconButton(
                              onPressed: () async {
                                ImagePicker picker = ImagePicker();
                                XFile? image = await picker.pickImage(
                                    source: ImageSource.camera);
                                providerR!.edit(image!.path);
                              },
                              icon: const Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.blueAccent,
                                weight: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                Center(
                  child: CupertinoButton(
                    child:Text("Save"),
                    onPressed: () async {
                                 if (key.currentState!.validate()) {
                   DataModel c3 = DataModel(
                       name: txtname.text,
                       call: txtcontact.text,
                       image: providerR!.editimage,
                       email: txtemail.text,
                       time: "",
                       date: "",
                    );
                      providerR!.updateContact(index: index, c2: c3);
                      txtname.clear();
                      txtcontact.clear();
                      txtemail.clear();
                      Navigator.pop(context);
                      }
                      },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    );
  }
}
