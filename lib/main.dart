import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(useMaterial3: true),
      darkTheme: ThemeData.dark().copyWith(useMaterial3: true),
      home: const Sample(),
    );
  }
}

class Sample extends StatelessWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Icon(Icons.north),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: FutureBuilder(
                  future: http.get(
                    Uri.parse('https://iocontrol.ru/api/readData/esp32cam/x'),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
