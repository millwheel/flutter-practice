import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quiz = "";

  Future<String> getNumberTrivia() async {
    Response result = await Dio().get('http://numbersapi.com/random/trivia');
    String trivia = result.data;
    return trivia;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.pinkAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // quiz
            Expanded(
              child: Center(
                child: Text(
                  quiz,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // New Quiz 버튼
            SizedBox(
              height: 42,
              child: ElevatedButton(
                child: Text(
                  "New Quiz",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 24,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () async {
                  quiz = await getNumberTrivia();
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
