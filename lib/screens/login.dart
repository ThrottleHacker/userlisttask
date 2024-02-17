import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:userauth/screens/home.dart';
import 'package:userauth/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {

  final formKeylogin = GlobalKey<FormState>();

  String? email;
  String? password;
  // var emailController = TextEditingController();
  // var passController = TextEditingController();

  bool obscureText = true;

  void viewPassword(){
    setState(() {
      obscureText=!obscureText;
    });
  }

  void Signin() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email ??"", password: password??"").catchError((onError){
          print("error $onError");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter valid credentials")));
    }).then((authUser){
      if(authUser.user !=null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successfully")));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
      }

      print("authUser ${authUser.user?.uid}");
    });
  }

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        child: Form(
          key: formKeylogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                 Text("Login",
                    style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                     fontSize: 8.w,)),

               SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Text("Username/Email ID",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 4.w,)),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                width: 100.w,
                // height: 20.w,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: TextFormField(
                  cursorColor: Colors.black,
                  onSaved: (value){
                    email= value!;
                  },
                  // controller: emailController,
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter username or email ID';
                    }
                    RegExp emailRegex =
                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter username or email ID *",
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 1, color: Colors.black45),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 1, color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 1,
                          color: Color.fromARGB(
                              255, 66, 125, 145)),
                    ),
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Colors.grey,

                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Text("Password",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 4.w,)),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                width: 100.w,
                // height: 6.h,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: Center(
                  child: TextFormField(
                    cursorColor:
                    Colors.black,
                    // controller: passController,
                    onSaved: (value){
                      password = value!;
                      print("passController $password");
                    },
                    autovalidateMode:
                    AutovalidateMode
                        .onUserInteraction, // Auto-validate as the user types
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Password should be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter password *",
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 1, color: Colors.black45),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 1, color: Colors.black),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 1,
                            color: Color.fromARGB(
                                255, 66, 125, 145)),
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        size: 18,
                      ),
                      prefixIconColor:
                      Colors.grey,
                      suffixIcon: IconButton(icon: Icon(
                          obscureText==true
                              ? Icons.visibility_off : Icons.visibility
                      ),
                        color: Colors.green,
                        onPressed: viewPassword,
                      )
                    ),
                    obscureText: obscureText,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                  width: 80.w,
                  height: 7.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
                       if(formKeylogin.currentState!.validate()){
                         formKeylogin.currentState?.save();
                         Signin();
                       }

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent, // Background color
                      onPrimary:
                      Colors.white, // Text color
                      elevation: 3, // Elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Border radius
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12), // Button padding
                    ),
                    child: Text(
                      "Submit ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 5.w,
                      ),
                    ),
                  )),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not registreted yet? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 4.w,)),
                  SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Registerscreen()));
                      },
                    child: Text(" Create an account",
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 4.w,)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
