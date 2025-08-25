import 'package:flutter/material.dart';

class ShopListItem {
  int id;
  Image image;
  String label;
  double price;
  int rating;
  ShopListItem({
    this.id = 0,
    required this.image,
    required this.label,
    required this.price,
    required this.rating,
  });
}

List<ShopListItem> shopList = [
  ShopListItem(
    image: Image.network(
      'https://m.media-amazon.com/images/I/61d46oYQgdL._AC_SL1500_.jpg',
    ),
    label: "Samsung Galaxy Tab A9+ 11” 64GB Android Tablet",
    price: 159.00,
    rating: 4,
  ),
  ShopListItem(
    image: Image.network(
      'https://m.media-amazon.com/images/I/81wwLOgkLgL._AC_SL1500_.jpg',
    ),
    label: "SanDisk 128GB Extreme PRO SDXC UHS-I Memory Card",
    price: 21.99,
    rating: 5,
  ),
  ShopListItem(
    image: Image.network(
      'https://m.media-amazon.com/images/I/612vPy6f+cL._AC_SL1500_.jpg',
    ),
    label: "Logitech M185 Wireless Mouse, 2.4GHz with USB Mini Receiver",
    price: 11.98,
    rating: 4,
  ),
  ShopListItem(
    image: Image.network(
      'https://m.media-amazon.com/images/I/615KnbjRmTL._SL1500_.jpg',
    ),
    label: "Xbox Wireless Gaming Controller",
    price: 54.00,
    rating: 4,
  ),
  ShopListItem(
    image: Image.network(
      'https://m.media-amazon.com/images/I/61is2ZwnHEL._AC_SL1500_.jpg',
    ),
    label: "SteelSeries Apex 3 RGB Gaming Keyboard",
    price: 39.99,
    rating: 3,
  ),
  ShopListItem(
    image: Image.network(
      'https://m.media-amazon.com/images/I/71jdr9u9YhL._AC_SL1500_.jpg',
    ),
    label: "Sceptre New 27-inch Gaming Monitor",
    price: 97.97,
    rating: 4,
  ),
  ShopListItem(
    image: Image.network(
      'https://m.media-amazon.com/images/I/31-oBv59mhL._AC_.jpg',
    ),
    label: 'Apple iPhone 16 Pro, US Version, 128GB',
    price: 670.95,
    rating: 5,
  ),
  ShopListItem(
    image: Image.network(
      'https://m.media-amazon.com/images/I/71aTEZOda0L._AC_SL1500_.jpg',
    ),
    label:
        'HP Pavilion 15.6" HD Touchscreen Anti-Glare Laptop, 16GB RAM, 1TB SSD Storage, Intel Core Processor up to 4.1GHz',
    price: 670.95,
    rating: 5,
  ),
  ShopListItem(
    image: Image.network(
      'https://m.media-amazon.com/images/I/71NbXlZpPKL._AC_SL1500_.jpg',
    ),
    label: 'Xiaomi Smart Band 9 Global Version (2024)',
    price: 58.97,
    rating: 3,
  ),
  ShopListItem(
    image: Image.network(
      'https://m.media-amazon.com/images/I/61T85CGI4ZL._AC_SL1500_.jpg',
    ),
    label: 'SanDisk 512GB Ultra USB 3.0 Flash Drive',
    price: 33.99,
    rating: 4,
  ),
];
