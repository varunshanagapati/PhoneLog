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
        title: 'Phone Log',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  openPhonelogs() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhonelogsScreen(),
      ),
    );
  }

  checkpermission_phonelogs() async {
    if (await Permission.phone.request().isGranted) {
      await Permission.contacts.request();
      openPhonelogs();
    } else {
      showToast("Provide permission to access call logs",
          position: ToastPosition.bottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Varun'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: IconButton(
                onPressed: checkpermission_phonelogs,
                icon: Icon(Icons.phone),
                iconSize: 42,
                color: Colors.white,
              ),
              color: Colors.deepPurple,
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height - 80) / 2,
            ),
          ],
        ),
      ),
    );
  }
}
