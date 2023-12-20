import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plus_interview/providers/authentication/login_provider.dart';
import 'package:plus_interview/utils/app_color.dart';
import 'package:plus_interview/utils/responsive.dart';
import 'package:plus_interview/views/authentication/signup_screen.dart';
import 'package:plus_interview/views/home/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
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
                        'Welcome back!',
                        style: TextStyle(
                            fontSize: R.rw(34, context),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Log back into your account',
                        style: TextStyle(fontSize: R.rw(14, context)),
                      ),
                    ),
                    SizedBox(
                      height: R.rh(20, context),
                    ),
                    TextField(
                      controller: ref.watch(loginProvider).email,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: R.rw(14, context))),
                    ),
                    TextField(
                      controller: ref.watch(loginProvider).password,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(fontSize: R.rw(14, context))),
                    ),
                    Row(
                      children: [
                        const Text("I don't have an account!"),
                        SizedBox(
                          width: R.rw(10, context),
                        ),
                        GestureDetector(
                          onTap: () {
                            ref.read(loginProvider.notifier).resetLogin();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ));
                          },
                          child: const Text(
                            "Signup",
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
                        onPressed: ref.watch(loginProvider).isLoading
                            ? null
                            : () async {
                                if (ref
                                    .read(loginProvider.notifier)
                                    .validate()) {
                                  ref
                                      .read(loginProvider.notifier)
                                      .toggleLoading();
                                  String? token = await ref
                                      .read(loginProvider.notifier)
                                      .login()
                                      .then((value) {
                                    ref
                                        .read(loginProvider.notifier)
                                        .toggleLoading();
                                    return value;
                                  });
                                  if (context.mounted) {
                                    if (token != null) {
                                      ref
                                          .read(loginProvider.notifier)
                                          .resetLogin();
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return HomeScreen(token: token);
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
                            ref.watch(loginProvider).isLoading
                                ? "Loading..."
                                : 'Login',
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
