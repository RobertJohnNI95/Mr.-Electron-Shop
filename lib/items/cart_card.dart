import 'package:flutter/material.dart';
import 'package:flutter_course_ecommerce_project/cart_list.dart';
import 'package:flutter_course_ecommerce_project/items/wide_button.dart';

class CartCard extends StatefulWidget {
  final CartListItem item;
  final VoidCallback onRemove;
  const CartCard({super.key, required this.item, required this.onRemove});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
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
                    child: widget.item.image,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.item.label,
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
                      Expanded(
                        child: WideButton(
                          color: Colors.red,
                          icon: Icon(Icons.delete, color: Colors.white),
                          label: Text(
                            "Remove",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          function: widget.onRemove,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "\$ ${widget.item.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
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
