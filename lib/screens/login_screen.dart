import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:task/consts/constants.dart';
import 'package:task/screens/chat_page.dart';
import '../helper/show_snack_bar.dart';
import '../services/my validators.dart';

class LoginScreen extends StatefulWidget {
  static const routename = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var emailfocusnode = FocusNode();
  var passwordfocusnode = FocusNode();
  var formkey = GlobalKey<FormState>();
  bool ispassword = true;

  @override
  void initState() {
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    // Focus Nodes
    emailfocusnode = FocusNode();
    passwordfocusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    // Focus Nodes
    emailfocusnode.dispose();
    passwordfocusnode.dispose();
    super.dispose();
  }

  Future<void> _loginFct() async {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Welcome Back!',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        letterSpacing: 1),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'We\'re glad you\'re here',
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: TextFormField(
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    onChanged: (data) {
                      password = data;
                    },
                    obscureText: true,
                    controller: passwordcontroller,
                    focusNode: passwordfocusnode,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
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
                      _loginFct();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ForgotPasswordScreen');
                    },
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            minimumSize: const Size(300, 35)),
                        onPressed: () async {
                          isloading = true;
                          setState(() {});
                          try {
                            await loginUser();
                            Navigator.pushNamed(context, 'ChatScreen',arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(context, 'User Not Found');
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context, 'Wrong Password');
                            }
                          } catch (e) {
                            showSnackBar(context, 'There was an error!');
                          }

                          isloading = false;
                          setState(() {});
                          _loginFct();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.fingerprint,
                            size: 40.0,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100.0),
                  child: Row(
                    children: [
                      const Text(
                        'Not registered yet?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'SignUpScreen');
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                color: kPrimaryColor,
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Register later',
                      style: TextStyle(
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline),
                    )),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      const Icon(Icons.supervised_user_circle),
                      const Text(
                        'Having any technical problems?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Contact us',
                            style: TextStyle(
                                color: kPrimaryColor,
                                decoration: TextDecoration.underline),
                          ))
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

  Future<void> loginUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
