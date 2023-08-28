import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  //onTap Function for the clickable "Register now" Text
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap}); // Why here?

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //SIGN UP Method
  void signUp() async{
    if(passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match!")));
      return;
    }
    // Get the Auth Service, using "Provider" state management (like dependency injection)
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      authService.signUpWithEmailAndPassword(emailController.text, passwordController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User creation failed!")));
    }
  }//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  //Logo

                  Image.asset(
                    'assets/images/cia_logo.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                    cacheWidth:
                        100 * MediaQuery.of(context).devicePixelRatio.round(),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //Message
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //email textfield
                  MyTextField(
                      controller: emailController,
                      hintText: "Email Address",
                      obscureText: false),

                  //password textfield
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true),

                  //confirm password textfield
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: true),

                  //sign in button
                  const SizedBox(
                    height: 30,
                  ),
                  MyButton(onTap: signUp, text: "Sign Up"),

                  //not a member? Register now
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already a member?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login now.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
