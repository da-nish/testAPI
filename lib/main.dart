import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_project/item_model.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // call();
  }

  Future<List<Item>> call() async {
    http.Response response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    List<Item> items = (jsonDecode(response.body) as List)
        .map((e) => Item.fromJson(e))
        .toList();
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<Item>>(
          future: call(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Item> data = snapshot.data ?? [];
              return ListView.builder(itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: Row(
                      children: [
                        Image.network(
                          data[index].thumbnailUr,
                          height: 28,
                          width: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(data[index].title.toUpperCase())),
                      ],
                    ));
              });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
