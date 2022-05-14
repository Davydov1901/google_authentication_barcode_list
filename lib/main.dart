import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_authentication_barcode_list/home_page.dart';
import 'package:google_authentication_barcode_list/login_page.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: Scaffold(
          body: Center(
            child: HomePage(),
          ),
        ),
      ));
}
