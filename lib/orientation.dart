import 'dart:typed_data';

import 'package:animated_svg/animated_svg.dart';
import 'package:animated_svg/animated_svg_controller.dart';
import 'package:epreparing/Colors.dart';
import 'package:epreparing/addStudentScreen.dart';
import 'package:epreparing/pageviewformat.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart'as http;

import 'package:epreparing/scrollableFormat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'McqModel.dart';

class orientation extends StatefulWidget {
  final int index;
  final String url;
  const orientation({Key? key, required this.index, required this.url}) : super(key: key);

  @override
  State<orientation> createState() => _orientationState();
}

class _orientationState extends State<orientation> {
  bool pageFormat=true;
  Mcq? mcq;
  bool loaded=false;

  TextEditingController _totalQuestionsController=TextEditingController();

   Future<void> fetchPosts()async{try{
     var response;
     var client = http.Client();
     var uri = Uri.parse(widget.url);
     for(int i=0;i<100;++i){
       response = await client.get(uri);
       if(response.statusCode==200){
         break;
       }
     }

     if (response.statusCode == 200) {
       var json = response.body;
       mcq =await mcqFromJson(json);
       setState(() {loaded=true;}); }
   }
   catch(e){
     if(e.toString()=='XMLHttpRequest error.'){
       // Fluttertoast.showToast(msg:"Weak or slow internet");
       scaffoldKey.currentState!.showSnackBar(SnackBar(content: styled(text: 'Weak or no internet', color:Colors.white, weight: FontWeight.normal, size:12),shape:
         RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(20),
         ),duration: Duration(seconds: 4),));
     }
     else{
       Fluttertoast.showToast(msg: e.toString());
       print(e.toString());
     }

   }}
   Color darkBlue=Color(0xFF13366E);

   @override
   void initState() {
     super.initState();
     fetchPosts().then((value){
       loaded=true;
     });
   }


  Color scrollFormatBgColor=Colors.white;
  Color pageFormatBgColor=Colors.white;

  final scaffoldKey = GlobalKey<ScaffoldState>();



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
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(

        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: loaded==false?Center(child: CircularProgressIndicator(),):Align(alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w*0.075),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                        SizedBox(height: h*0.1,),
                        styled(text: 'Choose a Format', color: darkBlue, weight: FontWeight.bold, size: h*0.025),
                        SizedBox(height: h*0.1,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                            color: scrollFormatBgColor,
                            elevation: 8,
                                borderRadius: BorderRadius.circular(100)
                                ,child: InkWell(
                                borderRadius: BorderRadius.circular(100),
                                      splashColor: Colors.blue,
                                      onTap: (){
                                            setState((){
                                              if(scrollFormatBgColor==Colors.white){
                                                if(pageFormatBgColor==Colors.lightBlueAccent){
                                                  pageFormatBgColor=Colors.white;
                                                }
                                                scrollFormatBgColor=Colors.lightBlueAccent;
                                              }

                                            });
                                            pageFormat=false;
                                            },
                                  child: Padding(
                                    padding:  EdgeInsets.all(w*0.07),
                                    child: SvgPicture.network('https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/ScrollableFormat.svg?alt=media&token=13444ef5-e637-4551-81e5-5abfa2a84958',width: w*0.25,),
                                  ),
                                )),

                            Material(
                                color: pageFormatBgColor  ,
                                elevation:8,
                                borderRadius: BorderRadius.circular(100)
                                ,child: InkWell(
                              onTap: (){
                                setState((){
                                  if(pageFormatBgColor==Colors.white){
                                    if(scrollFormatBgColor==Colors.lightBlueAccent){
                                      scrollFormatBgColor=Colors.white;
                                    }
                                    pageFormatBgColor=Colors.lightBlueAccent;
                                  }
                                });
                                  pageFormat=true;

                              },
                              borderRadius: BorderRadius.circular(100),
                              splashColor: Colors.blue[800],
                                  child: Padding(
                              padding:  EdgeInsets.all(w*0.07),
                                    child: SvgPicture.network('https://firebasestorage.googleapis.com/v0/b/spiritacademy-edfa5.appspot.com/o/pageViewSvg.svg?alt=media&token=594144d9-8ace-4609-9737-d08998858185',width: w*0.25,
                                    cacheColorFilter: true,
                                      ),
                                  ),
                                )),
                          ],
                        ),
                          SizedBox(height: h*0.07,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: w*0.2),
                            child: TextFormField(
                              validator: (value){

                              },
                              controller: _totalQuestionsController,
                              style:TextStyle(color: darkBlue.withOpacity(0.7),fontSize: h*0.02),
                              maxLength: 3,
                              cursorColor: darkBlue,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Questions',
                                labelStyle: TextStyle(color: darkBlue,fontSize: h*0.02),
                                prefixIcon: Icon(Icons.numbers,size: h*0.021,color: darkBlue,),
                                enabled: true,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue[700]!,width: 1)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: darkBlue,width: 2.1)
                                )
                              ),
                            ),
                          ),
                SizedBox(height: h*0.2  ,),

                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(onPressed: (){

                    int totalQuestionsSelected=mcq!.questions.length;
                    _totalQuestionsController.text.isEmpty==false?(totalQuestionsSelected=int.parse(_totalQuestionsController.text.toString())):null;

                    pageFormat?Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>PageViewFormat(totalQuestions: totalQuestionsSelected, index: widget.index, url: widget.url,mcq: mcq))):
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ScrollableFormat(totalQuestions: totalQuestionsSelected, index: widget.index, url: widget.url,mcq: mcq,)));


                  }, child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      styled(text: 'Continue', color: darkBlue, weight: FontWeight.bold, size: h*0.023),
                      Icon(Icons.arrow_forward_ios_outlined,color: darkBlue,size: h*0.02,),

                    ],
                  ),
                  style:OutlinedButton.styleFrom(
                    minimumSize: Size(w*0.425,h*0.05,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    side:BorderSide(color:  darkBlue,width: 2)
                  )
                    ,),
                )

              ]
            ),
          )
        )

    );
  }

}

