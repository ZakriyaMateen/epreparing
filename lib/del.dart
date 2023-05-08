import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Dashboard.dart';

class del extends StatefulWidget {
  const del({Key? key}) : super(key: key);

  @override
  State<del> createState() => _delState();
}

class _delState extends State<del> {

  bool isV=false;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView.builder(itemBuilder: (context,index){
        // final data=docs[index].data();
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
              //               // await FirebaseFirestore.instance.collection('Institutes').doc(widget.uid).collection('Students').doc(data['email']).delete().then((value) {
              //               //   Fluttertoast.showToast(msg: "Student deleted successfully!").then((value) {
              //               //     Navigator.pop(context);
              //               //   });
              //               // });
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
                    isV=true;
                  });
            },

            contentPadding: EdgeInsets.symmetric(horizontal: w*0.05),
            title: Flexible(child: styled(text:'mexico', color: Colors.grey[700], weight: FontWeight.bold, size: h*0.022)),
            subtitle:  Flexible(child: styled(text: 'mexicomars43@gmail.com', color: Colors.blueGrey[400], weight: FontWeight.normal, size: h*0.02)),

            trailing: Visibility(
              visible: isV,
              child: Material(
                elevation: 5.3,
                borderRadius: BorderRadius.circular(100),

                child: Container(
                  width: h*0.025,
                  height: h*0.025,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [ Colors.red,Colors.redAccent,Colors.red,Colors.redAccent,Colors.pink]
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child:
                  InkWell(
                      onTap: ()async{
                        try{
                          // // await FirebaseFirestore.instance.collection('Institutes').doc(widget.uid).collection('Students').doc(data['email']).delete().then((value) {
                          // //   Fluttertoast.showToast(msg: "Student deleted successfully!");
                          // });

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
                  child: Icon(Icons.person,size: h*0.03,color: Colors.blue[800],)),
            ),

          ),
        );
      },
        itemCount: 12,),
    );
  }
}
