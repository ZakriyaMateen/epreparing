
import 'package:epreparing/Colors.dart';
import 'package:epreparing/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'McqModel.dart';
import 'SeeResultScreen.dart';
class PageViewFormat extends StatefulWidget {

  final Mcq? mcq;
  final int totalQuestions;

  final int index;
  final String url;
  const PageViewFormat({Key? key,  this.mcq, required this.totalQuestions, required this.index, required this.url}) : super(key: key);
  @override
  State<PageViewFormat> createState() => _PageViewFormatState();
}
class _PageViewFormatState extends State<PageViewFormat> {

  PageController ? _controller=PageController(initialPage: 0);
  bool isButtonsEnabled=true;
  bool isPressed=false;
  bool isPressed1=false;
  bool isPressed2=false;
  bool isPressed3=false;
  bool isPressed4=false;

  bool loaded =false;

  Mcq? mcq;
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
  List<bool> detector=[false,false,false,false];

  int score=0;
  int myI=4;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.black,
    //   systemNavigationBarColor: Colors.black,
    //   systemNavigationBarContrastEnforced: false,
    //   systemStatusBarContrastEnforced: false,
    //   systemNavigationBarDividerColor: Colors.black,
    //   statusBarBrightness: Brightness.dark,
    // ),);
    return Scaffold(
    key: scaffoldKey,

    backgroundColor:Colors.black ,
    //   ThemeData.dark().primaryColor

      body:loaded==false?Center(child: CircularProgressIndicator(color: Colors.blue[200],)):
      PageView.builder(
        physics: NeverScrollableScrollPhysics(),

          controller: _controller!,
          itemCount:mcq!.questions.length,
            onPageChanged: (page){
            setState((){
              isPressed=false;
            });
          },
      itemBuilder: (context,i){

        return Padding(
          padding: EdgeInsets.symmetric(vertical: h*0.07, horizontal: w*0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Question "+(i+1).toString()+"/"+mcq!.questions.length.toString(), style: style(Colors.grey, weight: FontWeight.bold, size: h*0.03),)
                ],
              ),
              Divider( height: h*0.02, thickness: h*0.003, color: Colors.white,),
              SizedBox(height: h*0.04,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Text(mcq!.questions[i].question, style: style(Colors.white, weight: FontWeight.bold, size: h*0.02),))
                ],
              ),
              SizedBox(height: h*0.06,),


              //1st


              Padding(
                padding:  EdgeInsets.symmetric( vertical: h*0.0035),
                child: OutlinedButton(

                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  minimumSize: Size(w,h*0.055),
                  backgroundColor: isPressed1==false?Colors.blue[900]:detector[0]==false?Colors.red[900]:Colors.green[700],
                )
                ,onPressed:   isButtonsEnabled?(){

                  setState((){
                    isButtonsEnabled=false;
                    isPressed=true;
                    isPressed1=true;
                  });
                  String x=mcq!.questions[i].answers[0];
                  String y=mcq!.questions[i].answers[mcq!.questions[i].correctIndex];
                  if(x==y){
                    score=score+4;
                    setState((){
                      detector[0]=true;
                    });
                  }
                  else{
                    if(score>0){

                      score=score-1;

                    }
                  }
                }:null, child:Text(mcq!.questions[i].answers[0],style: style(Colors.white, weight: FontWeight.normal, size:15),),),
              ),


              // 2nd

              Padding(

                padding:  EdgeInsets.symmetric( vertical: h*0.0035),child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    minimumSize: Size(w,h*0.055),
                    backgroundColor: isPressed2==false?Colors.blue[900]:detector[1]==false?Colors.red[900]:Colors.green[700],
                  )
                  ,onPressed:  isButtonsEnabled?(){
                  setState((){
                    isButtonsEnabled=false;
                    isPressed2=true;
                    isPressed=true;
                  });
                  String x=mcq!.questions[i].answers[1];
                  String y=mcq!.questions[i].answers[mcq!.questions[i].correctIndex];
                  if(x==y){
                    score=score+4;
                    setState((){

                      detector[1]=true;
                    });
                  }
                  else{
                    if(score>0){

                      score=score-1;

                    }
                  }
                }:null, child:Text(mcq!.questions[i].answers[1],style: style(Colors.white, weight: FontWeight.normal, size:15),),),
              ),

              // 3rd

              Padding(

                padding:  EdgeInsets.symmetric( vertical: h*0.0035),               child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    minimumSize: Size(w,h*0.055),
                    backgroundColor: isPressed3==false?Colors.blue[900]:detector[2]==false?Colors.red[900]:Colors.green[700],
                  )
                  ,onPressed:  isButtonsEnabled?(){
                  setState((){
                    isButtonsEnabled=false;

                    isPressed3=true;
                    isPressed=true;
                  });
                  String x=mcq!.questions[i].answers[2];
                  String y=mcq!.questions[i].answers[mcq!.questions[i].correctIndex];
                  if(x==y){
                    score=score+4;
                    setState((){
                      detector[2]=true;
                    });
                  }
                  else{
                    if(score>0){

                      score=score-1;

                    }
                  }
                }:null, child:Text(mcq!.questions[i].answers[2],style: style(Colors.white, weight: FontWeight.normal, size:15),),),
              ),

              //4th

              Padding(

                padding:  EdgeInsets.symmetric( vertical: h*0.0035),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    minimumSize: Size(w,h*0.055),
                    backgroundColor: isPressed4==false?Colors.blue[900]:detector[3]==false?Colors.red[900]:Colors.green[700],
                  )
                  ,onPressed:  isButtonsEnabled?(){
                  setState((){
                    isButtonsEnabled=false;
                    isPressed=true;
                    isPressed4=true;
                  });
                  String x=mcq!.questions[i].answers[3];
                  String y=mcq!.questions[i].answers[mcq!.questions[i].correctIndex];
                  if(x==y){
                    score=score+4;
                    setState((){
                      detector[3]=true;
                    });

                  }
                  else{
                    if(score>0){
                            print(score);
                      score=score-1;

                    }
                  }
                }:null, child:Text(mcq!.questions[i].answers[3],style: style(Colors.white, weight: FontWeight.normal, size:15),),),
              ),








              SizedBox(height: h*0.1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  OutlinedButton(

                      onPressed: isPressed==false?(){
                            myI=myI;
                        setState((){
                          isButtonsEnabled=true;
                          detector[0]=false;
                          detector[1]=false;
                          detector[2]=false;
                          detector[3]=false;
                        });

                        _controller!.nextPage(duration: Duration(milliseconds: 500), curve:Curves.linear);
                      }:null, child: Text('Skip', style: style(isPressed?Colors.blue[900]:Colors.blue[400], weight: FontWeight.normal, size: h*0.02),))
,


                  OutlinedButton(

                      onPressed: (){

                    setState((){

                      isButtonsEnabled=true;
                      detector[0]=false;
                      detector[1]=false;
                      detector[2]=false;
                      detector[3]=false;
                      isPressed1=false;
                      isPressed2=false;
                      isPressed3=false;
                      isPressed4=false;
                    });
                    myI=(i+1)*4+4;

                          mcq!.questions.length==i+1?

                               isPressed? Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SeeResultScreen(score: score, total:myI-4, index: widget.index,url: widget.url,))):null:
                                (isPressed? _controller!.nextPage(duration: Duration(milliseconds: 500), curve:Curves.linear):null);

                      }, child: Text(                          mcq!.questions.length==i+1?
                  'See Result':'Next Question', style: style(isPressed?Colors.blue[400]:Colors.blue[900], weight: FontWeight.normal, size: h*0.02),))
                ],
              ),
              SizedBox(height: h*0.04,),
              OutlinedButton(
                style: OutlinedButton.styleFrom(minimumSize: Size(w,h*0.047),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(  13)),
                side:BorderSide(color: Colors.red[900]!)),
                  //you can replace myI with ' widget.totalQuestions*4 '
                  onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SeeResultScreen(score: score, total:myI, index: widget.index,url: widget.url,)));},
                  child:Text(
                "End Test",
                style: style(Colors.red[900], weight: FontWeight.bold, size: h*0.02),
              ))

            ],
          ),
        );
      }),
    );

  }

  bool scoreReg(){

    for(int j=0;j<4;++j){
      if(detector[j]==true){
     return true;
      }
    }
    return false;
  }
}
