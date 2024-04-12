import 'dart:convert';

import 'package:appsmobile/core/networks/detail/detail_product_network.dart';
import 'package:appsmobile/core/view_model/detail/detail_product_page.dart';
import 'package:appsmobile/core/view_model/view_model.dart';
import 'package:appsmobile/ui/shared/spacing.dart';
import 'package:appsmobile/ui/shared/unfocus_helper.dart';
import 'package:appsmobile/ui/views/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProduct {
  AddProduct({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
    this.controller,
    this.isSelected = false,
  });

  final int id;
  final String title;
  final String image;
  final double price;
  int quantity;
  bool isSelected;
  TextEditingController? controller;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  // Konversi format JSON menjadi objek AddProduct
  factory AddProduct.fromJson(Map<String, dynamic> json) {
    return AddProduct(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}

class DetailProductParam {
  DetailProductParam({
    required this.id,
    required this.mode,
  });

  final int? id;
  final String? mode;
}

// Save cart data to SharedPreferences
Future<void> saveCartData(List<AddProduct> cartProducts) async {
  final prefs = await SharedPreferences.getInstance();
  final cartData = cartProducts.map((product) => product.toJson()).toList();
  await prefs.setString('cartData', jsonEncode(cartData));
}

// Load cart data from SharedPreferences
Future<List<AddProduct>> loadCartData() async {
  final prefs = await SharedPreferences.getInstance();
  final cartData = prefs.getString('cartData');
  if (cartData != null) {
    final decodedData = jsonDecode(cartData) as List;
    return decodedData.map((json) => AddProduct.fromJson(json)).toList();
  }
  return [];
}

class DetailProduct extends ConsumerStatefulWidget {
  const DetailProduct({
    super.key,
    required this.param,
  });

  final DetailProductParam param;

  @override
  ConsumerState<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends ConsumerState<DetailProduct> {
  List<AddProduct> addCartProduct = [];
  @override
  Widget build(BuildContext context) {
    return ViewModel<DetailPageModel>(
      model: DetailPageModel(
        getDetailProduct: ref.read(getDataProductContent),
        id: widget.param.id!,
      ),
      onModelReady: (DetailPageModel model) => model.initModel(),
      builder: (_, DetailPageModel model, __) {
        return UnfocusHelper(
          child: Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cart(
                          addCartProduct: addCartProduct,
                          onQuantityChanged: (product, newQuantity) {
                            setState(() {
                              product.quantity = newQuantity;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ],
            ),
            body: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/image/NO8hx.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  model.initModel();
                },
                child: model.busy
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      model.daftarproduct!.image,
                                      height: 250,
                                    ),
                                  ],
                                ),
                              ),
                              Spacings.verSpace(15),
                              Text(
                                '\$ ${model.daftarproduct!.price}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacings.verSpace(15),
                              Text(
                                model.daftarproduct!.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacings.verSpace(15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.orange[600],
                                      ),
                                      Spacings.horSpace(5),
                                      Text(
                                        '${model.daftarproduct!.rating.rate} / ${model.daftarproduct!.rating.count}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    model.daftarproduct!.category,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Spacings.verSpace(15),
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(model.daftarproduct!.description),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              // key: const Key("Add To Chat"),
              shape: const CircleBorder(),
              onPressed: () {
                addToCart(
                  AddProduct(
                      id: model.daftarproduct!.id,
                      title: model.daftarproduct!.title,
                      image: model.daftarproduct!.image,
                      price: model.daftarproduct!.price),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(
                      addCartProduct: addCartProduct,
                      onQuantityChanged: (product, newQuantity) {
                        // Update the quantity of the product in the cart
                        setState(() {
                          product.quantity = newQuantity;
                        });
                      },
                    ),
                  ),
                );
              },
              backgroundColor: Colors.cyan[200],
              child: const Icon(
                Icons.add_shopping_cart,
                color: Colors.black,
                size: 31.5,
              ),
            ),
          ),
        );
      },
    );
  }

  void addToCart(AddProduct addProduct) {
    // Check if the product already exists in the cart
    bool productExists = false;
    for (int i = 0; i < addCartProduct.length; i++) {
      if (addCartProduct[i].id == addProduct.id) {
        // If the product exists, increment its quantity and mark it as found
        setState(() {
          addCartProduct[i].quantity++; // Increment quantity
        });
        productExists = true;
        break;
      }
    }

    // If the product doesn't exist, add it to the cart
    if (!productExists) {
      setState(() {
        addCartProduct.add(addProduct);
      });
    }
  }
}
