import 'package:epreparing/Colors.dart';
import 'package:epreparing/Dashboard.dart';
import 'package:epreparing/orientation.dart';
import 'package:epreparing/pageviewformat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SeeResultScreen extends StatefulWidget {
  final int score,total;
  final int index;
  final String url;
  const SeeResultScreen({Key? key, required this.score, required this.total, required this.index, required this.url}) : super(key: key);

  @override
  State<SeeResultScreen> createState() => _SeeResultScreenState();
}

class _SeeResultScreenState extends State<SeeResultScreen> {
  //
  // Column(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: [
  // Align(
  // alignment: Alignment.center,
  // child: Container(
  // width: w*0.6,
  // height: h*0.3,
  // decoration: BoxDecoration(
  // color: Colors.green [900],
  // borderRadius: BorderRadius.circular(20),
  // ),
  // child: Center(
  // child: Column(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: [
  // Text("- Your Score -",style: style(backgroundColor, weight: FontWeight.bold, size: h*0.03),),
  // SizedBox(height: h*0.01,),
  // Text(widget.score.toString()+" / "+(widget.total).toString(),style: style(Colors.black, weight: FontWeight.bold, size: h*0.03),),
  // ],
  // ),
  // ),
  // ),
  // ),
  //
  // Padding(
  // padding:  EdgeInsets.only(left: w*0.077,right: w*0.077,top: h*0.08),
  // child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
  // children: [
  // OutlinedButton.icon(onPressed: (){
  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
  //
  // }
  // , icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.red[900],),
  // label: Text("Go Back",style: style(Colors.red[900], weight: FontWeight.bold, size: h*0.018),)),
  // OutlinedButton(onPressed: (){
  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>orientation(index: widget.index, url: widget.url)));
  // }, child: Text("Conduct Again",
  // style:style(Colors.green[800], weight: FontWeight.bold, size: h*0.018) ,)),
  //
  // ],
  // ),
  // )
  // ],
  // ),


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
      body:Center(
        child: Material(

          elevation: 8,

          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(15),
          child: Container(

            width: w*0.8,
            height: h*0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  styled(text: 'Your Score', color: Colors.grey[800], weight: FontWeight.bold, size: h*0.03),
                  SizedBox(height: h*0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      styled(text: widget.score.toString()+"/", color: Colors.grey[600], weight: FontWeight.normal, size: h*0.027),
                      styled(text: widget.total.toString(), color: Colors.grey[600], weight: FontWeight.normal, size: h*0.027),],
                  ),
                  SizedBox(height: h*0.1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      TextButton.icon(
                        icon:Icon(Icons.arrow_back_ios_new,color: Colors.red[900],size: h*0.016,),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(w*0.2,h*0.05),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // side: BorderSide(color: Colors.red[900]!)
                        ),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                        },
                     label: styled(text: "Go Back", color: Colors.red[900], weight: FontWeight.bold, size: h*0.016)
                      ),
                      TextButton.icon(
                        icon:   Icon(Icons.refresh,color: Colors.green[900],size: h*0.016,),
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(w*0.2,h*0.05),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // side: BorderSide(color: Colors.green[900]!)
                        ),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>orientation(index: widget.index, url:widget.url)));
                        },
                          label:styled(text: "Conduct Again", color: Colors.green[900], weight: FontWeight.bold, size: h*0.016)
                      )

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )

    );
  }
}
