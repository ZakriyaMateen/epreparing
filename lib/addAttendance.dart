import 'package:action_slider/action_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epreparing/addStudentScreen.dart';
import 'package:epreparing/seeAttendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CheckInCheckOut extends StatefulWidget {
  const CheckInCheckOut({Key? key}) : super(key: key);

  @override
  State<CheckInCheckOut> createState() => _CheckInCheckOutState();
}

class _CheckInCheckOutState extends State<CheckInCheckOut> {

    String checkIn="--/--";
    String checkOut="--/--";
    String date="--/--";

    List<String> checkInList=[];
    List<String> checkOutList=[];
    List<String> datesList=[];





    User?user;
    bool checkInmore=false;
    bool checkOutmore=false;



    getUser() async {



      user = await FirebaseAuth.instance.currentUser;
      var collection = FirebaseFirestore.instance.collection(
          'Student');
      var docSnapshot = await collection.doc(user!.uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();



        var array = data?['checkOut'];
        checkOutList = List<String>.from(array); // <-- The value you want to retrieve.


        var arrayDates = data?['dates'];
        datesList = List<String>.from(arrayDates); // <-- The value you want to retrieve.


        var arraycheckIn = data?['checkIn'];
        checkInList = List<String>.from(arraycheckIn); // <-- The value you want to retrieve.
      }
      if(checkInList.length>checkOutList.length){
        setState((){
          checkInmore=true;
        });
      }
      if(checkInList.length<checkOutList.length){
        setState((){
          checkOutmore=true;
        });
      }
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getUser();
    }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ),);
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: h*0.08,),
          Stack(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: w*0.08),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios,color: Colors.grey[700],size: h*0.025,),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                  child: styled(text: 'Attendance', color: Colors.grey[800], weight: FontWeight.bold, size: h*0.025),
              )
            ],
          ),
          SizedBox(height: h*0.025,),
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: Stream.periodic(Duration(days: 1)),
              builder: (_,index){
                return styled(text: DateFormat.yMMMEd().format(DateTime.now()), color: Colors.grey[800], weight: FontWeight.bold, size: h*0.02);
              },
            ),
          ),
          SizedBox(height: h*0.005,),

          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: Stream.periodic(Duration(seconds: 1)),
              builder: (_,index){
                return styled(text: DateFormat('hh:mm:ss a').format(DateTime.now()), color: Colors.grey[800], weight: FontWeight.normal, size: h*0.02);
              },
            ),
          ),

          SizedBox(height: h*0.1,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                elevation: 5.5,
            borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: h*0.185,
                  height: h*0.185,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        styled(text: 'Check In', color: Colors.green[900], weight: FontWeight.bold, size: h*0.022),
                        SizedBox(height: h*0.02,),
                        styled(text: checkIn, color: Colors.grey[600], weight: FontWeight.normal, size:h*0.022),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                elevation: 5.5,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: h*0.185,
                  height: h*0.185,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        styled(text: 'Check Out', color: Colors.red[900], weight: FontWeight.bold, size: h*0.022),
                        SizedBox(height: h*0.02,),
                        styled(text: checkOut, color: Colors.grey[600], weight: FontWeight.normal, size:h*0.022),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: h*0.15,),
          Padding(padding:
          EdgeInsets.symmetric(horizontal: w*0.08),
            child:     ActionSlider.standard(
              successIcon: Icon(Icons.check, color: Colors.white,),
              sliderBehavior: SliderBehavior.move,
              backgroundColor: Colors.white,
              toggleColor: Colors.green[900],
              rolling: true,
              width: w,

              icon: Icon(
                Icons.arrow_forward, color: Colors.white, size: h * 0.022,),
              actionThresholdType: ThresholdType.release,
              child: Text('Check In',
                  style: TextStyle(color: Colors.grey, fontSize: h * 0.022,)),
              action: (controller) async {

                setState(() {
                  checkIn = DateFormat('hh:mm:ss a').format(DateTime.now());
                });
                // checkInmore?controller.dispose():null;
               // if(checkOutmore){
               //
               //
               //
               //   try{
               //     checkInList.add(checkIn);
               //
               //     try {
               //       await FirebaseFirestore.instance.collection('Student').doc(user!.uid).update({'checkIn':FieldValue.arrayUnion(checkInList)}).then((value) {
               //         updateDates();
               //       });
               //     }
               //     catch (e) {
               //       Fluttertoast.showToast(msg: e.toString());
               //     }
               //
               //   }
               //   catch(e){
               //     Fluttertoast.showToast(msg: e.toString());
               //   }
               // }
               // if(checkInList.length==checkOutList.length){
                 try{
                   checkInList.add(checkIn);

                   try {
                     await FirebaseFirestore.instance.collection('Student').doc(user!.uid).update({'checkIn':FieldValue.arrayUnion(checkInList)}).then((value) {
                       updateDates();
                     });
                   }
                   catch (e) {
                     Fluttertoast.showToast(msg: e.toString());
                   }

                 }
                 catch(e){
                   Fluttertoast.showToast(msg: e.toString());
                 }
               // }

                controller.loading(); //starts loading animation
                await Future.delayed(const Duration(milliseconds: 300));
                controller.success(); //starts success animation
                await Future.delayed(const Duration(milliseconds: 300));
                controller.dispose();
              },
            ),
          ),

          SizedBox(height: h*0.01,),
          Padding(padding:
          EdgeInsets.symmetric(horizontal: w*0.08),
            child:     ActionSlider.standard(
              successIcon: Icon(Icons.check, color: Colors.white,),
              sliderBehavior: SliderBehavior.stretch,
              backgroundColor: Colors.white,
              toggleColor: Colors.red[900],
              rolling: true,
              width: w,
              icon: Icon(
                Icons.arrow_forward, color: Colors.white, size: h * 0.022,),
              actionThresholdType: ThresholdType.release,
              child: Text('Check Out',
                  style: TextStyle(color: Colors.grey, fontSize: h * 0.022,)),
              action: (controller) async {
                setState(() {
                  checkOut = DateFormat('hh:mm:ss a').format(DateTime.now());
                });
                    // checkOutmore?controller.dispose():null;

             // if(checkInmore){
             //   try{
             //
             //
             //     checkOutList.add(checkOut);
             //     try {
             //       await FirebaseFirestore.instance.collection('Student').doc(user!.uid).update({'checkOut':FieldValue.arrayUnion(checkOutList)});
             //     }
             //     catch (e) {
             //       Fluttertoast.showToast(msg: e.toString());
             //     }
             //
             //   }
             //   catch(e){
             //     Fluttertoast.showToast(msg: e.toString());
             //   }
             // }
             // if(checkInList.length==checkOutList.length){
               try{
                 checkOutList.add(checkOut);
                 try {
                   await FirebaseFirestore.instance.collection('Student').doc(user!.uid).update({'checkOut':FieldValue.arrayUnion(checkOutList)});
                 }
                 catch (e) {
                   Fluttertoast.showToast(msg: e.toString());
                 }

               }
               catch(e){
                 Fluttertoast.showToast(msg: e.toString());
               }
             // }

                controller.loading(); //starts loading animation
                await Future.delayed(const Duration(milliseconds: 300));
                controller.success(); //starts success animation
                await Future.delayed(const Duration(milliseconds: 300));
                controller.dispose();
              },
            ),
          ),
          SizedBox(height: h*0.025,),
          Padding(
            padding: EdgeInsets.only(right: w*0.08),
            child: Align(
              alignment:Alignment.centerRight,
              child: OutlinedButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>seeAttendance()));
              }, child:styled(text: 'See Attendance', color: Colors.green[800], weight: FontWeight.bold, size: h*0.02),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green,width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(w*0.3,h*0.045),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
    updateDates() async {


      try{
        String x = DateFormat.yMMMEd().format(DateTime.now());
        date=   x+" - " +DateFormat('hh:mm:ss a').format(DateTime.now());



        datesList.add(date);

        await FirebaseFirestore.instance.collection('Student')
            .doc(user!.uid)
            .update(
            {'dates': FieldValue.arrayUnion(datesList)});
      }
      catch(e){
        Fluttertoast.showToast(msg: e.toString());
      }

    }
}
