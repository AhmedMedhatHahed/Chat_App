import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:task/consts/constants.dart';
import 'package:task/screens/chat_page.dart';
import '../helper/show_snack_bar.dart';
import '../services/my validators.dart';

class SignUp extends StatefulWidget {
  static const routename = 'SignUpScreen';

  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var usernamecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var usernamefocusnode = FocusNode();
  var emailfocusnode = FocusNode();
  var passwordfocusnode = FocusNode();
  var confirmpasswordfocusnode = FocusNode();
  var formkey = GlobalKey<FormState>();
  bool ispassword = true;

  @override
  void initState() {
    usernamecontroller = TextEditingController();
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    confirmpasswordController = TextEditingController();
    // Focus Nodes
    usernamefocusnode = FocusNode();
    emailfocusnode = FocusNode();
    passwordfocusnode = FocusNode();
    confirmpasswordfocusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    usernamecontroller.dispose();
    confirmpasswordController.dispose();
    // Focus Nodes
    usernamefocusnode.dispose();
    emailfocusnode.dispose();
    passwordfocusnode.dispose();
    confirmpasswordfocusnode.dispose();
    super.dispose();
  }

  Future<void> _registerFct() async {
    final isValid = formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  String? email;
  String? password;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          key: formkey,
          child: GestureDetector(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 12.0, left: 12.0, top: 50.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            letterSpacing: 1),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Sign up now to receive special offers and updates from our app',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: usernamecontroller,
                      focusNode: usernamefocusnode,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.supervised_user_circle_outlined),
                          labelText: 'Username',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0))),
                      validator: (value) {
                        return MyValidators.displayNamevalidator(value);
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(emailfocusnode);
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      onChanged: (data) {
                        email = data;
                      },
                      controller: emailcontroller,
                      focusNode: emailfocusnode,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0))),
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passwordfocusnode);
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      onChanged: (data) {
                        password = data;
                      },
                      obscureText: true,
                      controller: passwordcontroller,
                      focusNode: passwordfocusnode,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                ispassword = !ispassword;
                              });
                            },
                            icon: Icon(
                              ispassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0))),
                      validator: (value) {
                        return MyValidators.passwordValidator(value);
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context)
                            .requestFocus(confirmpasswordfocusnode);
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: confirmpasswordController,
                      focusNode: confirmpasswordfocusnode,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                ispassword = !ispassword;
                              });
                            },
                            icon: Icon(
                              ispassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0))),
                      validator: (value) {
                        return MyValidators.repeatPasswordValidator(
                            value: value, password: passwordcontroller.text);
                      },
                      onFieldSubmitted: (value) {},
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onPressed: () async {
                          isloading = true;
                          setState(() {});
                          try {
                            await registerUser();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  ChatPage(),
                                ));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(context, 'Weak Password');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(context, 'Email already Exists');
                            }
                          } catch (e) {
                            showSnackBar(context, 'There was an error!');
                          }

                          isloading = false;
                          setState(() {});

                          _registerFct();
                        },
                        icon: const Icon(Icons.verified_user),
                        label: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
