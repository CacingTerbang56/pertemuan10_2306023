import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';
import 'login_page.dart';
import '../pages/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';
  List<ProductModel> products = [];
  int totalProduct = 0;

  @override
  void initState() {
    super.initState();
    getUser();
    loadProducts();
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productList = prefs.getStringList('products') ?? [];
    totalProduct = productList.length;
    setState(() {
      products = productList.reversed
          .take(3)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile container
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                        "data:image/jpeg;base64,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",
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What Do You Want Nigga?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                username,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.verified,
                                color: Colors.green,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: logout,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.logout,
                          size: 28,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text('total produk: ${totalProduct.toString()}'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProductPage()));
                  }, child: Text('lihat selengkapnya'))
                ],
              ),

              
              
            ],
          ),
        ),
      ),
    );
  }
}
