import 'package:flutter/material.dart';
import 'package:flutter_course_ecommerce_project/items/shop_card.dart';
import 'package:flutter_course_ecommerce_project/shop_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(91, 187, 186, 186),
      body: ListView.separated(
        itemBuilder: (context, index) => ShopCard(
          id: index + 1,
          image: shopList[index].image,
          label: shopList[index].label,
          price: shopList[index].price,
          rating: shopList[index].rating,
        ),
        separatorBuilder: (context, index) => SizedBox(),
        itemCount: shopList.length,
      ),
    );
  }
}
