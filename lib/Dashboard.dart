import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epreparing/orientation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class Decorations {
  String title, subtitle;
  String url;
  Color color1, color2, color3,color4,color5;

  Decorations(
      {required this.title,
      required this.subtitle,
      required this.url,
      required this.color1,
      required this.color2,
      required this.color3,
        required this.color4,

        required this.color5
      });
}

List<Decorations>   courses = [
  Decorations(
      title: "ECAT",
      subtitle: "6000 Mcqs",
      url:
          "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/engineering-svgrepo-com.svg?alt=media&token=ae634c7a-bb52-4109-8cea-3061246d72ef",
      color1: Colors.orange[800]!,
      color2: Colors.orange[700]!,
      color3: Colors.orange[400]!,
      color4: Colors.orange[700]!,
      color5: Colors.orange[800]!
  ),
  Decorations(
      title: "MDCAT",
      subtitle: "4000 Mcqs",
      url:
          "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/medical-stethoscope-variant-svgrepo-com.svg?alt=media&token=056105e2-6559-43cd-80e7-d603ce2ae4ea",
      color1: Colors.brown[800]!,
      color2: Colors.brown[500]!,
      color3: Colors.brown[700]!,
      color4: Colors.brown[500]!,
      color5: Colors.brown[800]!

  ),
  Decorations(
      title: "1st Year",
      subtitle: "2000 Mcqs",
      url:
          "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/physics-svgrepo-com(2).svg?alt=media&token=7c9faa88-e2a2-412c-975b-f23b3a8c1baf",
      color1: Colors.pink[900]!,
      color2: Colors.pink[600]!,
      color4: Colors.pink[400]!,
      color3: Colors.pink[500]!,
      color5: Colors.pink[700]!
  ),
  Decorations(
      title: "2nd Year",
      subtitle: "2500 Mcqs",
      url:
          "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/physics-svgrepo-com(3).svg?alt=media&token=2293549a-daf5-4ae9-be0d-cdded10d5b97",
      // color1: Colors.teal,
      // color2: Colors.blue,
      // color3: Colors.lightBlueAccent,
      // color4: Colors.blue[500]!,
      // color5: Colors.blue[900]!
      color1: Colors.teal[900]!,
      color2: Colors.teal[500]!,
      color3: Colors.teal[400]!,
      color4: Colors.teal[700]!,
      color5: Colors.teal[900]!
      // color1: Colors.deepPurple[900]!,
      // color2: Colors.deepPurple[700]!,
      // color3: Colors.deepPurple[500]!,
      // color4: Colors.deepPurple[600]!,
      // color5: Colors.deepPurple[700]!
  ),
];




class _DashboardState extends State<Dashboard> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //
  // List<String> secondYearCourses = [];
  // List<String> ecatCourses = [];
  // List<String> firstYearCourses = [];
  // List<String> mdCatCourses = [];

  String ecatMaths="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatMaths.json?alt=media&token=5a6adbe6-47a5-4fe1-8f91-4d2deb6c53f0";
  String ecatPhysics="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatPhysics.json?alt=media&token=5ae81693-47b7-45b4-8f1e-146142318fae";
  String ecatChemistry= "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatChemistry.json?alt=media&token=d9b44a71-47b7-4625-bd2f-a684d27e06ed";
  String ecatEnglish="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ecatEnglish.json?alt=media&token=fd8a4d85-ce83-4a17-9740-4191926c0260";
  String mdCatMaths="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatMaths.json?alt=media&token=a5be722d-88c3-4f70-b98e-b9b68a4f20df";
  String mdCatPhysics="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatPhysics.json?alt=media&token=bd5f3cb5-9724-431d-9531-27e6c0830064";
  String mdCatChemistry="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatChemistry.json?alt=media&token=e98e861f-c1da-4444-8cae-d3841b2ff8a0";
  String mdCatEnglish="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatEnglish.json?alt=media&token=83a2930c-3c14-4416-920e-3766b0c2045e";
  String firstYearMaths="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/firstYearMaths.json?alt=media&token=6bfe5f50-8950-4055-b212-f4ef7a9e7c6e";
  String  firstYearPhysics ="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/firstYearPhysics.json?alt=media&token=6403ce33-674b-49fc-85ca-e0b81656e41e'";
  String firstYearChemistry="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/mdCatChemistry.json?alt=media&token=e98e861f-c1da-4444-8cae-d3841b2ff8a0'";
  String firstYearEnglish="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/firstYearEnglish.json?alt=media&token=ffd079f6-c61b-4826-902f-19a51a0357b5";
  String secondYearMaths ="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearMaths.json?alt=media&token=104aba96-b713-4ce3-8d8e-7361f7f7772f'";
  String secondYearPhysics="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearPhysics.json?alt=media&token=7222673b-7877-43d9-8d29-a5a176a54134'";
  String secondYearChemistry="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearChemistry.json?alt=media&token=767caf47-238a-4753-bfe6-7595e747dac9'";
  String secondYearEnglish="https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/secondYearEnglish.json?alt=media&token=f5c0f675-46c6-4d9c-94cf-811b0cf961f9";


  bool isLoaded = false;
//
  Future<void> getUser() async {

    try{


  var collection = FirebaseFirestore.instance.collection('Url');
  var docSnapshot = await collection.doc('123').get();
  if (docSnapshot.exists) {
    // Fluttertoast.showToast(msg: 'Yes snapshot found');
    Map<String, dynamic>? data = docSnapshot.data();

    setState((){
       ecatMaths = data?['ecatMaths'];
      ecatPhysics = data?['ecatPhysics'];
      ecatChemistry = data?['ecatChemistry'];
      ecatEnglish = data?['ecatEnglish'];
      //
      // setState((){
      //   ecatCourses.add(ecatMaths);
      //   ecatCourses.add(ecatPhysics);
      //   ecatCourses.add(ecatChemistry);
      //   ecatCourses.add(ecatEnglish);
      // });

      mdCatMaths = data?['MdCatMaths'];
      mdCatPhysics = data?['MdCatPhysics'];
      mdCatChemistry = data?['MdCatChemistry'];
      mdCatEnglish = data?['MdCatEnglish'];

      // setState((){
      //
      //   mdCatCourses.add(mdCatMaths);
      //   mdCatCourses.add(mdCatPhysics);
      //   mdCatCourses.add(mdCatChemistry);
      //   mdCatCourses.add(mdCatEnglish);
      //
      // });
      firstYearMaths = data?['firstYearMaths'];
      firstYearPhysics = data?['firstYearPhysics'];
      firstYearChemistry = data?['firstYearChemistry'];
      firstYearEnglish = data?['firstYearEnglish'];
      //
      // setState((){
      //   firstYearCourses.add(firstYearMaths);
      //   firstYearCourses.add(firstYearPhysics);
      //   firstYearCourses.add(firstYearChemistry);
      //   firstYearCourses.add(firstYearEnglish);
      //
      // });

      secondYearMaths = data?['secondYearMaths'];
      secondYearPhysics = data?['secondYearPhysics'];
      secondYearChemistry = data?['secondYearChemistry'];
      secondYearEnglish = data?['secondYearEnglish'];

      // Fluttertoast.showToast(msg: "second"+ecatMaths);
      // Fluttertoast.showToast(msg: "second"+secondYearEnglish);

    });

    // setState((){
    //
    //   secondYearCourses.add(secondYearMaths);
    //   secondYearCourses.add(secondYearPhysics);
    //   secondYearCourses.add(secondYearChemistry);
    //   secondYearCourses.add(secondYearEnglish);
    // });
    // if(secondYearEnglish==''){
    //     isLoaded = true;
    // }
  };

}
catch(e){
  Fluttertoast.showToast(msg: e.toString());
  print(e.toString());
}

  }

  @override
  void initState() {
    // print(secondYearEnglish);

    // TODO: implement initState
    super.initState();
    getUser();
    isLoaded=true;

  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(child: drawer()),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body:isLoaded==false?Center(child: Flexible(child: styled(text: 'No Courses available offline', color: Colors.grey[700], weight: FontWeight.bold, size: h*0.02)),):
            Padding(
              padding:  EdgeInsets.only( right: w * 0.05, left: w * 0.05, top: h * 0.08),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                              onTap: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: Colors.grey[800],
                                size: h * 0.024,
                              ))),
                      Align(
                        alignment: Alignment.center,
                        child: styled(
                            text: 'Dashboard',
                            color: Colors.grey[800],
                            weight: FontWeight.bold,
                            size: h * 0.024),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: h * 0.05,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: ListView.builder(
                      shrinkWrap: false,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:index==0?EdgeInsets.only(top: h * 0.0012):
                              index==3?EdgeInsets.only(top: h * 0.015,bottom: h*0.055):
                              EdgeInsets.only(top: h * 0.015),
                          // index==0?EdgeInsets.only(top: h * 0.006):
                              // index ==1
                              // ? EdgeInsets.only(top: h * 0.02):index==2?
                              //   EdgeInsets.only(top: h * 0.02)
                              // : EdgeInsets.only(top: h * 0.02, bottom: h * 0.075),
                          child: InkWell(
                            onTap: () {
                             show(context: context, h: h, w: w, eMaths: ecatMaths, ePhy: ecatPhysics, eChem: ecatChemistry, eEng: ecatEnglish, mdMaths: mdCatMaths, mdPhy: mdCatPhysics,
                                 mdChem: mdCatChemistry, mdEng: mdCatEnglish, fMaths: firstYearMaths, fPhy:firstYearPhysics, fChem:firstYearChemistry, fEng: firstYearEnglish, sMaths: secondYearMaths,
                                 sPhy: secondYearPhysics, sChem: secondYearChemistry, sEng: secondYearEnglish, i: index);
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>orientation(index: index, url: ecatEnglish)));
                            //
                            },
                            child: Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5.5,
                              child: Container(
                                width: w,
                                height: h * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      courses[index].color1,
                                      courses[index].color2,
                                      courses[index].color3,
                                      courses[index].color4,
                                      courses[index].color5,
                                    ],
                                    begin: Alignment.topRight,end: Alignment.bottomLeft)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.network(
                                      courses[index].url,
                                      width: w * 0.1,
                                      color: Colors.white70,
                                    ),
                                    SizedBox(
                                      width: w * 0.03,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        styled(
                                            text: courses[index].title,
                                            color: Colors.white,
                                            weight: FontWeight.bold,
                                            size: w * 0.07),
                                        styled(
                                            text: courses[index].subtitle,
                                            color: Colors.white70,
                                            weight: FontWeight.bold,
                                            size: w * 0.035)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: courses.length,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

Future show(
    {required BuildContext context,
    required double h,
    required double w,
    required String eMaths,
      required String ePhy,
      required String eChem,
      required String eEng,
      required String mdMaths,
      required String mdPhy,
      required String mdChem,
      required String mdEng,
      required String fMaths,
      required String fPhy,
      required String fChem,
      required String fEng,
      required String sMaths,
      required String sPhy,
      required String sChem,
      required String sEng,





      required int i}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 30,
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.symmetric(horizontal: w * 0.05),
          title: Container(
            width: w,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Material(
                      elevation: 3.2,
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          try{

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => orientation(
                                        index: i, url:
                                         i==0?eMaths:i==1?mdMaths:i==2?fMaths:i==3?sMaths:""
                                    )));
                          }
                          catch(e){
                            Fluttertoast.showToast(msg: e.toString(),toastLength: Toast.LENGTH_LONG);
                          }
                        },
                        child: Container(
                            width: h * 0.07,
                            height: h * 0.07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red[600]!.withOpacity(0.7)),
                            child: Center(
                                child: SvgPicture.network(
                                    color: Colors.white,
                                    width: w * 0.08,
                                      i==1?    "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/bacteria.svg?alt=media&token=5d39180d-af49-4464-835b-a28203c1b5bc"
:    "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/engineering-svgrepo-com.svg?alt=media&token=ae634c7a-bb52-4109-8cea-3061246d72ef"

                                ))),
                      ),
                    ),
                    SizedBox(
                      height: w * 0.015,
                    ),
                    styled(
                        text: i==1?'Biology':'Maths',
                        color: Colors.grey[700],
                        weight: FontWeight.bold,
                        size: h * 0.015)
                  ],
                ),
                Column(
                  children: [
                    Material(
                      elevation: 3.2,
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          try{

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => orientation(
                                        index: i, url:
                                     i==0?ePhy:i==1?mdPhy:i==2?fPhy:i==3?sPhy:""
                                    )));
                          }
                          catch(e){
                            Fluttertoast.showToast(msg: e.toString(),toastLength: Toast.LENGTH_LONG);
                          }
                        },
                        child: Container(
                            width: h * 0.07,
                            height: h * 0.07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue[900]!.withOpacity(0.7)),
                            child: Center(
                                child: SvgPicture.network(
                                    color: Colors.white,
                                    width: h * 0.0399,
                                    "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/physics-svgrepo-com(3).svg?alt=media&token=2293549a-daf5-4ae9-be0d-cdded10d5b97"))),
                      ),
                    ),
                    SizedBox(
                      height: w * 0.015,
                    ),
                    styled(
                        text: 'Physics',
                        color: Colors.grey[700],
                        weight: FontWeight.bold,
                        size: h * 0.015)
                  ],
                ),
                Column(
                  children: [
                    Material(
                      elevation: 3.2,
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                         try{
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => orientation(
                                       index: i, url:
                                    i==0?eChem:i==1?mdChem:i==2?fChem:i==3?sChem:""
                                   )));
                         }
                         catch(e){
                           Fluttertoast.showToast(msg: e.toString(),toastLength: Toast.LENGTH_LONG);
                         }
                        },
                        child: Container(
                            width: h * 0.07,
                            height: h * 0.07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.yellow[700]!.withOpacity(1)),
                            child: Center(
                                child: SvgPicture.network(
                                    color: Colors.white,
                                    width: w * 0.08,
                                    "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/chemistry-svgrepo-com(1).svg?alt=media&token=4993835d-b250-45a6-a4d2-9b10ebeecc73"))),
                      ),
                    ),
                    SizedBox(
                      height: w * 0.015,
                    ),
                    styled(
                        text: 'Chemistry',
                        color: Colors.grey[700],
                        weight: FontWeight.bold,
                        size: h * 0.015)
                  ],
                ),
                Column(
                  children: [
                    Material(
                      elevation: 3.2,
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                        try{
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => orientation(
                                      index: i, url:
                                  i==0?eEng:i==1?mdEng:i==2?fEng:i==3?sEng:""
                                  )));
                        }
                        catch(e){
                          Fluttertoast.showToast(msg: e.toString(),toastLength: Toast.LENGTH_LONG);
                        }
                        },
                        child: Container(
                            width: h * 0.07,
                            height: h * 0.07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color:
                                    Colors.deepPurple[900]!.withOpacity(0.9)),
                            child: Center(
                                child: SvgPicture.network(
                                    color: Colors.white,
                                    width: w * 0.08,
                                    "https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/abc-svgrepo-com.svg?alt=media&token=bb860a36-0330-447c-af13-61fa64baee92"))),
                      ),
                    ),
                    SizedBox(
                      height: w * 0.015,
                    ),
                    styled(
                        text: 'English',
                        color: Colors.grey[700],
                        weight: FontWeight.bold,
                        size: h * 0.015)
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

Text styled(
    {required String text,
    required Color? color,
    required FontWeight weight,
    required double size}) {
  return Text(
    text,
    style: GoogleFonts.robotoCondensed(
        textStyle: TextStyle(color: color, fontWeight: weight, fontSize: size)),
  );
}
