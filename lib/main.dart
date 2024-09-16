import 'package:flutter/material.dart';
import 'package:remotestoragelite/appprovider.dart';
import 'package:remotestoragelite/src/presentation/view/DirectoryView.dart';
import 'package:remotestoragelite/src/presentation/view/NetworkConnectionView.dart';
import 'package:remotestoragelite/src/presentation/view/ToastMessageView.dart';

void main() {
  runApp(AppProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remote Storage Lite',
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
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Expanded(flex: 7, child: DirectoryView()),
              Expanded(flex: 2, child: NetworkConnectionView()),
              Expanded(flex: 1, child: ToastMessageView())
            ])));
  }
}
