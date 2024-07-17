import 'package:flutter/material.dart';
import 'package:tiktok2/constants.dart';
import 'package:tiktok2/view/screens/auth/sign_up_screen.dart';
import 'package:tiktok2/view/widgets/text_intput_feild.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'TikTok Clone',
                style: TextStyle(
                  fontSize: 35,
                  color: buttonColor,
                  fontWeight: FontWeight.w900
                ),
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(controller: _emailController, labelText: 'Email', icon: Icons.email)
              ),

              const SizedBox(height: 25,),

              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),

                  child: TextInputField(
                    controller: _passwordController,
                    labelText: 'Password',
                    icon: Icons.lock,
                    isObscure: true,)),

          const SizedBox(height: 30,),

          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: InkWell(
              onTap: () {

                authController.loginUser(
                    _emailController.text,
                    _passwordController.text);

              },
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account? ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, color: buttonColor),
                ),
              ),
            ],
          ),
            ]
                ),
        )
    )
    );

  }
}
