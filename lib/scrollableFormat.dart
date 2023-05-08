import 'dart:math';

import 'package:epreparing/Colors.dart';
import 'package:epreparing/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;


import 'McqModel.dart';
import 'SeeResultScreen.dart';


class ScrollableFormat extends StatefulWidget {
  final Mcq? mcq;
  final int totalQuestions;
  final int index;
  final String url;
  const ScrollableFormat({Key? key,   this.mcq, required this.totalQuestions, required this.index, required this.url}) : super(key: key);

  @override
  State<ScrollableFormat> createState() => _ScrollableFormatState();
}

class _ScrollableFormatState extends State<ScrollableFormat> {

  List<int> groupValue = [];
  List<bool> isPressed=[];
  bool loaded = false;
  Mcq? mcq;
  int score =0;

    Future<void>  initializeMcq()async{
      mcq=await widget.mcq;
    }

  final scaffoldKey=GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeMcq().then((value){mcq!.questions.removeRange(widget.totalQuestions, mcq!.questions.length);
    mcq!.questions.shuffle();

    setState((){
      loaded=true;
    });
    });


  }

  Future<void> updateLists()async {

    setState((){
      for(int i= 0; i< mcq!.questions.length;i++) {
        groupValue.add(0);
      }
      for(int i= 0; i< mcq!.questions.length;i++) {
        isPressed.add(false);
      }
    });
  }
  Color textColor=Color(0xFF171616);
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

      updateLists();
    return Scaffold(
      backgroundColor: Colors.white,
      body: loaded==false? Center(child: CircularProgressIndicator(color: Colors.blue[800], )):
      ListView.builder(
                scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),itemBuilder: (context, index) {
          return index<mcq!.questions.length? Padding(
            padding: EdgeInsets.symmetric(vertical: h*0.006),
            child: Material(
              color: Colors.white,
              shape: Border.symmetric(horizontal: BorderSide(color: Colors.grey[700]!,width: 0.4)),
              elevation: 6.5,
              child: Padding(
              padding: EdgeInsets.only(top: h*0.04, left: w*0.05, right: w*0.05 ,bottom: h*0.04),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text((index+1).toString()+". ", style: style(Colors.red[900], weight: FontWeight.bold, size: h*0.023),),
                      Flexible(child: Text( mcq!.questions[index].question, style: style(Colors.grey[700], weight: FontWeight.bold, size: h*0.023),))
                    ],
                  ),
                  SizedBox(height: h*0.02,),
                  Row(
                    children: [
                      Radio(value: 1, groupValue: groupValue[index] , onChanged: isPressed[index]==false? (value){
                        setState((){
                          groupValue[index] =1;
                          isPressed[index]=true;
                        });
                        String x = mcq!.questions[index].answers[0];
                        String y = mcq!.questions[index].answers[mcq!.questions[index].correctIndex];
                        if(x==y){
                          score= score+4;
                        }else{
                          if(score>0){
                            score = score-1;
                          }
                        }

                      }:null,activeColor: Colors.green,fillColor: MaterialStateColor.resolveWith((states) => textColor)
                      ),
                      Flexible(child: Text(mcq!.questions[index].answers[0], style: style(textColor, weight: FontWeight.normal, size: h*0.017),))
                    ],
                  ),
                  Row(
                    children: [
                      Radio(value: 2, groupValue: groupValue[index] , onChanged:  isPressed[index]==false?(value ){

                        setState((){
                          groupValue[index] =2;
                          isPressed[index]=true;
                        });
                        String x = mcq!.questions[index].answers[1];
                        String y = mcq!.questions[index].answers[mcq!.questions[index].correctIndex];
                        if(x==y){
                          score= score+4;
                        }else{
                          if(score>0){
                            score = score-1;
                          }
                        }
                      }:null,activeColor: Colors.green,fillColor: MaterialStateColor.resolveWith((states) => textColor)
                      ),
                      Flexible(child: Text(mcq!.questions[index].answers[1], style: style(textColor, weight: FontWeight.normal, size: h*0.017),))
                    ],
                  ),
                  Row(
                    children: [
                      Radio(value: 3, groupValue: groupValue[index] , onChanged: isPressed[index]==false? (value ){
                        setState((){
                          groupValue[index] =3;
                          isPressed[index]=true;
                        });
                        String x = mcq!.questions[index].answers[2];
                        String y = mcq!.questions[index].answers[mcq!.questions[index].correctIndex];
                        if(x==y){
                          score= score+4;
                        }else{
                          if(score>0){
                            score = score-1;
                          }
                        }
                      }:null,activeColor: Colors.green,fillColor: MaterialStateColor.resolveWith((states) => textColor)
                      ),
                      Flexible(child: Text(mcq!.questions[index].answers[2], style: style(textColor, weight: FontWeight.normal, size: h*0.017),))
                    ],
                  ),
                  Row(
                    children: [
                      Radio(value: 4, groupValue: groupValue[index] , onChanged:  isPressed[index]==false?(value ){
                        setState((){
                          groupValue[index] =4;
                          isPressed[index]=true;
                        });
                        String x = mcq!.questions[index].answers[3];
                        String y = mcq!.questions[index].answers[mcq!.questions[index].correctIndex];
                        if(x==y){
                          score= score+4;
                        }else{
                          if(score>0){
                            score = score-1;
                          }
                        }
                      }:null,activeColor: Colors.green,fillColor: MaterialStateColor.resolveWith((states) => textColor)
                      ),
                      Flexible(child: Text(mcq!.questions[index].answers[3], style: style(textColor, weight: FontWeight.normal, size: h*0.017),))
                    ],
                  ),
                ],
              ),
        ),
            ),
          ):Column(
          children: [
            SizedBox(height: h*0.04,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal:  w*0.05 ),
              child: OutlinedButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SeeResultScreen(score: score,total: mcq!.questions.length*4, url: widget.url, index: widget.index,)));
                },
                child: styled(text: 'Submit', color: Colors.green[900], weight:FontWeight.bold, size: h*0.02),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.green[900]!,width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(w,h*0.05)
                ),
              )
            ),
            SizedBox(height: h*0.04,),
          ],
        );
      }, itemCount: mcq!.questions.length+1  ,
      ),
    );
  }
}
