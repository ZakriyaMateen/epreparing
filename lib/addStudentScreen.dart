import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epreparing/Colors.dart';
import 'package:epreparing/addStudentLogin.dart';
import 'package:epreparing/studentDataModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


class addStudentScreen extends StatefulWidget {
  final String uid;
  const addStudentScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<addStudentScreen> createState() => _addStudentScreenState();
}


 User? user;
class _addStudentScreenState extends State<addStudentScreen> {
bool isLoaded=false;
Future  getUser()async{
  }


  String ?searchQuery;
  TextEditingController _searchController=TextEditingController();
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoaded=true;
    }
    bool isDeleteOptionAvailable=false;

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
   return  Scaffold(
     backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: backgroundColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => addStudentLogin(uid: widget.uid,)));
          },
          child: Icon(Icons.add, color: Colors.white,),
        ),
        body:Column(
          children: [
            SizedBox(height: h*0.07,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w*0.05),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: styled(color: Colors.grey[800], text: 'Students', weight: FontWeight.bold, size: h*0.025),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.arrow_back_ios, color: Colors.grey[800], size: h*0.025,),
                  )
                ],
              ),
            ),
            SizedBox(height: h*0.015,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w*0.05),
              child: TextFormField(
                controller: _searchController,
                cursorColor: Colors.grey[700],
                style: TextStyle(color: Colors.grey[700],fontSize:h*0.02  ),
                onFieldSubmitted: (value){
                  setState((){
                    searchQuery=value.toLowerCase();
                  });
                },
                onChanged: (value){

                  setState((){
                    searchQuery=value.toLowerCase();
                  });

                },

                decoration: InputDecoration(

                    suffixIcon: InkWell(onTap: (){
                      setState((){
                        searchQuery=_searchController.text.toString().toLowerCase();
                      });

                     
                    },child: Icon(Icons.search),),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red,width: 2),
                      borderRadius: BorderRadius.circular(20),
                    )
                ),
              ),
            ),

            SizedBox(height: h*0.015,),


            StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                          stream: (searchQuery==null || searchQuery!.trim()=='')?FirebaseFirestore.instance.collection('Institutes').doc(widget.uid).collection('Students').snapshots():
                          FirebaseFirestore.instance.collection('Institutes').doc(widget.uid).collection('Students').where('searchIndex',arrayContains:searchQuery! ) .snapshots(),

                            builder: (context,snapshot){
                            if(snapshot.hasError){
                              return styled(text: 'Error Occurred', color: Colors.grey[700], weight:FontWeight.bold, size: h*0.02);
                            }
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            switch(snapshot.connectionState) {
                              case ConnectionState.waiting:
                                        return Center(child: CircularProgressIndicator(),);
                              case ConnectionState.none:
                                  return Flexible(child: styled(text: "No Students Registered", color: Colors.grey, weight:FontWeight.bold, size: h*0.02));

                              case ConnectionState.done:
                                return Text("We are done");
                              default:
                                final docs=snapshot.data!.docs;
                                return Expanded(
                                  child: ListView.builder(itemBuilder: (context,index){
                                    final data=docs[index].data();
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: h*0.002),

                                      child: ListTile(

                                        onLongPress: (){
                                          // showDialog(context: context, builder: (context) {
                                          //   return new AlertDialog(
                                          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                                          //         side: BorderSide(color: Colors.grey,width:1.2)),
                                          //     alignment: Alignment.center,
                                          //     contentPadding: EdgeInsets.symmetric(vertical: h*0.01),
                                          //     scrollable: true,
                                          //
                                          //     backgroundColor: Colors.grey[100],
                                          //     title:Padding(
                                          //       padding:  EdgeInsets.symmetric(vertical: h*0.01),
                                          //
                                          //       child: Padding(
                                          //         padding:  EdgeInsets.symmetric(vertical: h*0.01),
                                          //
                                          //         child: Row(
                                          //           mainAxisAlignment: MainAxisAlignment.center,
                                          //           children: [
                                          //             styled(text: 'Delete Student', color: Colors.grey[800], weight: FontWeight.bold, size: h*0.023),
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     content: Padding(
                                          //       padding:  EdgeInsets.symmetric(horizontal: w*0.15,vertical: h*0.01),
                                          //       child: Row(
                                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //         children: [
                                          //           OutlinedButton(onPressed: (){
                                          //             Navigator.pop(context);
                                          //           }, child: styled(text: 'Cancel', color: Colors.grey, weight: FontWeight.normal, size: h*0.02)),
                                          //           SizedBox(width: w*0.05,),
                                          //
                                          //           OutlinedButton(onPressed: ()async{
                                          //             try{
                                          //               await FirebaseFirestore.instance.collection('Institutes').doc(widget.uid).collection('Students').doc(data['email']).delete().then((value) {
                                          //                 Fluttertoast.showToast(msg: "Student deleted successfully!").then((value) {
                                          //                   Navigator.pop(context);
                                          //                 });
                                          //               });
                                          //
                                          //             }
                                          //             catch(e){
                                          //               Fluttertoast.showToast(msg: e.toString());
                                          //             }
                                          //
                                          //           }, child: styled(text: 'Confirm', color: Colors.grey, weight: FontWeight.normal, size: h*0.02)),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   );
                                          // });

                                            setState((){
                                              isDeleteOptionAvailable=true;
                                            });
                                        },

                                        contentPadding: EdgeInsets.symmetric(horizontal: w*0.05),
                                        title: styled(text: data['name'], color: Colors.grey[700], weight: FontWeight.bold, size: h*0.022),
                                        subtitle:  styled(text: data['email'], color: Colors.blueGrey[400], weight: FontWeight.normal, size: h*0.02),
                                        trailing: Material(
                                          elevation: 5.3,
                                          borderRadius: BorderRadius.circular(100),

                                          child: Visibility(
                                            visible: isDeleteOptionAvailable,
                                            child: Container(
                                              width: h*0.025,
                                              height: h*0.025,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [ Colors.red[900]!,Colors.red[800]!,Colors.red[700]!,Colors.red[900]!,Colors.red[900]!]
                                                ),
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                              child:
                                              InkWell(
                                                  onTap: ()async{
                                                    try{
                                                      await FirebaseFirestore.instance.collection('Institutes').doc(widget.uid).collection('Students').doc(data['email']).delete().then((value) {
                                                        Fluttertoast.showToast(msg: "Student deleted successfully!");
                                                      });

                                                    }
                                                    catch(e){
                                                      Fluttertoast.showToast(msg: e.toString());
                                                    }

                                                  },
                                                  child:         Icon(Icons.remove,color: Colors.white,size: h*0.013,)),
                                            ),
                                          ),
                                        ),
                                        leading: Material(
                                          elevation: 2,
                                          borderRadius: BorderRadius.circular(100),

                                          child: Container(
                                              width: h*0.05,
                                              height: h*0.05,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [ Colors.blue,Colors.lightBlue,Colors.lightBlueAccent
                                                      ]
                                                  ),
                                                  borderRadius: BorderRadius.circular(100),
                                                  border: Border.all(color: Colors.blue,width: 1)
                                              ),
                                              child: Center(child: Icon(Icons.person,size: h*0.03,color: Colors.blue[800],))),
                                        ),

                                      ),
                                    );
                                  },
                                    itemCount: docs.length,),
                                );

                            }

              },

            ),


          ],
        )

    );
  }
                        }


                        Text styled({required String text,required Color ?color,required FontWeight weight,required double size}){
                                return Text(text,style: GoogleFonts.robotoCondensed(textStyle:style(color, weight:weight, size:size)),);
                        }