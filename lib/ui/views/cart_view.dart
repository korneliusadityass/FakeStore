import 'dart:convert';

import 'package:appsmobile/ui/shared/spacing.dart';
import 'package:appsmobile/ui/views/checkout_view.dart';
import 'package:appsmobile/ui/views/detail/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({
    super.key,
    required this.addCartProduct,
    required this.onQuantityChanged,
  });

  final List<AddProduct> addCartProduct;
  final Function(AddProduct, int) onQuantityChanged;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final TextEditingController jumlahController = TextEditingController();
  int jumlah = 1;
  int _isi = 0;
  bool isSelected = false;
  bool _selectAll = false;
  bool _isAnyItemSelected =
      false; // State untuk melacak apakah setidaknya satu item dipilih

  @override
  void initState() {
    super.initState();
    for (var product in widget.addCartProduct) {
      product.controller =
          TextEditingController(text: product.quantity.toString());
      product.controller!.addListener(() {
        int newQuantity = int.tryParse(product.controller!.text) ?? 0;
        if (newQuantity > 99) {
          newQuantity = 99;
          product.controller!.text = '99';
        }
        widget.onQuantityChanged(product, newQuantity);
      });
    }
    loadCartData().then((cartData) {
      print('Loaded cart data: $cartData');
      setState(() {
        // Iterate through cart data and add products to cart only if they are not already present
        for (var product in cartData) {
          if (!widget.addCartProduct
              .any((existingProduct) => existingProduct.id == product.id)) {
            product.controller =
                TextEditingController(text: product.quantity.toString());
            product.controller!.addListener(() {
              int newQuantity = int.tryParse(product.controller!.text) ?? 0;
              if (newQuantity > 99) {
                newQuantity = 99;
                product.controller!.text = '99';
              }
              widget.onQuantityChanged(product, newQuantity);
            });
            widget.addCartProduct.add(product);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 24,
                left: 15,
                bottom: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: _selectAll,
                    onChanged: (value) {
                      setState(() {
                        _selectAll = value!;
                        _setAllSelected(value);
                        _isAnyItemSelected =
                            value; // Update state ketika checkbox diubah
                      });
                    },
                  ),
                  IconButton(
                    onPressed: _isAnyItemSelected
                        ? _removeAllItems
                        : null, // Hanya aktif jika setidaknya satu item dipilih
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: 0,
                ),
                itemCount: widget.addCartProduct.length,
                itemBuilder: (context, index) {
                  final product = widget.addCartProduct[index];
                  return ListTile(
                    leading: Checkbox(
                      value: product.isSelected,
                      onChanged: (value) {
                        setState(() {
                          product.isSelected = value!;
                          _updateIsAnyItemSelected(); // Memperbarui status ketika checkbox diubah
                        });
                      },
                    ),
                    subtitle: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Image.network(
                            product.image,
                          ),
                        ),
                        Spacings.horSpace(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    product.title.length > 25
                                        ? '${product.title.substring(0, 25)}...'
                                        : product.title,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$ ${product.price}',
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      removeItem(product);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          30,
                                        ),
                                      ),
                                      border: Border.fromBorderSide(
                                        BorderSide(color: Colors.black),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(0),
                                            // Ubah ke warna yang sesuai
                                            shape: const RoundedRectangleBorder(
                                              side: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  30,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              int newQuantity = int.tryParse(
                                                      product
                                                          .controller!.text) ??
                                                  jumlah;
                                              newQuantity--; // Mengurangi jumlah
                                              if (newQuantity < 1) {
                                                newQuantity = 1;
                                              }
                                              product.controller!.text =
                                                  newQuantity.toString();
                                              widget.onQuantityChanged(
                                                  product, newQuantity);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                          ),
                                        ),
                                        Spacings.horSpace(8),
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: TextFormField(
                                            controller: product.controller,
                                            textAlign: TextAlign.center,
                                            onChanged: (value) {
                                              int newQuantity =
                                                  int.tryParse(value) ?? 0;
                                              if (newQuantity > 99) {
                                                newQuantity = 99;
                                                jumlahController.text = '99';
                                              }
                                              setState(() {
                                                _isi = newQuantity;
                                                widget.onQuantityChanged(
                                                    product, newQuantity);
                                              });
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]'))
                                            ],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.5,
                                              ),
                                              hintStyle: const TextStyle(
                                                color: Colors
                                                    .black, // Ubah ke warna yang sesuai
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacings.horSpace(8),
                                        IconButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(0),
                                            shape: const RoundedRectangleBorder(
                                              side: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  30,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: jumlah < 99
                                              ? () {
                                                  setState(() {
                                                    int newQuantity =
                                                        int.tryParse(product
                                                                .controller!
                                                                .text) ??
                                                            jumlah;
                                                    newQuantity++; // Menambah jumlah
                                                    if (newQuantity > 99) {
                                                      newQuantity = 99;
                                                    }
                                                    product.controller!.text =
                                                        newQuantity.toString();
                                                    widget.onQuantityChanged(
                                                        product, newQuantity);
                                                  });
                                                }
                                              : null,
                                          icon: const Icon(
                                            Icons.add,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isAnyItemSelected
                    ? () {
                        List<AddProduct> selectedProducts = widget
                            .addCartProduct
                            .where((product) => product.isSelected)
                            .toList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Checkout(selectedProducts: selectedProducts),
                          ),
                        );
                      }
                    : null,
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setAllSelected(bool value) {
    for (var product in widget.addCartProduct) {
      product.isSelected = value;
    }
    _updateIsAnyItemSelected();
  }

  void _updateIsAnyItemSelected() {
    setState(() {
      _isAnyItemSelected =
          widget.addCartProduct.any((product) => product.isSelected);
    });
  }

  void _removeAllItems() {
    setState(() {
      widget.addCartProduct.clear();
      saveCartData(
          widget.addCartProduct); // Save cart data after removing all items
    });
  }

  void removeItem(AddProduct product) {
    setState(() {
      widget.addCartProduct.remove(product);
      saveCartData(widget.addCartProduct); // Save cart data after removing item
    });
  }

  void _checkout() {
    // Implement your checkout logic here
  }

  // Save cart data to SharedPreferences
  void saveCartData(List<AddProduct> cartProducts) async {
    final prefsInstance = await SharedPreferences.getInstance();
    final cartData = cartProducts.map((product) => product.toJson()).toList();
    await prefsInstance.setString('cartData', jsonEncode(cartData));
  }

  // Load cart data from SharedPreferences
  Future<List<AddProduct>> loadCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cartData');
    if (cartData != null) {
      final decodedData = jsonDecode(cartData) as List;
      List<AddProduct> loadedProducts =
          decodedData.map((json) => AddProduct.fromJson(json)).toList();

      // Filter out duplicate products based on their IDs
      Map<int, AddProduct> uniqueProductsMap = {};
      for (var product in loadedProducts) {
        uniqueProductsMap[product.id] = product;
      }

      // Convert map values back to a list
      List<AddProduct> uniqueProducts = uniqueProductsMap.values.toList();

      return uniqueProducts;
    }
    return [];
  }
}
