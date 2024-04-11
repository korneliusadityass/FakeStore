import 'package:appsmobile/ui/views/detail/detail_view.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
    required this.addCartProduct,
  });

  final List<AddProduct> addCartProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: addCartProduct.length,
        itemBuilder: (context, index) {
          final product = addCartProduct[index];
          return ListTile(
            leading: Image.asset(product.image),
            title: Text(product.title),
            subtitle: Text('\$ ${product.price.toString()}'),
          );
        },
      ),
    );
  }
}
