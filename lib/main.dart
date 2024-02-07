import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tprj/phonelogs_screen.dart';

import 'package:oktoast/oktoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Phone Log',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> delay(int milli) async {
    await Future.delayed(Duration(milliseconds: milli));
  }

  openPhonelogs() {
    delay(3000);
    Navigator.pushReplacement(
      (context),
      MaterialPageRoute(
        builder: (context) => PhonelogsScreen(),
      ),
    );
  }

  checkpermission_phonelogs() async {
    if (await Permission.phone.request().isGranted &&
        await Permission.contacts.request().isGranted) {
      openPhonelogs();
    } else {
      showToast("Provide permission to access call logs",
          position: ToastPosition.bottom);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      checkpermission_phonelogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'PhoneLog',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
