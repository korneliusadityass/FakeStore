import 'package:appsmobile/ui/shared/spacing.dart';
import 'package:appsmobile/ui/views/detail/detail_view.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key, required this.selectedProducts});
  final List<AddProduct> selectedProducts;

  @override
  Widget build(BuildContext context) {
    double totalHarga = 0;
    int totalBarang = 0;
    for (var product in selectedProducts) {
      totalHarga += product.price * product.quantity;
      totalBarang += product.quantity;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _showCancelConfirmationDialog(context),
        ),
      ),
      body: ListView.builder(
        itemCount: selectedProducts.length,
        itemBuilder: (context, index) {
          final product = selectedProducts[index];
          return ListTile(
            leading: Image.network(product.image),
            title: Text(
              product.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ ${product.price.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$totalBarang',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 130,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total :',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$ $totalHarga',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacings.verSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 170,
                    child: FloatingActionButton.extended(
                      onPressed: () {},
                      label: const Text('Pay Now'),
                      icon: const Icon(Icons.payment),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 170,
                    child: FloatingActionButton.extended(
                      onPressed: () => _showCancelConfirmationDialog(context),
                      label: const Text('Cancel'),
                      icon: const Icon(
                        Icons.cancel,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // floatingActionButton:
    );
  }
}

void _showCancelConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Cancel Checkout?"),
        content:
            const Text("Are you sure you want to cancel the checkout process?"),
        actions: <Widget>[
          TextButton(
            child: const Text("No"),
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
            },
          ),
          TextButton(
            child: const Text("Yes"),
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
              Navigator.of(context)
                  .pop(); // Kembali ke halaman sebelumnya (cart)
            },
          ),
        ],
      );
    },
  );
}
