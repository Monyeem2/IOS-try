import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat_page extends StatefulWidget {

  late String receivername,sendername;

  Chat_page(this.receivername,this.sendername);

  @override
  _Chat_pageState createState() => _Chat_pageState();
}

class _Chat_pageState extends State<Chat_page> {


  var sms;
  final _controller = TextEditingController();
  late String result,result2,chatRoomId;
  // late String sendername = '';
  //
  // final User? _userCredential = FirebaseAuth.instance.currentUser;
  //
  //
  //
  // Future<void> username()async {
  //   final User? _userCredential = FirebaseAuth.instance.currentUser;
  //   if(_controller.text.isNotEmpty){
  //     FirebaseFirestore.instance.collection("auth").doc(_userCredential!.uid).get().then((doc){
  //       sendername = doc.data()!['name'];
  //     });
  //   }
  //
  //
  // }

  Future<void> sendData()async {
    // username();
    final User? _userCredential = FirebaseAuth.instance.currentUser;
    // print(widget.sendername+(widget.receivername));
    //
    // print(widget.sendername.compareTo(widget.receivername));


    if(_controller.text.isNotEmpty){
      FirebaseFirestore.instance.collection("msg").doc(chatRoomId).collection('conversation').add({
        'msg': sms,
        // 'user': widget.get_user.user!.email.toString(),
        'name': widget.sendername,
        'createdAt' : FieldValue.serverTimestamp(),
      });
      _controller.clear();


    }

    print('recever'+widget.receivername);
    print('sender'+widget.sendername);
  }


  getMyInfo() async {
    chatRoomId = getChatRoomId(widget.sendername, widget.receivername);
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyInfo().whenComplete(() => chatRoomId);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFFeb6e0e),
          automaticallyImplyLeading: false,
          title: Text(widget.receivername,
            style:  const TextStyle(
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
            const SizedBox(width: 20,),
          ],
        ),
        body: Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("images/spashscreen.PNG"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Stack(

            children: [
              Container(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        //Text(widget.receivername),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('msg').doc(chatRoomId).collection("conversation").orderBy('createdAt', descending: false).snapshots(),
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
                                        Text(
                                          result= e['name'] ?? 'N/A txt',
                                          //Name,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black
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

                                        // Text(
                                        //   result2 = result.substring(0,result.indexOf('.')),
                                        // ),

                                        Text(e['msg'] ?? 'N/A txt',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('\n'),

                                      ],
                                    );
                                  }).toList(),

                                );
                              }
                            }
                        ),
                        SizedBox(height: 80,),
                      ],
                    ),
                  ),
                ),
              ),


              Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.only(left: 15, right: 6, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                          color: Color(0xFFEEF1FF),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              controller: _controller,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              cursorColor: const Color(0XFFeb6e0e),
                              decoration: const InputDecoration(
                                  hintText: "Type your message",
                                  border: InputBorder.none
                              ),
                              onChanged: (input){
                                sms = input;
                              },

                              validator: (input){
                                if(input!.isEmpty){
                                  return "Type your message";
                                }
                              },

                            ),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(
                              flex: 1,
                              child: FlatButton(
                                  padding: const EdgeInsets.all(12),
                                  color: const Color(0XFFeb6e0e),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17)
                                  ),
                                  onPressed: (){
                                    // if(_controller.text.isNotEmpty){
                                    // FirebaseFirestore.instance.collection("msg").add({
                                    //   'msg': sms,
                                    //   'user': widget.get_user.user!.email.toString(),
                                    //   'createdAt' : FieldValue.serverTimestamp(),
                                    // });
                                    // _controller.clear();
                                    // }
                                    sendData();
                                    print('chatroom'+chatRoomId);
                                  },
                                  child: const Icon(Icons.send, color: Colors.white,))
                          ),

                        ],
                      )
                  )
              ),
            ],
          ),
        ),

      )
    );
  }
}
