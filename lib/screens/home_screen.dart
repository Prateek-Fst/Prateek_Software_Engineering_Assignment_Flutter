import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/product_item.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../services/api_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  String _selectedSortOption = 'None';
  bool _isLoading = false;
  int _currentPage = 1;
  int _pageSize = 10; // Number of products to fetch per page
  ScrollController _scrollController = ScrollController();
  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Reached the bottom
      _fetchProducts();
    }
  }

  Future<void> _fetchProducts() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      List<Product> newProducts = await _apiService.getProducts();
      setState(() {
        _allProducts.addAll(newProducts);
        _filteredProducts = _allProducts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error, e.g., show a SnackBar or retry mechanism
      print('Error fetching products: $e');
    }
  }

  void _filterProducts(String query) {
    List<Product> filteredList = _allProducts
        .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredProducts = filteredList;
    });
  }

  void _sortProducts(String option) {
    List<Product> sortedList = List.from(_filteredProducts);
    switch (option) {
      case 'Rating':
        sortedList.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Price: Low to High':
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        sortedList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Category':
        sortedList.sort((a, b) => a.category.compareTo(b.category));
        break;
      default:
        sortedList = _filteredProducts;
        break;
    }
    setState(() {
      _filteredProducts = sortedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              authProvider.signOut();
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (auth.status == AuthStatus.authenticated) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Search Products',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onChanged: (value) {
                            _filterProducts(value);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: _selectedSortOption,
                        items: [
                          DropdownMenuItem(
                            value: 'None',
                            child: Text('Sort by'),
                          ),
                          DropdownMenuItem(
                            value: 'Rating',
                            child: Text('Rating'),
                          ),
                          DropdownMenuItem(
                            value: 'Price: Low to High',
                            child: Text('Price: Low to High'),
                          ),
                          DropdownMenuItem(
                            value: 'Price: High to Low',
                            child: Text('Price: High to Low'),
                          ),
                          DropdownMenuItem(
                            value: 'Category',
                            child: Text('Category'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedSortOption = value!;
                          });
                          _sortProducts(value!);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _filteredProducts.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < _filteredProducts.length) {
                        return ProductItem(
                          product: _filteredProducts[index],
                          onAddToCart: () {
                            cartProvider.addToCart(_filteredProducts[index]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Added to Cart: ${_filteredProducts[index].title}'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Please log in to see products'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
