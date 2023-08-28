import 'package:auth_app_2/components/my_button.dart';
import 'package:auth_app_2/components/my_text_field.dart';
import 'package:auth_app_2/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  //onTap Function for the clickable "Register now" Text
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap}); // Why here?

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //SIGN IN Method
  void signIn() async{
    // Get the Auth Service, using "Provider" state management (like dependency injection)
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign in failed, error: " + e.toString())));
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

                  //Welcome back message
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Welcome Back",
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

                  //sign in button
                  const SizedBox(
                    height: 30,
                  ),
                  MyButton(onTap: signIn, text: "Sign In"),

                  //not a member? Register now
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a member?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.onTap, //because it's in first class
                        child: const Text(
                          "Register now.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
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
