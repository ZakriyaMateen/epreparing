

import 'package:epreparing/ConfirmYouInsitute.dart';
import 'package:epreparing/Dashboard.dart';
import 'package:epreparing/SeeResultScreen.dart';
import 'package:epreparing/addAttendance.dart';
import 'package:epreparing/addStudentScreen.dart';
import 'package:epreparing/orientation.dart';
import 'package:epreparing/seeAttendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'LoginScreen.dart';
import 'addStudentLogin.dart';
import 'del.dart';

void main() async{
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values,);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ),);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(

      const app());
}


class app extends StatefulWidget {
  const app({Key? key}) : super(key: key);

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {

  @override
  Widget build(BuildContext context) {

    User?user= FirebaseAuth.instance.currentUser;
    return MaterialApp(

      debugShowCheckedModeBanner: false,
        home:user==null? LoginScreen():Dashboard(),
      // home: Dashboard(),
      // home: SeeResultScreen(score: 2, total: 4, index: 0, url:""),
    // home: orientation(index: 0, url: "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearEnglish.json?alt=media&token=f5c0f675-46c6-4d9c-94cf-811b0cf961f9"),

    // home: del()
    );
  }
}
