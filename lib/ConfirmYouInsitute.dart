import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:epreparing/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'addStudentScreen.dart';

class ConfirmYouInstitute extends StatefulWidget {
  const ConfirmYouInstitute({Key? key}) : super(key: key);

  @override
  State<ConfirmYouInstitute> createState() => _ConfirmYouInstituteState();
}

class _ConfirmYouInstituteState extends State<ConfirmYouInstitute> {
  bool isObsecure=true;

  final _formKey=GlobalKey<FormState>();

  TextEditingController _email=TextEditingController();
  TextEditingController _pass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ),);
    return Scaffold(
      backgroundColor: Colors.teal,

      body:Stack(
        children: [
          Align(alignment: Alignment.topCenter,child: Container(
            width: w,
            height: h*0.3,
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
          )),

          Align(alignment: Alignment.bottomCenter,child: Container(
            width: w,
            height: h*0.7,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
            ),
          )),
          Align(alignment: Alignment.center,child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: w*0.05),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 10,
              child: Container(
                  width: w,
                  height: h*0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: w*0.05),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: h*0.03,),
                          Flexible(child: styled(text: 'Sign in to confirm', color: Colors.teal, weight: FontWeight.bold, size: h*0.025)),
                          SizedBox(height: h*0.1,),
                          TextFormField(
                            controller: _email,
                            validator: (value){
                              if(!EmailValidator.validate(value!)){
                                return 'Incorrect email';
                              }
                              else{
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.grey[700],fontSize: h*0.02),
                              decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.teal,fontSize: h*0.02),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey,width: 0.8),
                              ),
                              focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2),
                          ),
                              enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey,width: 0.6),
                          )
                            ),
                          ),
                        SizedBox(height: h*0.03,),
                        TextFormField(
                          controller: _pass,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Empty password field';
                            }
                            else{
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.grey[700],fontSize: h*0.02),
                          obscureText: isObsecure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.teal,fontSize: h*0.02),
                            suffixIcon: InkWell(
                              onTap: (){
                                setState((){
                                  if(isObsecure){
                                    isObsecure=false;
                                  }
                                  else{
                                    isObsecure=true;
                                  }
                                });
                              },
                              child: Icon(isObsecure?Icons.visibility_off:Icons.visibility),
                            ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey,width: 0.8),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal,width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey,width: 0.6),
                              )
                          ),
                        ),

                        SizedBox(height: h*0.07,),
                        ElevatedButton(onPressed: ()async{
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();

                            String email=_email.text.toString();
                            String password=_pass.text.toString();

                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: email, password: password).then((value){
                                User? user=FirebaseAuth.instance.currentUser;
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>addStudentScreen(uid: user!.uid,)));

                              });
                            }
                            on FirebaseException catch(e){
                              if(e.message=="auth/invalid-password"){
                                Fluttertoast.showToast(msg:"Invalid password" );
                              }
                              Fluttertoast.showToast(msg: e.toString());
                            }
                          }

                        }, child:styled(text: 'Confirm', color: Colors.white, weight: FontWeight.bold, size: h*0.023),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          backgroundColor: Colors.teal,
                            minimumSize: Size(w*0.5,h*0.052)
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
        ],
      )
    );
  }
}
