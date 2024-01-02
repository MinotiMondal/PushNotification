import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
static const route ='/NotificationScreen';

  @override
  Widget build(BuildContext context) {
    final NotificationScreen mess=ModalRoute.of(context)!.settings.arguments as NotificationScreen;
   // if (message == null) return SizedBox.shrink();
    return Scaffold(
      appBar:  AppBar(title: Text("Push notification"),),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Text('${mess.}'),
            Text('${mess.}'),
            Text('${message.data}'),


          ],),
      ),
    );

  }
}
