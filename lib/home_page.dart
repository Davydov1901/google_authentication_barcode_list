import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_authentication_barcode_list/barcode_list_page.dart';
import 'package:google_authentication_barcode_list/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  //final controller = Get.put(LoginController());

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Container(child: CircularProgressIndicator());
            else if(snapshot.hasData)
              return BarcodeListPage();
            else if(snapshot.hasError)
              return Center(child: Text('Щось пішло не так'));
            else
              return LoginPage();
          },
        ));
  }
}

/*
Center(
        child: Obx(() {
          if (controller.googleAccount.value == null)
            return LoginPage();
          else
            return BarcodeListPage();
        }),
      )
 */