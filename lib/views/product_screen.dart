import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plus_interview/models/api_model.dart';
import 'package:plus_interview/utils/app_color.dart';
import 'package:plus_interview/utils/responsive.dart';

class ProductScreen extends ConsumerStatefulWidget {
  final List<ApiModel> products;
  const ProductScreen({
    super.key,
    required this.products,
  });

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
          vertical: R.rh(4, context), horizontal: R.rh(8, context)),
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(255, 235, 241, 242),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: R.rw(8, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: R.rw(16, context)),
                  child: Text(
                    "${widget.products[index].title}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: R.rw(22, context)),
                  ),
                ),
                SizedBox(
                  height: R.rh(8, context),
                ),
                Row(
                  children: [
                    Image.network("${widget.products[index].image}",
                        width: R.rw(150, context), height: R.rh(150, context)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: R.rw(190, context),
                            child: Text(
                              "${widget.products[index].description}",
                              maxLines:
                                  widget.products[index].isExpand ? null : 3,
                            )),
                        GestureDetector(
                          onTap: () {
                            // setState(() {
                            widget.products[index].isExpand =
                                !widget.products[index].isExpand;
                            // });
                          },
                          child: Row(
                            children: [
                              Text(
                                "Read more",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: R.rw(10, context)),
                              ),
                              const Icon(
                                Icons.arrow_drop_down_outlined,
                                color: primaryColor,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: R.rh(8, context),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "₹${widget.products[index].price?.round()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: R.rw(18, context)),
                            ),
                            SizedBox(
                              height: R.rh(8, context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RatingBarIndicator(
                                      itemCount: 5,
                                      rating:
                                          widget.products[index].rating!.rate!,
                                      itemSize: R.rw(16, context),
                                      itemBuilder: (context, index) {
                                        return const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: R.rw(4, context),
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text:
                                                "${widget.products[index].rating?.rate}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                          TextSpan(
                                            text:
                                                "  (${widget.products[index].rating?.count} ratings)",
                                            style: const TextStyle(
                                                color: secondaryColor,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ]))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: R.rh(4, context),
      ),
      itemCount: widget.products.length,
    );
  }
}
