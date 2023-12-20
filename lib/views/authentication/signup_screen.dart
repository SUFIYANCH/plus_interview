import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plus_interview/providers/authentication/signup_provider.dart';
import 'package:plus_interview/utils/app_color.dart';
import 'package:plus_interview/utils/responsive.dart';
import 'package:plus_interview/views/authentication/login_screen.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: R.rw(375, context),
                height: R.rh(406, context),
                child: Image.asset(
                  'assets/login.png',
                ),
              ),
              Container(
                height: R.rh(406, context),
                width: R.rw(375, context),
                padding: EdgeInsets.symmetric(horizontal: R.rw(18, context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        'Create an Account!',
                        style: TextStyle(
                            fontSize: R.rw(34, context),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: R.rh(20, context),
                    ),
                    TextField(
                      controller: ref.watch(signUpProvider).name,
                      decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(fontSize: R.rw(14, context))),
                    ),
                    TextField(
                      controller: ref.watch(signUpProvider).email,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: R.rw(14, context))),
                    ),
                    TextField(
                      controller: ref.watch(signUpProvider).password,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(fontSize: R.rw(14, context))),
                    ),
                    Row(
                      children: [
                        const Text("I already have an account!"),
                        SizedBox(
                          width: R.rw(10, context),
                        ),
                        GestureDetector(
                          onTap: () {
                            ref.read(signUpProvider.notifier).resetFields();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: R.rh(10, context),
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromWidth(R.rw(200, context)),
                          backgroundColor: primaryColor,
                        ),
                        onPressed: ref.watch(signUpProvider).isLoading
                            ? null
                            : () async {
                                if (ref
                                    .read(signUpProvider.notifier)
                                    .validate()) {
                                  ref
                                      .read(signUpProvider.notifier)
                                      .toggleLoading();
                                  String? token = await ref
                                      .read(signUpProvider.notifier)
                                      .signUp()
                                      .then((value) {
                                    ref
                                        .read(signUpProvider.notifier)
                                        .toggleLoading();
                                    return value;
                                  });
                                  if (context.mounted) {
                                    if (token != null) {
                                      ref
                                          .read(signUpProvider.notifier)
                                          .resetFields();

                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return const LoginScreen();
                                        },
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                              'Something went wrong, Please try again.'),
                                          backgroundColor: Colors.blueGrey,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          behavior: SnackBarBehavior.floating,
                                          showCloseIcon: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'User Name and Password can\'t be empty'),
                                      backgroundColor: Colors.blueGrey,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      behavior: SnackBarBehavior.floating,
                                      showCloseIcon: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  );
                                }
                              },
                        child: Text(
                            ref.watch(signUpProvider).isLoading
                                ? "Loading..."
                                : 'Sign Up',
                            style: TextStyle(
                              color: tertiaryColor,
                              fontSize: R.rw(20, context),
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: R.rh(60, context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
