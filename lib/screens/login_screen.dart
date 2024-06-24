import 'package:bmi_task/screens/tracker_screen.dart';
import 'package:bmi_task/services/auth.dart';
import 'package:bmi_task/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void logIn() async {
    Auth auth = Auth();
    try {
      await auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.message.toString(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: Image(
                        image: AssetImage("lib/assets/bmi_logo.png"),
                        fit: BoxFit.fill,
                      ))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              TextFormField(
                controller: _emailController,
                onChanged: (data) {
                  email = data;
                },
                decoration: InputDecoration(
                  label: Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  hintText: 'abc@gmail.com',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                onChanged: (data) {
                  password = data;
                },
                decoration: InputDecoration(
                  label: Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  hintText: '********',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              CustomButon(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: TrackerScreen(),
                            type: PageTransitionType.fade));
                  }
                  //async{if(formKey.currentState!.validate()){
                  //BlocProvider.of<AuthBloc>(context).add(LoginEvent(email!, password!));
                  // }}
                  ,
                  text: "LOGIN"),
              SizedBox(
                height: MediaQuery.of(context).size.height * .002,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not yet a member? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "Sign Up now",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
