import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plus_interview/models/api_model.dart';
import 'package:plus_interview/providers/provider.dart';
import 'package:plus_interview/utils/app_color.dart';
import 'package:plus_interview/views/home/widgets/drawer_widget.dart';
import 'package:plus_interview/views/product_screen.dart';

class HomeScreen extends ConsumerWidget {
  final String token;
  const HomeScreen({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(dataProvider).when(
          data: (data) {
            Map<String, List<ApiModel>?> categoryMap = {};
            for (ApiModel product in data!) {
              if (!categoryMap.containsKey(product.category)) {
                categoryMap[product.category!] = [];
              }
              categoryMap[product.category]!.add(product);
            }
            return DefaultTabController(
                length: categoryMap.keys.length,
                child: Scaffold(
                  drawer: DrawerWidget(token: token),
                  appBar: AppBar(
                    backgroundColor: const Color(0xFF517176),
                    centerTitle: true,
                    title: const Text("Products"),
                    foregroundColor: const Color(0xFFD6E8EB),
                    bottom: TabBar(
                      indicatorColor: const Color(0xFFD6E8EB),
                      labelColor: tertiaryColor,
                      unselectedLabelColor: Colors.white54,
                      isScrollable: true,
                      tabs: [
                        for (final tab in categoryMap.entries)
                          Tab(
                            child: Text(tab.key[0].toUpperCase() +
                                tab.key.substring(1)),
                          )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      for (final tab in categoryMap.entries)
                        ProductScreen(
                          products: tab.value!,
                        ),
                    ],
                  ),
                ));
          },
          error: (error, stackTrace) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text("Something went wrong"),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.invalidate(dataProvider);
                    },
                    child: const Text("Retry"),
                  )
                ],
              ),
            );
          },
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
  }
}
