import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x/common/loading_page.dart';
import 'package:x/common/rounded_small_button.dart';
import 'package:x/constants/constants.dart';
import 'package:x/features/auth/controller/auth_controller.dart';
import 'package:x/features/auth/view/signup_view.dart';
import 'package:x/features/auth/widgets/auth_field.dart';
import 'package:x/theme/theme.dart';


class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
                          builder: (context) => LoginView(),
                          );
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
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

  void onLogin(){
 ref.read(authControllerProvider.notifier).Login(
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
                    onTap: onLogin, 
                    label: 'Done', 
                  
                  ),
                ),
                const SizedBox(height: 40),
                //textspan
                RichText(text: TextSpan(
                  text: 'Don have a account?',
                  style: const TextStyle(
                        fontSize: 16
                      ),
                  children: [
                    TextSpan(
                      text: ' Sigh up',
                      style: const TextStyle(
                        color: Pallete.blueColor,
                        fontSize: 16
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                         Navigator.push(
                          context, 
                          SignUpView.route(),
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

class ReUsableAppBar extends StatelessWidget {
  const ReUsableAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}