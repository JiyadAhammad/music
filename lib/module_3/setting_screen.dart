import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/main.dart';
import 'package:music/module_3/refactor/setting_widget.dart';
import 'package:music/module_3/refactor/switch.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        backgroundColor: lightBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            // pushAndRemoveUntil( MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
        child: ListView(children: [
          Settings(
            leadIcon: Icons.notification_add,
            text: 'Notification',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SwitchFunction()));
            },
            // trialing: Icon(
            //   Icons.arrow_right,
            //   color: textWhite,
            // )
            trialing: Switch(
              activeColor: textWhite,
              inactiveTrackColor: Colors.green,
              activeTrackColor: Colors.red,
              // thumbColor: ,
              value: status,
              onChanged: (val) {
                setState(() {
                  status = val;
                });
              },
            ),
          ),
          Settings(
            leadIcon: Icons.privacy_tip,
            text: 'Privacy and Security',
            onTap: () {},
            trialing: Icon(
              Icons.arrow_right,
              color: textWhite,
            ),
          ),
          Settings(
              leadIcon: Icons.share,
              text: 'Share',
              onTap: () {
                Share.share('check out my website https://example.com');
              },
              trialing: Icon(
                Icons.arrow_right,
                color: textWhite,
              )),
          Settings(
            leadIcon: Icons.headphones,
            text: 'Help and Support',
            onTap: () {},
            trialing: Icon(
              Icons.arrow_right,
              color: textWhite,
            ),
          ),
          Settings(
            leadIcon: Icons.perm_device_information,
            text: 'About',
            onTap: () {
              // showLicensePage(context: context,applicationName: 'beat',applicationVersion: '1.0.1.0.1',applicationIcon: Icon(Icons.music_note,),);
              showAboutDialog(
                  context: context,
                  applicationIcon: const Icon(
                    Icons.music_note,
                  ),
                  applicationName: 'beatzz',
                  applicationVersion: '1.0.1.0.1');
            },
            trialing: Icon(
              Icons.arrow_right,
              color: textWhite,
            ),
          )
        ]),
      )),
    );
  }
}

enum PermissionStatus {
  provisional, // iOS Only
  granted,
  unknown,
  denied
}
