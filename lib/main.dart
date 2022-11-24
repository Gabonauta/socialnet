import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialnet/state/auth/backend/authenticator.dart';
import 'firebase_options.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () async {
                final result = await Authenticator().logInWithGoogle();
                result.log();
              },
              child: const Text("Sign In With Google"),
            ),
            TextButton(
              onPressed: () async {
                final result = await Authenticator().loginWitFacebook();
                result.log();
              },
              child: const Text("Sign In With Facebook"),
            )
          ],
        ));
  }
}
