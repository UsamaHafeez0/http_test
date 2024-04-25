import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:uno/uno.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    var url =
        'https://prd.drops.online/s/Drops/dw/shop/v23_1/product_search?expand=prices%2Cavailability%2Cimages&count=10&start=0&refine_1=cgid%3DB10076&refine_2=price%3D%280.01..1000000%29&locale=en-KW&locationId=kwt_009';

    String token =
        'eyJfdiI6IjEiLCJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfdiI6IjEiLCJleHAiOjE3MTQwNDkwODAsImlhdCI6MTcxNDA0NzI4MCwiaXNzIjoiNGMyMDBiYmMtMWMwOS00N2IxLWE0YzMtOTIwNGU3ODBkMThlIiwic3ViIjoie1wiX3ZcIjpcIjFcIixcImN1c3RvbWVyX2luZm9cIjp7XCJjdXN0b21lcl9pZFwiOlwiYWRhR2lEZzVvMk5QeW1ieWh6b2x0cmZHNWJcIixcImd1ZXN0XCI6dHJ1ZSxcInZpc2l0X2lkXCI6XCI2NmRiYzE5YmNjZmI2YzVmODE0YTEwYzc2YlwifX0ifQ.dl8XgldAVo8SGRDrrSAdnbD_tnRnfYwIrohjhsPW78JgTif2kukQqnB74RgKHRx6U5CTBee8ktTVwqnmtguRTz_xdBI5eTinUFQtcYprNPC4KO_muBg3YavmhEeFEk3p-Xyq8IGphYxb_FDeYuUxO_v3mnr3FDdByuzPbI9UoQLSVv0NPiEhkoCIDaYdBd8FJhP0qgkSXv6pwyjt1ehOrLlxhpGEVEes8wrHOVkYYe16Y2NpG_mOX_gOmYm_m7hJzKuY4zU90SGc-GYkbBKfRPK3GthTr0LNXVsknydirpsZDI1hlBjrCxNz689-ogulIKkCi2FNd175N7mIZCS3LqBvuMRr8Beo8yI39u3T8UXh3d7fcyejJwRvtQaHBptg6h0oBMECPKh_kp90uxy_dk_2yEjnvWV1qcPTol5xK-_9dvZR-E9Cf7p-CLmK7kpknoCAQmP-vsGJudyJNTQlxXyRYyUL9h-Az9p5Cdr0B5jw9hZshuzLXr50o2rSyeNxAgugEEU_SAiJWF9aVHj26HOLfW5IOh15axSjhPPlk75Ivh5rPMOaPA63cn402Ktp';
    IOClient client = IOClient();
    var httpClient = HttpClient();
    var htt = http.Client();
    final dio = Dio();
    final uno = Uno();
    var stopwatch = Stopwatch();

    List<Map<String, dynamic>> methods = [
      {
        'name': 'Http.....Client',
        'method': () async {
          var response = await htt
              .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
          print('Status code: ${response.statusCode}');
        }
      },
      {
        'name': 'IOClient',
        'method': () async {
          var response = await client
              .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
          print('Status code: ${response.statusCode}');
        }
      },
      {
        'name': 'HttpClient',
        'method': () async {
          var request = await httpClient.getUrl(Uri.parse(url));
          request.headers.set("Authorization", "Bearer $token");
          var response = await request.close();
          print('Status code: ${response.statusCode}');
        }
      },
      {
        'name': 'http',
        'method': () async {
          var response = await http
              .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
          print('Status code: ${response.statusCode}');
        }
      },
      {
        'name': 'Dio',
        'method': () async {
          var response = await dio.get(url,
              options: Options(headers: {"Authorization": "Bearer $token"}));
          print('Status code: ${response.statusCode}');
        }
      },
      {
        'name': 'Uno',
        'method': () async {
          var response = await uno.get(url,
              headers: {"Authorization": "Bearer $token"});
          print('Status code: ${response.status}');
        }
      },
    ];

    for (var method in methods) {
      var times = [];
      for (var i = 0; i < 10; i++) {
        stopwatch.start();
        await method['method']();
        stopwatch.stop();
        print('${method['name']} - ${i+1}: ${stopwatch.elapsedMilliseconds}');
        times.add(stopwatch.elapsedMilliseconds);
        stopwatch.reset();
      }
      print(
          '${method['name']} average time: ${times.reduce((a, b) => a + b) / times.length}ms');
    }

    // /// ========== IOClient
    // IOClient client = IOClient();
    // var stopwatch = Stopwatch()..start();
    // final http.Response resp = await client.get(
    //   Uri.parse(url),
    //   headers: {"Authorization": token},
    // );
    // stopwatch.stop();
    // print('IOClient took ${stopwatch.elapsedMilliseconds}ms');
    // /// ==========

    // /// ========== HTTP Client
    // var httpClient = HttpClient();
    // stopwatch.reset();
    // stopwatch.start();
    // var s = await client.get(Uri.parse(url));
    // stopwatch.stop();
    // // print(s.body);
    // print('Http Client took ${stopwatch.elapsedMilliseconds}ms');
    // /// ==========

    // /// ========== HTTP
    // stopwatch.reset();
    // stopwatch.start();
    // await http.get(
    //   Uri.parse(url),
    //   headers: {"Authorization": "Bearer $token"},
    // );
    // stopwatch.stop();
    // print('Http took ${stopwatch.elapsedMilliseconds}ms');
    // /// ==========

    // /// ========== DIO
    // final dio = Dio();
    // ///
    // stopwatch.reset();
    // stopwatch.start();
    // final response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));
    // stopwatch.stop();
    // // print(response.data);
    // print('Dio took ${stopwatch.elapsedMilliseconds}ms');
    // /// ==========
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
