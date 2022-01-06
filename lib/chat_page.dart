import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class Chat_page extends StatefulWidget {
  const Chat_page({Key? key}) : super(key: key);

  @override
  _Chat_pageState createState() => _Chat_pageState();
}

class _Chat_pageState extends State<Chat_page> {

  late String msg;

  void filepicker()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;  // if user don't pick any thing then do nothing just return.
    PlatformFile file = result.files.first;

    print('File Name: ${file.name}');
    print('File Size: ${file.size}');
    print('File Extension: ${file.extension}');
    print('File Path: ${file.path}');
  }


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Firebase.initializeApp().whenComplete(() {
  //     print("initial completed");
  //     setState(() {});
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0XFFeb6e0e),
          automaticallyImplyLeading: false,
          title: const Text("What's App",
            style:  TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      reverse: true,
                      child: Container(
                          padding: const EdgeInsets.only(left: 15, right: 6, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                              color: const Color(0xFFEEF1FF),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("msg").snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if(!snapshot.hasData){
                                return Text('No Message');
                              }else{

                                return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:
                                    snapshot.data!.docs.map((e) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(e['user'] ?? 'N/A txt',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey
                                            ),
                                          ),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //       color: Color(0xFFEEF1FF),
                                          //       borderRadius: BorderRadius.circular(10)
                                          //   ),
                                          //   padding: EdgeInsets.all(10),
                                          //   child: Text(e['sms'] ?? 'N/A txt',
                                          //   style: TextStyle(
                                          //     fontSize: 16,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          //   ),
                                          // ),
                                          Text(e['sms'] ?? 'N/A txt',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('\n')
                                        ],
                                      );
                                    }).toList()
                                );
                              }
                            },
                          ),
                      ),
                    ),


                    // Container(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 5,
                    //         child: TextField(
                    //           style: const TextStyle(
                    //             fontSize: 16,
                    //           ),
                    //           cursorColor: const Color(0xFF7777FF),
                    //           decoration: const InputDecoration(
                    //               hintText: "Type your message",
                    //               border: InputBorder.none
                    //           ),
                    //           onChanged: (input){
                    //             msg = input;
                    //           },
                    //
                    //         ),
                    //       ),
                    //
                    //       const SizedBox(width: 20,),
                    //       Expanded(
                    //           flex: 1,
                    //           child: FlatButton(
                    //               padding: const EdgeInsets.all(12),
                    //               color: const Color(0XFFeb6e0e),
                    //               shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(17),
                    //               ),
                    //               onPressed: (){
                    //                 filepicker();
                    //               },
                    //               child: const Icon(Icons.attach_file_outlined, color: Colors.white,))
                    //       ),
                    //
                    //       const SizedBox(width: 20,),
                    //       Expanded(
                    //           flex: 1,
                    //           child: FlatButton(
                    //               padding: const EdgeInsets.all(12),
                    //               color: const Color(0XFFeb6e0e),
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(17)
                    //               ),
                    //               onPressed: (){
                    //
                    //               },
                    //               child: const Icon(Icons.send, color: Colors.white,))
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),

                  ],
                ),
            )



          ],
        ),


      ),
    );
  }
}
