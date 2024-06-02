import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/SMS_Email_Notification/Helper.dart';
import 'package:project/SMS_Email_Notification/notification.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String name = "", email = "", feedback = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
          child: Stack(
        children: [
          Container(
            color: Colors.green,
          ),
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        //width: .75*MediaQuery.of(context).size.width,
                        height: .76 * MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),

                        padding: const EdgeInsets.all(20.0),
                        child: ListView(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                  child: Container(
                                height: 150,
                                width: 110,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("images/logo.png"),
                                )),
                              )
                                  //Image.asset("images/logo.png")
                                  ),
                              const SizedBox(
                                height: 30,
                              ),
                              const SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  child: Text(
                                    "We are here to make buying plants easy by delivering healthy, "
                                    "ready to go plants at your home and setting you up with the tips and "
                                    "tricks you’ll need to make the plants thrive. Plants have the power to "
                                    "lift our spirits, calm our minds and clean the air we breathe. "
                                    "Decorate your home, office and bedroom with indoor plants like succulents, "
                                    "snake plants, air plants and more. Choose from our large varieties of "
                                    "indoor plants. Plants make your lives better and we make plants easy.",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.green),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Center(
                                child: Text(
                                  'Feedback Form',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                width: 170,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 30, left: 30),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      // Update the 'name' variable when the input changes
                                      setState(() {
                                        name = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              SizedBox(
                                width: 170,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 30, left: 30),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      // Update the 'name' variable when the input changes
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              SizedBox(
                                width: 170,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 30, left: 30),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Feedback',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      // Update the 'name' variable when the input changes
                                      setState(() {
                                        feedback = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                width: 170,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 60, left: 60),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      saveFeedbackToFile(name, email, feedback);

                                      // Call _showNotification
                                      NotificationWidget.showNotification(title:'Notification',body:'Your Feedback Has Been Received');

                                    },
                                    child: const Text('Submit'),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // ignore: prefer_const_constructors
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //ElevatedButton(onPressed: _sendSMS, child: const Text("Send SMS")),
                                  IconButton(
                                      onPressed: () => _sendSMS(context),
                                      icon: const Icon(Icons.sms_outlined)),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  // ElevatedButton(onPressed: _sendEmail, child: const Text("Send Email")),
                                  IconButton(
                                      onPressed: () => _sendEmail(context),
                                      icon: const Icon(Icons.email_outlined)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ]
                        ),
                      )
                    ],
                  ),
                ],
              ))
        ],
      )),
    ));
  }
}

dynamic fileDirector() async {
  var dir = await getApplicationDocumentsDirectory();
  print("path *********************** : ${dir.path}");
  return dir.path;
}

Future<File> saveFeedbackToFile(
    String name, String email, String feedback) async {
  final dir = await fileDirector();
  final file = File('$dir/feedback.txt');
  return await file.writeAsString(
      'Name: $name\nEmail: $email\nFeedback: $feedback\n\n',
      mode: FileMode.append);
}

_sendSMS(BuildContext context) {
  Helper.sendSMS(
      "0096893300733",
      "I would like to book a plant "
          " plant.",
      context);
}

void _sendEmail(BuildContext context) {
  Helper.sendEmail(
      "plantsShop@gmail.com",
      "Ask About Shop",
      "Hello,\n\nI would like to ask a question "
          ".\n\nThank you.",
      context);
}