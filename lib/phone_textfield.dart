import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import './callLogs.dart';

class PhoneTextField extends StatefulWidget {
  late Function update;
  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  TextEditingController t1 = TextEditingController();
  CallLogs cl = new CallLogs();
  bool empty = false;
  @override
  void initState() {
    super.initState();
    widget.update = (text) {
      print('Called: ' + text);
      setState(() {
        
        t1.text = text;
      });
    };
    t1.addListener(() {
      setState(() {});     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: t1,
        decoration: InputDecoration(
            labelText: "Phone Number",
            contentPadding: EdgeInsets.all(10),
            suffixIcon: t1.text.length > 0
                ? IconButton(
                    onPressed: () {
                      cl.call(t1.text);
                    },
                    icon: Icon(Icons.phone))
                : null),
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        onSubmitted: (value) => {cl.call(t1.text)},
        
      ),
      
    );
  }
}
