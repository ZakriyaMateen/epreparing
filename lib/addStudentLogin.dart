import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:epreparing/Colors.dart';
import 'package:epreparing/addStudentScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class addStudentLogin extends StatefulWidget {
  final String uid;
  const addStudentLogin({Key? key, required this.uid}) : super(key: key);

  @override
  State<addStudentLogin> createState() => _addStudentLoginState();
}

class _addStudentLoginState extends State<addStudentLogin> {
  bool isHidden=true;
  final formKey=GlobalKey<FormState>();
  final scaffoldKey=GlobalKey<ScaffoldState>();
  TextEditingController _name=TextEditingController();
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

      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Material(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(200)),
            elevation: 5,
            child: Container(
              child: Center(
                child: styled(text: 'Add Student', color: Colors.white, weight: FontWeight.bold, size: h*0.025),
              ),
              width: w,
              height: h*0.3,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(200))
              ),
            ),
          ),
          SizedBox(height: h*0.05,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w*0.06),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Material(
                    color: Colors.white,
                    elevation: 3,
                    borderRadius: BorderRadius.circular(15),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Empty name field';
                        }
                        else{
                          return null;
                        }

                      },
                      controller: _name,
                      style: TextStyle(color: Colors.grey[700],fontSize: h*0.02),
                      decoration: InputDecoration(
                        labelText: 'Name',

                        labelStyle: TextStyle(color: Colors.teal,fontSize: h*0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(width: 1)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.teal,width: 2)
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h*0.0175,),
                  Material(
                    color: Colors.white,
                    elevation: 3,
                    borderRadius: BorderRadius.circular(15),
                    child: TextFormField(
                      validator: (value){
                        if(!EmailValidator.validate(value!)){
                          return 'Incorrect email';
                        }
                        else{
                          return null;
                        }
                      },
                      controller: _email,

                      style: TextStyle(color: Colors.grey[700],fontSize: h*0.02),
                      decoration: InputDecoration(
                        labelText: 'Email',

                        labelStyle: TextStyle(color: Colors.teal,fontSize: h*0.02),
                        border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(width: 1)
                          ),

                          focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.teal,width: 2)
                    ),
                      ),
                    ),
                  ),


                  SizedBox(height: h*0.0175,),
                  Material(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    elevation: 3,
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Empty password field';
                        }
                        else{
                          return null;
                        }
                      },
                      obscureText: isHidden,
                      controller: _pass,

                      style: TextStyle(color: Colors.grey[700],fontSize: h*0.02),
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: (){
                              if(isHidden){
                                setState((){
                                  isHidden=false;
                                });
                              }
                              else{
                                setState((){
                                  isHidden=true;
                                });
                              }
                            },
                          child: Icon(isHidden?Icons.visibility_off:Icons.visibility),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.teal,fontSize: h*0.02),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(width: 1)
                          ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.teal,width: 2)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h*0.1,),


                  ElevatedButton(onPressed: ()async{
                    if(formKey.currentState!.validate()){
                      formKey.currentState!.save();
                      try{
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(email:_email.text.toString() , password: _pass.text.toString()).then((value) async{

                          try{
                            List<String> splitList=_name.text.toString().split(' ');
                            List<String> indexList=[];

                            for(int i=0;i<splitList.length;i++){
                              for(int j=0;j<=splitList[i].length+i;j++){
                                indexList.add(splitList[i].substring(0,j).toLowerCase());
                              }
                            }
                            User? user=await FirebaseAuth.instance.currentUser;
                            await FirebaseFirestore.instance.collection("Institutes").doc(widget.uid).collection('Students').doc(_email.text.toString()).set({
                              "name":_name.text.toString(),
                              "email":_email.text.toString(),
                              "pass":_pass.text.toString(),
                              "searchIndex":indexList
                            }).then((value)async{
                              await FirebaseFirestore.instance.collection('Student').doc(user!.uid).set({
                                "checkIn":[],
                                "checkOut":[],
                                "dates":[],
                                "uid":user!.uid,

                                "ecatMaths":  "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatMaths.json?alt=media&token=5a6adbe6-47a5-4fe1-8f91-4d2deb6c53f0",
                                "ecatPhysics":  "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatPhysics.json?alt=media&token=5ae81693-47b7-45b4-8f1e-146142318fae",
                                "ecatChemistry":  "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatChemistry.json?alt=media&token=d9b44a71-47b7-4625-bd2f-a684d27e06ed",
                                "ecatEnglish":  "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatEnglish.json?alt=media&token=fd8a4d85-ce83-4a17-9740-4191926c0260",


                                "MdCatMaths":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatMaths.json?alt=media&token=a5be722d-88c3-4f70-b98e-b9b68a4f20df',
                                "MdCatPhysics":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatPhysics.json?alt=media&token=bd5f3cb5-9724-431d-9531-27e6c0830064 ',
                                "MdCatChemistry":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatChemistry.json?alt=media&token=e98e861f-c1da-4444-8cae-d3841b2ff8a0',
                                "MdCatEnglish":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatEnglish.json?alt=media&token=83a2930c-3c14-4416-920e-3766b0c2045e',

                                "firstYearMaths":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/firstYearMaths.json?alt=media&token=6bfe5f50-8950-4055-b212-f4ef7a9e7c6e',
                                "firstYearPhysics":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/firstYearPhysics.json?alt=media&token=6403ce33-674b-49fc-85ca-e0b81656e41e',
                                "firstYearChemistry":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatChemistry.json?alt=media&token=e98e861f-c1da-4444-8cae-d3841b2ff8a0',
                                "firstYearEnglish":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/firstYearEnglish.json?alt=media&token=ffd079f6-c61b-4826-902f-19a51a0357b5',

                                "secondYearMaths":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearMaths.json?alt=media&token=104aba96-b713-4ce3-8d8e-7361f7f7772f',
                                "secondYearPhysics":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearPhysics.json?alt=media&token=7222673b-7877-43d9-8d29-a5a176a54134',
                                "secondYearChemistry":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearChemistry.json?alt=media&token=767caf47-238a-4753-bfe6-7595e747dac9',
                                "secondYearEnglish":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearEnglish.json?alt=media&token=f5c0f675-46c6-4d9c-94cf-811b0cf961f9'

                              });
                            });
                          }
                          catch(e){
                            Fluttertoast.showToast(msg: e.toString());
                          }

                        }).then((value){
                          scaffoldKey.currentState!.showSnackBar(const SnackBar(content: Text("Student registered successfully")));
                          Navigator.pop(context);
                        });

                      }
                      catch(e){
                        Fluttertoast.showToast(msg: e.toString());
                      }

                    }
                  }, child:styled(text: 'ADD', color:Colors.white, weight: FontWeight.bold, size: h*0.024),
                  style:OutlinedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: Size(w*0.7,h*0.052),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  )
                    ,)
                ],
              ),
            ),
          ),
        ],
      )


    );
  }
}
