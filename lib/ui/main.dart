import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do/ui/home_screen.dart';
import 'package:to_do/ui/my_theme.dart';

import '../firebase_options.dart';


void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {HomeScreen.routeName: (_) => HomeScreen()},
        initialRoute: HomeScreen.routeName,
        theme: MyTheme.LightTheme);
  }
}
