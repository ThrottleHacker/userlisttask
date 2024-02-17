import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:userauth/screens/login.dart';

import 'home.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegscreenState();
}

class _RegscreenState extends State<Registerscreen> {

  final formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var genController = TextEditingController();

  String? email;
  String? password;

  bool obscureText = true;

  void viewPassword(){
    setState(() {
      obscureText=!obscureText;
    });
  }

  void Signup() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email??"",
        password: password??"",
      );
    } on FirebaseAuthException catch (e) {
      print("ress $e");
      print("ress2 ${e.code}");
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak.")));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email.")));
        print('The account already exists for that email.');
      }else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The Email id is invalid.")));

      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
      print("err $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h,),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios,color: Colors.blue,)),
                SizedBox(height: 3.h,),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Registration Form",
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
                            child: Text("Name",
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
                          controller: nameController,
                          autovalidateMode: AutovalidateMode
                              .onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Name ",
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
                            child: Text("Email",
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
                          // controller: emailController,
                          onSaved: (value){
                            email= value!;
                          },
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
                            hintText: "Email",
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
                            child: Text("Gender",
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
                          controller: genController,
                          autovalidateMode: AutovalidateMode
                              .onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter gender';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Gender ",
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
                              password= value!;
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
                                hintText: "Enter password ",
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
                          // height: 7.h,
                          child: ElevatedButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                  formKey.currentState?.save();
                                  Signup();
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
                              "Next ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 5.w,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                          width: 80.w,
                          // height: 7.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary:Color(0xFFE0F5F8), // Background color
                              onPrimary:
                              Colors.white, // Text color
                              elevation: 0, // Elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Border radius
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12), // Button padding
                            ),
                            child: Text(
                              "Back to Login Form ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 5.w,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
