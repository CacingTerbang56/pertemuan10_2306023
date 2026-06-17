import 'package:flutter/material.dart';
import 'package:pertemuan10_2306023/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'detail produk',
          style: TextStyle(color: Colors.white, fontWeight: .bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: .all(20),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: .bold),
            ),
            const SizedBox(height: 10,),
            Text('Rp. ${product.price}'),
            const SizedBox(height: 10,),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
