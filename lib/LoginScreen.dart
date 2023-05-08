import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:epreparing/Colors.dart';
import 'package:epreparing/Dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController eLogin=TextEditingController();
  TextEditingController pLogin=TextEditingController();
  TextEditingController eSignup=TextEditingController();
  TextEditingController pSignup=TextEditingController();
  TextEditingController cpSignup=TextEditingController();


  final formKeyLogin= GlobalKey<FormState>();
  final formKeySignup= GlobalKey<FormState>();


  Color disabledBorderColor=Color(0xFF09805C);
  bool isVisible=true;
  bool isVisible2=true;
  bool isVisible3=true;

  bool ?checkBoxValue=false;
  bool ?checkBoxValue1=false;

  bool visiblefirstborder=true;
  bool visiblesecondborder=false;

  Color ?disabledTextColor= Colors.teal[300];
  Color ?enabledTextColor= Colors.teal[100];

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,

      body: Padding(
        padding: EdgeInsets.only(top: h*0.05),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: w*0.07),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.folder_copy,color: Colors.white,size: w*0.06,),
                 Row(
                   children: [
                     Container(
                         decoration: visiblefirstborder?BoxDecoration(
                           border: Border(bottom: BorderSide(color: disabledBorderColor,width: 3)),
                         ):BoxDecoration(),
                         child: Padding(
                           padding:  EdgeInsets.only(bottom: visiblefirstborder? h*0.01:h*0.015  ),
                           child: InkWell(
                               onTap: (){
                                 setState((){
                                   visiblefirstborder=true;
                                   visiblesecondborder=false;
                                 });

                               },
                               child: Text("Sign In",style: style(visiblefirstborder?enabledTextColor:disabledTextColor, weight: FontWeight.bold, size: w*0.05),)),
                         )) ,
                     SizedBox(width: w*0.06,),
                     Container(
                         decoration:visiblesecondborder? BoxDecoration(
                             border:  Border(bottom: BorderSide(color:disabledBorderColor ,width: 3)),
                         ):BoxDecoration(),
                         child: Padding(
                           padding:  EdgeInsets.only(bottom: visiblesecondborder? h*0.01:h*0.015  ),
                           child: InkWell(onTap: (){
                             setState((){

                               visiblefirstborder=false;
                               visiblesecondborder=true;
                             });
                           },child: Text("Sign Up",style: style( visiblesecondborder?enabledTextColor:disabledTextColor, weight: FontWeight.bold, size: w*0.05),)),
                         )) ,

                   ],),],),

                  SizedBox(height: h*0.14,),
                  visiblefirstborder?
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Welcome Back",style: style(Colors.white, weight: FontWeight.bold, size: h*0.036),),
                            SizedBox(height: h*0.01,),
                            Text("Sign in to continue",style: style(disabledTextColor, weight:FontWeight.bold, size: h*0.022),)
                          ],
                        ),
                      )
                      :
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hey, Get on Board",style: style(Colors.white, weight: FontWeight.bold, size: h*0.036),),
                        SizedBox(height: h*0.01,),
                        Text("Sign up to continue",style: style(disabledTextColor, weight:FontWeight.bold, size: h*0.022),)
                      ],
                    ),
                  ),

                        SizedBox(height: h*0.05,),
                ],
              ),

            ),visiblefirstborder?
            Expanded(child: LoginContainer(h: h,w: w)):Expanded(child: SignupContainer(h: h,w: w))

          ],
        ),
      ),
    );
  }
User? user;
  Widget LoginContainer({required double h, required double w}){
    IconData visible=Icons.visibility;
    IconData inVisible=Icons.visibility_off;
    return Container(
      decoration: BoxDecoration(      color: Colors.white,

          borderRadius: BorderRadius.only(topLeft:  Radius.circular(20),topRight: Radius.circular(20))
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: w*0.07,right: w*0.07,top: h*0.08,bottom: h*0.05),
          child: Form(
            key: formKeyLogin,
            child: Column(
                      children: [
                        TextFormField(
                          controller: eLogin,
                          validator: (value){
                            if(!EmailValidator.validate(value!)){
                              return "Invalid email";
                            }
                            else{
                              return null;
                            }
                          },
                          style: style(Colors.grey[700], weight: FontWeight.normal, size: h*0.017),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey,width: 0.7),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black,width: 1),
                            ),
                            labelText: "Email Address",
                            labelStyle: style(Colors.grey[800], weight: FontWeight.bold, size: h*0.021)
                          ),
                        ),
                          SizedBox(height: h*0.02,),
                        TextFormField(controller: pLogin,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter a password";
                            }
                            else{
                              return null;
                            }
                          },
                          style: style(Colors.grey[700], weight: FontWeight.normal, size: h*0.017),

                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                                            onTap: (){
                                                            setState((){
                                                            if(isVisible==false){
                                                              isVisible=true;
                                                            }
                                                            else{
                                                              isVisible=false;

                                                            }
                                                            });},
                                child: Icon(isVisible?inVisible:visible)),
                            prefixIcon: Icon(Icons.lock),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey,width: 0.7),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 1),
                              ),

                              labelText: "Password",
                              labelStyle: style(Colors.grey[800], weight: FontWeight.bold, size: h*0.021)
                          ),
                          obscureText: isVisible,

                        ),
                        SizedBox(height: h*0.018,),
                        Align(alignment: Alignment.centerRight,
                        child:  Text("Forgot Password?",style: style(Colors.yellow[900], weight: FontWeight.bold, size: h*0.021),),),

                        SizedBox(height: h*0.024,),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.yellow[900],
                              value: checkBoxValue,
                              checkColor:Colors.white,
                              onChanged: (value){
                                setState((){
                                  this.checkBoxValue=value;
                                });
                              },
                            ),
                             Flexible(child: InkWell(
                                 onTap: ()async{
                                   try{
                                     user=await FirebaseAuth.instance.currentUser;
                                   }
                                   catch(e){
                                     Fluttertoast.showToast(msg: e.toString());
                                   }
                                   setState((){
                                     checkBoxValue==true?
                                     this.checkBoxValue=false:
                                     this.checkBoxValue=true;
                                   });
                                 },
                                 child: Text("Remember me and keep me logged in",style: style(Colors.grey[500] , weight: FontWeight.bold, size: h*0.015),))
                             )
                          ],
                        ),

                        SizedBox(height: h*0.13,),


                        ElevatedButton(onPressed: () async {

                          if(formKeyLogin.currentState!.validate()){
                            formKeyLogin.currentState!.save();
                            try{

                              await FirebaseAuth.instance.signInWithEmailAndPassword(email: eLogin.text.toString(), password: pLogin.text.toString()).then((value){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                              });
                            }
                            on FirebaseException catch(e){
                              Fluttertoast.showToast(msg: e.toString());
                            }
                          }

                        },
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(w,h*0.07),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: mainColor
                            ),
                            child:Text(
                          "LOGIN",style: style(Colors.white , weight: FontWeight.bold, size: h*0.026 )
                        ))

                      ],
            ),
          ),
        ),
      ),
    );
  }


  Widget SignupContainer({required double h, required double w}){

    IconData visible=Icons.visibility;
    IconData inVisible=Icons.visibility_off;
    return Container(
      decoration: BoxDecoration(      color: Colors.white,

          borderRadius: BorderRadius.only(topLeft:  Radius.circular(20),topRight: Radius.circular(20))
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: w*0.07,right: w*0.07,top: h*0.08,bottom: h*0.05),
          child: Form(
            key: formKeySignup,
            child: Column(
              children: [
                  TextFormField(
                    controller: eSignup,
                    validator: (value){
                      if(!EmailValidator.validate(value!)){
                        return "Invalid email";
                      }
                      else{
                        return null;
                      }
                    },
                    style: style(Colors.grey[700], weight: FontWeight.normal, size: h*0.017),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_rounded),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,width: 0.7),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 1),
                        ),
                        labelText: "Email Address",
                        labelStyle: style(Colors.grey[800], weight: FontWeight.bold, size: h*0.021)
                    ),
                  ),
                  SizedBox(height: h*0.02,),
                  TextFormField(
                    controller: pSignup,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter a password";
                      }
                      if(value!.length<6){
                        return "Password is too week";
                      }
                      else{
                        return null;
                      }
                    },
                    style: style(Colors.grey[700], weight: FontWeight.normal, size: h*0.017),

                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: (){
                              setState((){
                                if(isVisible2==false){
                                  isVisible2=true;
                                }
                                else{
                                  isVisible2=false;

                                }
                              });},
                            child: Icon(isVisible2?inVisible:visible)),
                        prefixIcon: Icon(Icons.lock),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,width: 0.7),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 1),
                        ),

                        labelText: "Password",
                        labelStyle: style(Colors.grey[800], weight: FontWeight.bold, size: h*0.021)
                    ),
                    obscureText: isVisible2,

                  ),
                SizedBox(height: h*0.02,),

                TextFormField(

                  controller: cpSignup,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter a password";
                    }
                    if(value!=pSignup.text.toString()){
                      return "Passwords do not match";
                    }
                    else{
                      return null;
                    }
                  },
                  style: style(Colors.grey[700], weight: FontWeight.normal, size: h*0.017),

                  decoration: InputDecoration(

                      prefixIcon: Icon(Icons.lock_clock),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey,width: 0.7),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 1),
                      ),

                      labelText: "Password",
                      labelStyle: style(Colors.grey[800], weight: FontWeight.bold, size: h*0.021)
                  ),
                  obscureText: isVisible2,

                ),


                SizedBox(height: h*0.024,),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.yellow[900],
                      value: checkBoxValue1,
                      checkColor:Colors.white,
                      onChanged: (value){
                        setState((){
                          this.checkBoxValue1=value;
                        });
                      },
                    ),
                    Flexible(child: InkWell(
                        onTap: (){
                          setState((){
                            checkBoxValue1==true?
                            this.checkBoxValue1=false:
                            this.checkBoxValue1=true;
                          });
                        },
                        child:styled(text: "By signing up you agree to our terms and conditions", color:Colors.grey[500], weight: FontWeight.bold, size:  h*0.015)),
                        //Text("By signing up you agree to our terms and conditions",style: style(Colors.grey[500] , weight: FontWeight.bold, size: h*0.015),))
                    )
                  ],
                ),

                SizedBox(height: h*0.13,),


                ElevatedButton(onPressed: ()async{

                  if(formKeySignup.currentState!.validate()){
                    formKeySignup.currentState!.save();

                    try{
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: eSignup.text.toString(), password:pSignup.text.toString()).then((value){
                        setState((){
                          visiblefirstborder=true;
                          visiblesecondborder=false;
                        });
                      }).then((value)async{
                        try{
                            user=FirebaseAuth.instance.currentUser;
                            await FirebaseFirestore.instance.collection('InstitutesSignups').doc(user!.uid).set({
                              "email":eSignup.text.toString(),
                              "password":pSignup.text.toString(),
                              "uid":user!.uid,
                              // "ecatMaths":  "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatMaths.json?alt=media&token=5a6adbe6-47a5-4fe1-8f91-4d2deb6c53f0",
                              // "ecatPhysics":  "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatPhysics.json?alt=media&token=5ae81693-47b7-45b4-8f1e-146142318fae",
                              // "ecatChemistry":  "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatChemistry.json?alt=media&token=d9b44a71-47b7-4625-bd2f-a684d27e06ed",
                              // "ecatEnglish":  "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatEnglish.json?alt=media&token=fd8a4d85-ce83-4a17-9740-4191926c0260",
                              //
                              //
                              // "MdCatMaths":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatMaths.json?alt=media&token=a5be722d-88c3-4f70-b98e-b9b68a4f20df',
                              // "MdCatPhysics":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatPhysics.json?alt=media&token=bd5f3cb5-9724-431d-9531-27e6c0830064 ',
                              // "MdCatChemistry":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatChemistry.json?alt=media&token=e98e861f-c1da-4444-8cae-d3841b2ff8a0',
                              // "MdCatEnglish":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatEnglish.json?alt=media&token=83a2930c-3c14-4416-920e-3766b0c2045e',
                              //
                              // "firstYearMaths":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/firstYearMaths.json?alt=media&token=6bfe5f50-8950-4055-b212-f4ef7a9e7c6e',
                              // "firstYearPhysics":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/firstYearPhysics.json?alt=media&token=6403ce33-674b-49fc-85ca-e0b81656e41e',
                              // "firstYearChemistry":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatChemistry.json?alt=media&token=e98e861f-c1da-4444-8cae-d3841b2ff8a0',
                              // "firstYearEnglish":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/firstYearEnglish.json?alt=media&token=ffd079f6-c61b-4826-902f-19a51a0357b5',
                              //
                              // "secondYearMaths":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearMaths.json?alt=media&token=104aba96-b713-4ce3-8d8e-7361f7f7772f',
                              // "secondYearPhysics":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearPhysics.json?alt=media&token=7222673b-7877-43d9-8d29-a5a176a54134',
                              // "secondYearChemistry":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearChemistry.json?alt=media&token=767caf47-238a-4753-bfe6-7595e747dac9',
                              // "secondYearEnglish":  'https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearEnglish.json?alt=media&token=f5c0f675-46c6-4d9c-94cf-811b0cf961f9'

                            }).then((value)async{
                              await FirebaseFirestore.instance.collection("Url").doc('123').set({
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
                      });

                    }
                    catch(e){
                          Fluttertoast.showToast(msg: e.toString());
                    }
                  }

                },
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size(w,h*0.07),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: mainColor
                    ),
                    // child:Text(
                    //     "SIGN UP",style: style(Colors.white , weight: FontWeight.bold, size: h*0.026 )
                    // ),
                  child: styled(text: 'SIGN UP', color: Colors.white, weight: FontWeight.bold, size: h*0.026),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
