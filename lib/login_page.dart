import 'package:flutter/material.dart';
import 'package:msgr_app/chat_page.dart';
import 'package:msgr_app/try.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {


  var email, password;
  var hide_password = true;


  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> logIn() async {

    final FormState? formState = _formkey.currentState;

    if(formState!.validate()){
      formState.save();
      try{
        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationPage(get_user: user)));
        print(email);
        print(password);
        print(user);


      }catch(e){
        print(e);
      }
    }


    // user != null
    //     ? Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ConversationPage(get_user: user,)))
    //     : print('Error of logIn function');
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: const Color(0XFFed7f18),
        appBar: AppBar(
          title: const Center(child: Text("Login")),
          backgroundColor: const Color(0XFFeb6e0e),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Image(image: AssetImage("images/loginscreen.PNG")),

                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0XFFc9c3a1),
                      ),

                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0XFF0d7a36)),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(fontSize: 15.0),
                              ),

                              onChanged: (input){
                                email = input;
                              },

                              validator: (input){
                                if(input!.isEmpty){
                                  return "Email Cannot be empty";
                                }
                              },

                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0XFF0d7a36)),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(fontSize: 15.0),
                              ),

                              onChanged: (input){
                                password = input;
                              },

                              validator: (input){
                                if(input!.length <6){
                                  return "Password is too low";
                                }

                              },

                            ),
                          ),

                          SizedBox(height: 20),

                        ],
                      ),
                    ),
                  ),



                  const Padding(
                    padding: EdgeInsets.only(left: 200),
                    child: Text("Forget Password?",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  FlatButton(
                    color: const Color(0XFFeb6e0e),
                      onPressed: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat_page()));
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationPage()));
                        logIn();
                      },
                      child: const Text("Login",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                      ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
