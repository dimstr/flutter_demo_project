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
            print("Pressed");
            http.get(Uri.parse('https://iocontrol.ru/api/readData/esp32cam/x')).then((response) {
              print("Response status: ${response.statusCode}");
              print("Response body: ${response.body}");
            }).catchError((error) {
              print("Error: $error");
            });
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Padding(child: FutureBuilder(
                  future: http.get(
                    Uri.parse('https://iocontrol.ru/api/readData/esp32cam/x'),
                  ),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!.body);
                    } else if (snapshot.hasError) {
                      return const Text('ERROR');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                padding: const EdgeInsets.all(15),
              ),
              ),
            );
          },
        ),
      ),
    );
  }
}
