import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:p7_provider/cart_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => CartModel(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokopedia',
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatelessWidget {
  new({super.key});

  final List<Product> products = [
    Product('Tepung Segitiga Biru'),
    Product('Minyak Rizky'),
    Product('Susu'),
    Product('Kecap Bango'),
    Product('Saos Tiram'),
    Product(''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tokopaedi'),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 20),
            child: Consumer<CartModel>(
              builder: (context, value, child) {
                return Badge(
                  label: Text('${value.totalItems}'),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      );
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.nama),
            trailing: IconButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).add(product);
              },
              icon: Icon(Icons.shopping_cart_checkout),
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Keranjang')),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          if (value.totalItems == 0) {
            return Center(child: Text('Keranjang Kosong'));
          }

          return ListView.builder(
            itemCount: value.totalItems,
            itemBuilder: (context, index) {
              final product = value.list[index];

              return ListTile(
                title: Text(product.nama),
                trailing: ElevatedButton(
                  onPressed: () {
                    Provider.of<CartModel>(
                      context,
                      listen: false,
                    ).remove(product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Hapus'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
