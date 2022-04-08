import 'package:demo_eco/presentation/authentication_screen/login_screen.dart';
import 'package:demo_eco/presentation/authentication_screen/phone_auth_screen.dart';
import 'package:demo_eco/presentation/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser != null){
      return MaterialApp(home: HomeConnect());
    }
    else{
      return MaterialApp(home: LoginScreen());
    }
  }
}