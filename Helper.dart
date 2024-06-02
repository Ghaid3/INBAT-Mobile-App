import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper{
  static Future<void> sendEmail(String emailAddress, String subject,
      String body, BuildContext context) async {
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.SEND',
        type: 'message/rfc822',
        arguments: {
          'android.intent.extra.EMAIL': emailAddress,
          'android.intent.extra.SUBJECT': subject,
          'android.intent.extra.TEXT': body,
        },
      );

      try {
        await intent.launch();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Failed to send email. Please check your device's capabilities."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      String encodedSubject = Uri.encodeComponent(subject);
      String encodedBody = Uri.encodeComponent(body);
      String emailUrl =
          "mailto:$emailAddress?subject=$encodedSubject&body=$encodedBody";

      if (await canLaunch(emailUrl)) {
        await launch(emailUrl);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Failed to send email. Please check your device's capabilities."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static Future<void> sendSMS(
      String phoneNumber, String message, BuildContext context) async {
    String smsUrl = "sms:$phoneNumber?body=$message";

    if (await canLaunch(smsUrl)) {
      await launch(smsUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Failed to send SMS. Please check your device's capabilities."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



}