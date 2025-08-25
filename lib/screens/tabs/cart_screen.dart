import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_ecommerce_project/cart_list.dart';
import 'package:flutter_course_ecommerce_project/items/cart_card.dart';
import 'package:flutter_course_ecommerce_project/items/wide_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get totalPrice =>
      cartList.fold<double>(0, (total, item) => total + item.price);
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Preload the audio file so it doesn’t freeze during checkout
    audioPlayer.setSource(AssetSource('cash-register-kaching.mp3'));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg1.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(91, 187, 186, 186),
        bottomNavigationBar: Container(
          height: 60,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: WideButton(
                  icon: Icon(Icons.shopping_cart_checkout, color: Colors.white),
                  label: Text(
                    "Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  function: () async {
                    if (cartList.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Cart is empty!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Purchase successful!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      setState(() {
                        cartList.clear();
                      });
                      try {
                        await audioPlayer.stop(); // ensure no overlap
                        await audioPlayer.play(
                          AssetSource('cash-register-kaching.mp3'),
                        );
                      } catch (e) {
                        // ignore: avoid_print
                        print("Audio error: $e");
                      }
                      // ignore: avoid_print
                      print("Checkout done!");
                    }
                  },
                ),
              ),
              SizedBox(width: 10),
              Text(
                "\$ ${double.parse(totalPrice.toStringAsFixed(2))}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: cartList.isEmpty
                  ? Center(
                      child: Text(
                        "Cart is empty",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: cartList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox.shrink(),
                      itemBuilder: (context, index) {
                        final item = cartList[index];
                        return CartCard(
                          key: ValueKey(item.id),
                          item: item,
                          onRemove: () {
                            // This rebuilds the parent ListView and removes the correct tile
                            setState(() {
                              cartList.removeAt(index);
                              // alternatively:
                              // cartList.removeWhere((e) => e.id == item.id);
                            });
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
