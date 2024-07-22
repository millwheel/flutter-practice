import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hello Flutter',
            style: TextStyle(fontSize: 28),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.network(
                    "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                    width: 81,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'email'),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'password'),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('로그인'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
