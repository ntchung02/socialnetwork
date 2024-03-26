import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x/common/common.dart';
import 'package:x/common/loading_page.dart';
import 'package:x/constants/constants.dart';
import 'package:x/features/auth/controller/auth_controller.dart';
import 'package:x/features/auth/view/login_view.dart';
import 'package:x/features/auth/widgets/auth_field.dart';
import 'package:x/theme/pallete.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
                          builder: (context) => SignUpView(),
                          );
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

void onSignUp(){
 ref.read(authControllerProvider.notifier).SignUp(
  email: emailController.text, 
  password: passwordController.text, 
  context: context,
  );
}

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    
    return Scaffold(
      appBar: appbar,
      body: isLoading 
            ? const Loader() 
            : Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //textfield1
                AuthField(
                  controller: emailController,
                  hintText: 'Email',
                  ),
                  const SizedBox(height: 25),
                //textfield2
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                  ),
                   const SizedBox(height: 40),
                //button
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedSmallButton(
                    onTap: onSignUp, 
                    label: 'Done', 
                  
                  ),
                ),
                const SizedBox(height: 40),
                //textspan
                RichText(text: TextSpan(
                  text: 'Already have an account?',
                  style: const TextStyle(
                        fontSize: 16
                      ),
                  children: [
                    TextSpan(
                      text: ' Login',
                      style: const TextStyle(
                        color: Pallete.blueColor,
                        fontSize: 16
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(
                          context, 
                          LoginView.route(),
                          );
                      },
                    )
                  ]
                ))
              ],
            ),
            ),
        ),
      ),
    );
  }
}