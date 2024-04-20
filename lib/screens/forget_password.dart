import 'package:flutter/material.dart';
import 'package:task/consts/constants.dart';

import '../services/my validators.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var emailcontroller = TextEditingController();
  var emailfocusnode = FocusNode();
  var formkey = GlobalKey<FormState>();
  @override
  void initState() {
    emailcontroller = TextEditingController();
    emailfocusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    emailfocusnode.dispose();
    super.dispose();
  }

  Future<void> _forgetPassFCT() async {
    final isValid = formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/forgot_password.jpg',
                      height: 300,
                      width: 300,
                    ),
                  ),
                  const Text(
                    'Forget Password',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Please enter the email address you\'d like your password reset information sent to',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
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
                      FocusScope.of(context).requestFocus();
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:kPrimaryColor,
                        padding: const EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.send),
                      label: const Text(
                        "Request link",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () async {
                        _forgetPassFCT();
                      },
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
