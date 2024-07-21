import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text(
              'Hello Flutter',
              style: TextStyle(fontSize: 28),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'email'),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'password'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('로그인'),
            )
          ],
        ),
      ),
    );
  }
}
