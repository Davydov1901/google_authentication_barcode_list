import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Вхід',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            FloatingActionButton.extended(
              onPressed: () {
                //controller.login();
                final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
          },
              icon: Image.asset(
                'assets/google_icon.jpg',
                height: 30,
                width: 30,
              ),
              label: Text('Увійти за допомогою гугл'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ])),
    );
  }
}

class GoogleSignInProvider extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
