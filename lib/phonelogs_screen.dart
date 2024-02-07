import 'package:flutter/material.dart';
import './phone_textfield.dart';
import 'package:call_log/call_log.dart';
import './callLogs.dart';
import './phone_textfield.dart';

class PhonelogsScreen extends StatefulWidget {
  const PhonelogsScreen({super.key});

  @override
  State<PhonelogsScreen> createState() => _PhonelogsScrrenState();
}

class _PhonelogsScrrenState extends State<PhonelogsScreen>
    with WidgetsBindingObserver {
  PhoneTextField pt = new PhoneTextField();
  CallLogs cl = new CallLogs();
  late AppLifecycleState _notification;
  late Future<Iterable<CallLogEntry>> logs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    logs = cl.getCallLogs();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (AppLifecycleState.resumed == state) {
      setState(() {
        logs = cl.getCallLogs();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Log"),
      ),
      body: Column(
        children: [
          pt,
          FutureBuilder(
              future: logs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Iterable<CallLogEntry>? entries = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Card(
                            child: ListTile(
                              leading: cl
                                  .getAvator(entries.elementAt(index).callType),
                              title: cl.getTitle(entries.elementAt(index)),
                              subtitle: Text(cl.formatDate(
                                      new DateTime.fromMillisecondsSinceEpoch(
                                          entries.elementAt(index).timestamp
                                              as int)) +
                                  "\n" +
                                  cl.getTime(entries.elementAt(index).duration
                                      as int)),
                              isThreeLine: true,
                              trailing: IconButton(
                                icon: Icon(Icons.phone),
                                color: Colors.green,
                                onPressed: () {
                                  cl.call(entries.elementAt(index).number
                                      as String);
                                },
                              ),
                            ),
                          ),
                          onTap: () => pt.update(
                              entries.elementAt(index).number.toString()),
                        );
                      },
                      itemCount: entries!.length,
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
      
    );
  }
}
