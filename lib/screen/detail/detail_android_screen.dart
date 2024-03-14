import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/model.dart';
import '../provider/platform_provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int index = 0;
  bool isright = true;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Are you sure?"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  providerR!.deleteContact(index);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No")),
                          ],
                        ),
                      );
                    },
                    child: const Text("Delet")),
                PopupMenuItem(
                    onTap: () {
                      editDialog(context, index);
                    },
                    child: const Text("Edit")),
                PopupMenuItem(
                    onTap: () {
                      Share.share(
                          "${providerW!.platformList[index].name}-${providerW!.platformList[index].call}");
                    },
                    child: const Text("Share")),
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              providerW!.platformList[index].image==null?
              Center(
                child: CircleAvatar(
                  radius: 50,
                ),
              )
              :Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(
                      File("${providerW!.platformList[index].image}")),
                ),
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
                IconButton.filled(
                  onPressed: () async {
                    String link =
                        "tel:+91${providerR!.platformList[index].call}";
                    await launchUrl(Uri.parse(link));
                  },
                  icon: const Icon(Icons.call),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton.filled(
                  onPressed: () async {
                    String link =
                        "sms:+91${providerR!.platformList[index].call}";
                    await launchUrl(Uri.parse(link));
                  },
                  icon: const Icon(Icons.message),
                ),
              ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Contact info",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text("${providerW!.platformList[index].call}",
                  style: const TextStyle(
                      fontSize: 20,)),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${providerW!.platformList[index].email}",
                style:
                    const TextStyle(fontSize: 20,),
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

    showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: key,
            child: SingleChildScrollView(
              child: AlertDialog(
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
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                DataModel c3 = DataModel(
                                  name: txtname.text,
                                  call: txtcontact.text,
                                  image: providerR!.editimage,
                                  email: txtemail.text,
                                  time: '',
                                  date: '',
                                );
                                providerR!.updateContact(index: index, c2: c3);
                                txtname.clear();
                                txtcontact.clear();
                                txtemail.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "update",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          );
        });
  }
}
