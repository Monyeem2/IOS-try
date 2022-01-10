import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msgr_app/chat_page.dart';
import 'package:msgr_app/conversation_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Contact_page extends StatefulWidget {


  late UserCredential get_user;
  Contact_page({required this.get_user});

  @override
  _Contact_pageState createState() => _Contact_pageState();
}

class _Contact_pageState extends State<Contact_page> {


  late String result,result2;

  // final FirebaseAuth auth = FirebaseAuth.instance;
  //
  //
  // void uid_catch() {
  //   final User? user = auth.currentUser;
  //   final uid = user!.uid;
  //   // here you write the codes to input the data into firestore
  // }

  // final User user = FirebaseAuth.instance.currentUser!;
  // final userid = user.uid;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   uid_catch();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFFeb6e0e),
          automaticallyImplyLeading: false,
          title: const Text("uniConnect",
            style:  TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          actions: [
            GestureDetector(
              child: Icon(Icons.logout),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 20,),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: FlatButton(
                  minWidth: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  onPressed: ()async{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationPage()));
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationPage()));

                  },
                  child: const Text("OSL Group",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0XFFeb6e0e),
                    ),
                  ),

                ),
              ),

              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('auth').orderBy('name', descending: false).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData){
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0XFFeb6e0e),
                        ),
                      );
                    }else{
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        snapshot.data!.docs.map((e) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FlatButton(
                                minWidth: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Text(
                                  result= e['name'] ?? 'N/A txt',
                                  //Name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0XFFeb6e0e),
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Chat_page(result)));
                                  //print(uid);
                                },
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

                              // Text(
                              //   widget.get_user.toString(),
                              //   //Name,
                              //   style: const TextStyle(
                              //     fontSize: 20,
                              //     color: Color(0XFFeb6e0e),
                              //   ),
                              // ),

                              // Text(
                              //   result2 = result.substring(0,result.indexOf('.')),
                              // ),

                            ],
                          );
                        }).toList(),

                      );
                    }
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
