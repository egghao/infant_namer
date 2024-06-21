import 'package:flutter/material.dart';
import 'baby_naming_service.dart';  // Import the baby naming service file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI命名大師',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Noto Sans SC',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.pinkAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'AI命名大師',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '首頁',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '關於我們',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '客服',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '聯繫我們',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BabyNamingServicePage()),
                            );
                          },
                          child: const Text('開始體驗'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Center(
                  child: Column(
                    children: [
                      Text(
                        '歡迎來到AI命名大師',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '手指輕點，為孩子取名可以輕鬆點',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BabyNamingServicePage()),
                          );
                        },
                        child: const Text('開始體驗'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}