import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'main_page.dart'; // ✅ Navigate here instead of onboarding

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textName = TextEditingController();
  final textAddress = TextEditingController();
  final textPhone = TextEditingController();
  final textEmail = TextEditingController();
  final textPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              Lottie.asset('assets/lottie/lf30_skwgamub.json'),
              Text(
                'Please input your details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              buildInput(textName, 'Name'),
              buildInput(textAddress, 'Address'),
              buildInput(textPhone, 'Phone Number',
                  keyboard: TextInputType.phone),
              buildInput(textEmail, 'Email',
                  keyboard: TextInputType.emailAddress),
              buildPasswordInput(textPassword),
              Padding(
                padding: const EdgeInsets.fromLTRB(200.0, 30.0, 0.0, 10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: textEmail.text.trim(),
                          password: textPassword.text.trim(),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainPage()),
                        );
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message ?? 'Error occurred')),
                        );
                      }
                    } else {
                      showAlertDialog(context);
                    }
                  },
                  child: const Text('Continue >'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInput(TextEditingController controller, String label,
      {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 7.0, 50.0, 5.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          hintText: label,
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildPasswordInput(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 7.0, 50.0, 5.0),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password',
          hintText: 'Enter your password',
        ),
        validator: (String? value) {
          if (value == null || value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Uhh Ohh !",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Lottie.asset(
              'assets/lottie/error.json',
              width: 230,
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Please fill in all the details.",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('Yeah sure'),
          ),
        ],
      );
    },
  );
}
