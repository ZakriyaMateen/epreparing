import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epreparing/addStudentScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class seeAttendance extends StatefulWidget {
  const seeAttendance({Key? key}) : super(key: key);

  @override
  State<seeAttendance> createState() => _seeAttendanceState();
}

class _seeAttendanceState extends State<seeAttendance> {

  List<String> checkInList=[];
  List<String> checkOutList=[];
  List<String> datesList=[];
  
  bool checkInmore=false;
  bool checkOutmore=false;
  bool checkInOutSame=true;
  int howMuchCheckInmore=0;
  int howMuchCheckOutmore=0;


  User?user;
  var dates;
  String uid="";

bool loaded=false;

 Future<void> getUser() async {
    user = await FirebaseAuth.instance.currentUser;
    uid=user!.uid;
    var collection = FirebaseFirestore.instance.collection(
        'Student');
    var docSnapshot = await collection.doc(user!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();



      var array = data?['checkOut'];
        setState((){
          checkOutList = List<String>.from(array); // <-- The value you want to retrieve.

        });

      var arrayDates = data?['dates'];

      setState((){
        datesList = List<String>.from(arrayDates); // <-- The value you want to retrieve.

      });

      var arraycheckIn = data?['checkIn'];
    setState((){
      checkInList = List<String>.from(arraycheckIn); // <-- The value you want to retrieve.

    });
    }
    if(checkInList.length>checkOutList.length){
      setState((){
        checkInmore=true;
        checkInOutSame=false;
        howMuchCheckInmore=checkInList.length-checkOutList.length;
      });
    }
    if(checkInList.length<checkOutList.length){
      setState((){
        checkOutmore=true;
        checkInOutSame=false;
        howMuchCheckOutmore=checkOutList.length-checkInList.length;
      });
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState((){
        loaded=true;
      });
    });
  }

 
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: w*0.08,top: h*0.05),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(onTap: (){
                Navigator.pop(context);
              },child: Icon(Icons.arrow_back_ios,color: Colors.grey[700],size: h*0.025,)),
            ),
          ),
          checkInList.isEmpty?Align(alignment: Alignment.center,child: Center(child: styled(text: 'Please mark your attendance', color: Colors.grey[700], weight: FontWeight.bold, size: h*0.02)),):
              loaded==false?CircularProgressIndicator():
          Expanded(
            child: ListView.builder(itemBuilder: (context,index){

              return Padding(

                padding:index==0? EdgeInsets.only(top: h*0.02,bottom: h*0.0065,left: w*0.05,right: w*0.05):
                index==checkInList.length-1? EdgeInsets.only(top: h*0.0065,bottom: h*0.06,left: w*0.05,right: w*0.05)
                    :EdgeInsets.symmetric(horizontal:w*0.05,vertical: h*0.0065 ),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: w,
                    height: h*0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //
                          Flexible(child: styled(text: datesList[index].length<7?datesList[index]:datesList[index].substring(0,17) , color: Colors.grey[700], weight: FontWeight.bold, size:h*0.018)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: w*0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //
                                Flexible(child: styled(text:checkInList[index] , color: Colors.green[700], weight: FontWeight.normal, size:h*0.018)),
                                Flexible(child: styled(text:checkOutList[index], color: Colors.red[700], weight: FontWeight.normal, size:h*0.018)),],
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
              );

            },itemCount:checkInmore?(checkInList.length-howMuchCheckInmore):checkOutmore?(checkOutList.length-howMuchCheckOutmore):checkInList.length ,),
          )
        ],
      ),
    );
  }
}
