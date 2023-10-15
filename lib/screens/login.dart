import 'package:chat/api/auth_provider.dart';
import 'package:flutter/material.dart';

import '../api/socket_provider.dart';
import 'chat_person.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();

  int? otpid;

  bool issendingOTP = false;
  bool isverifyingotp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: const Text(
              "Enter phone number",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              controller: _phonecontroller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Color(0xFFDFDFDF)),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFDFDFDF),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFDFDFDF),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 240,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
              ),
              onPressed: () {
                setState(() {
                  issendingOTP = true;
                });
                AuthProvider.instance
                    .sendOTP(int.parse(_phonecontroller.text))
                    .then((value) {
                  setState(() {
                    otpid = value;
                    issendingOTP = false;
                  });
                });
              },
              child: issendingOTP
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFFFFFFFF)),
                    )
                  : const Text(
                      "Send OTP",
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 150,
            ),
            child: const Text(
              "Enter OTP",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              controller: _otpcontroller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Color(0xFFDFDFDF)),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFDFDFDF),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFDFDFDF),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 320,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
              ),
              onPressed: () {
                setState(() {
                  isverifyingotp = true;
                });
                AuthProvider.instance
                    .verifyOTP(
                  int.parse(_otpcontroller.text),
                  otpid!,
                )
                    .then((value) {
                  if (value == true) {
                    setState(() {
                      isverifyingotp = false;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const ChatPerson()),
                    );
                  }
                });
              },
              child: isverifyingotp
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFFFFFF),
                      ),
                    )
                  : const Text(
                      "Login",
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
