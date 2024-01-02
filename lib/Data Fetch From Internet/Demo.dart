import 'dart:async';
import 'package:flutter/material.dart';
import 'Model.dart';
import 'Network.dart';




class Demo extends StatefulWidget {

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = network.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          actions: [
            InkWell(
                onTap: (){},
                child: Stack(
                    children: [
                      Positioned(
                         top:10,
                        child: CircleAvatar(
                          radius: 10,

                          backgroundColor: Colors.blue,),
                      ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.notifications))
    ]))
          ],
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}