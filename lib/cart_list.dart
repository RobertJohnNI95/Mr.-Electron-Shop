import 'package:flutter/material.dart';

class CartListItem {
  final int id;
  final Image image;
  final String label;
  final double price;
  CartListItem({
    required this.id,
    required this.image,
    required this.label,
    required this.price,
  });
}

List<CartListItem> cartList = [];
