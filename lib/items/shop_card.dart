import 'package:flutter/material.dart';
import 'package:flutter_course_ecommerce_project/cart_list.dart';
import 'package:flutter_course_ecommerce_project/items/wide_button.dart';

class ShopCard extends StatefulWidget {
  final int id;
  final Image image;
  final String label;
  final double price;
  final int rating;
  const ShopCard({
    super.key,
    required this.id,
    required this.image,
    required this.label,
    required this.price,
    required this.rating,
  });

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 5, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 130,
                    width: 130,
                    child: widget.image,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 5, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingStars(rating: widget.rating),
                      Text(
                        "\$ ${widget.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  WideButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    label: Text(
                      "Add to cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    function: () {
                      // ignore: avoid_print
                      print("Item ${widget.id} added to cart.");
                      setState(() {
                        cartList.add(
                          CartListItem(
                            id: widget.id,
                            image: widget.image,
                            label: widget.label,
                            price: widget.price,
                          ),
                        );
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Item added to cart.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingStars extends StatefulWidget {
  final int rating;
  const RatingStars({super.key, required this.rating});

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (widget.rating >= 1)
            ? Icon(Icons.star, color: Colors.amber)
            : Icon(Icons.star_border_outlined, color: Colors.amber),
        (widget.rating >= 2)
            ? Icon(Icons.star, color: Colors.amber)
            : Icon(Icons.star_border_outlined, color: Colors.amber),
        (widget.rating >= 3)
            ? Icon(Icons.star, color: Colors.amber)
            : Icon(Icons.star_border_outlined, color: Colors.amber),
        (widget.rating >= 4)
            ? Icon(Icons.star, color: Colors.amber)
            : Icon(Icons.star_border_outlined, color: Colors.amber),
        (widget.rating >= 5)
            ? Icon(Icons.star, color: Colors.amber)
            : Icon(Icons.star_border_outlined, color: Colors.amber),
      ],
    );
  }
}
