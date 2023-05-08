import 'package:epreparing/ConfirmYouInsitute.dart';
import 'package:epreparing/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'addAttendance.dart';
import 'addStudentScreen.dart';
class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return ListView(

      children: [
        SizedBox(height: h*0.025,),
        Container(
          height: h*0.15,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.4))
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.psychology, size: h*0.05, color: Colors.teal[800],),
                  SizedBox(width:w*0.01 ,),
                  styled(color: Colors.black, text: 'Easy-Learning', weight:FontWeight.bold, size: h*0.025)
                ],

              ),
            ],
          ),
        ),

        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.4))
          ),
          child: ListTile(
            onTap: (){
              Navigator.pop(context);
            },
            leading: Icon(Icons.dashboard_customize, color: Colors.grey[600], size: h*0.03),
            title: styled(color: Colors.grey[800], text: 'Dashboard', weight: FontWeight.normal, size: h*0.02),

            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400], size: h*0.025),),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.4))
          ),
          child: ListTile(
            onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckInCheckOut()));
            },
            leading: Icon(Icons.checklist_sharp, color: Colors.grey[600], size: h*0.03),
            title: styled(color: Colors.grey[800], text: 'Attendance', weight: FontWeight.normal, size: h*0.02),

            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400], size: h*0.025),),
        ),


        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.4))
          ),
          child: ListTile(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>ConfirmYouInstitute()));
            },
            leading: Icon(Icons.person_pin_outlined, color: Colors.grey[600], size: h*0.03),
            title: styled(color: Colors.grey[800], text: 'Students', weight: FontWeight.normal, size: h*0.02),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400], size: h*0.025),),
        ),

        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.4))
          ),
          child: ListTile( leading: Icon(Icons.policy, color: Colors.grey[600], size: h*0.03),
            title: styled(color: Colors.grey[800], text: 'Terms & Condition', weight: FontWeight.normal, size: h*0.02),

            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400], size: h*0.025),),
        ),

        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.4))
          ),
          child: ListTile( leading: Icon(Icons.privacy_tip_sharp, color: Colors.grey[600], size: h*0.03),
            title: styled(color: Colors.grey[800], text: 'About Us', weight: FontWeight.normal, size: h*0.02),

            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400], size: h*0.025),),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.4))
          ),
          child: ListTile( leading: Icon(Icons.logout_sharp, color: Colors.grey[600], size: h*0.03),
            title: styled(color: Colors.grey[800], text: 'Log out', weight: FontWeight.normal, size: h*0.02),
            onTap: ()async{
            await FirebaseAuth.instance.signOut().then((value){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
            });
            },
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400], size: h*0.025),),
        ),

      ],
    );
  }}