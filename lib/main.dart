import 'package:bmi_task/screens/login_screen.dart';
import 'package:bmi_task/screens/tracker_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main()async
 {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(  
  
);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:StreamBuilder(stream: FirebaseAuth.instance.userChanges(), builder: (context, snapshot) {
        if(snapshot.hasData){
          return TrackerScreen();
        }else{return LoginScreen();}
      },)
      
    );
  }
}
