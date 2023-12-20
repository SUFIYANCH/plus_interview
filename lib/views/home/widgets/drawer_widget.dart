import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plus_interview/providers/home/update_provider.dart';
import 'package:plus_interview/providers/provider.dart';
import 'package:plus_interview/utils/responsive.dart';
import 'package:plus_interview/views/authentication/login_screen.dart';

class DrawerWidget extends ConsumerWidget {
  final String token;
  const DrawerWidget({super.key, required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: R.rh(160, context),
            color: const Color(0xFF517176),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Protected Message",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD6E8EB),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ref.watch(protectedRouteProvider(token)).when(
                        data: (data) => Text(
                          "$data",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFFD6E8EB),
                          ),
                        ),
                        error: (error, stackTrace) => const Text(
                          "An Errot Occured",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        loading: () => const Text(
                          "Please wait...",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFD6E8EB),
                          ),
                        ),
                      )
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () {
              ref.read(updateProvider.notifier).setToken(token);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Update Password",
                    style: TextStyle(
                      color: Color(0xFF517176),
                    ),
                  ),
                  content: TextField(
                    controller: ref.watch(updateProvider).password,
                    decoration: InputDecoration(
                      hintText: "Enter new password",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF517176).withOpacity(0.5),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF517176),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        ref.read(updateProvider.notifier).reset();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Color(0xFF517176),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (ref.read(updateProvider.notifier).validate()) {
                          ref.read(updateProvider.notifier).toggleLoading();
                          bool isUpdated = await ref
                              .read(updateProvider.notifier)
                              .updatePassword();
                          if (context.mounted) {
                            Navigator.pop(context);
                            ref.read(updateProvider.notifier).reset();
                            if (isUpdated) {
                              ref.read(updateProvider.notifier).toggleLoading();
                              showMyDialogue(
                                'Successfully updated password.',
                                context,
                              );
                            } else {
                              ref.read(updateProvider.notifier).toggleLoading();
                              showMyDialogue(
                                'Failed to update password, please try again.',
                                context,
                              );
                            }
                          }
                        }
                      },
                      child: Text(
                        ref.watch(updateProvider).isLoading
                            ? "Loading"
                            : "Update",
                        style: const TextStyle(
                          color: Color(0xFF517176),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            leading: const Icon(
              Icons.update,
              color: Color(0xFF517176),
            ),
            title: const Text(
              "Update Password",
              style: TextStyle(
                color: Color(0xFF517176),
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              bool isDeleted =
                  await ref.read(updateProvider.notifier).deleteAccount();

              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Are You Sure?"),
                      content:
                          const Text("Do you want to delete this account?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(
                              color: Color(0xFF517176),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (isDeleted) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                  (route) => false);
                            } else {
                              showMyDialogue(
                                  "Some error occured, please try again",
                                  context);
                            }
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              color: Color(0xFF517176),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text(
              "Delete Account",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showMyDialogue(String message, BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.pop(context),
        );
        return Padding(
          padding: const EdgeInsets.all(15),
          child: ListTile(
            tileColor: Colors.blueGrey,
            title: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
