import 'package:flutter/material.dart';
import 'bag.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedCategory = 0;
  int _selectedTab = 0;
  final Set<int> _likedProducts = <int>{};

  static const categories = [
    'All Products',
    'Lipstick',
    'Foundation',
    'Eyeshadow',
  ];
  static const products = <Product>[
    Product(
      'Velvet Matte Lipstick',
      '\$24.00',
      'Lipstick',
      Color(0xFFFFE3D7),
      'https://images.unsplash.com/photo-1586495777744-4413f21062fa?auto=format&fit=crop&w=700&q=85',
      'NEW',
    ),
    Product(
      'Silk Finish Foundation',
      '\$42.00',
      'Foundation',
      Color(0xFFFFE8DB),
      'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=700&q=85',
    ),
    Product(
      'Nude Dreams Palette',
      '\$38.00',
      'Eyeshadow',
      Color(0xFFECD8C4),
      'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&w=700&q=85',
      'BESTSELLER',
    ),
    Product(
      'Rose Glow Blush',
      '\$28.00',
      'Blush',
      Color(0xFFFFDDE2),
      'https://images.unsplash.com/photo-1596462502278-27bfdc403348?auto=format&fit=crop&w=700&q=85',
    ),
    Product(
      'Hydrating Primer',
      '\$35.00',
      'Foundation',
      Color(0xFFFFE7DB),
      'https://images.unsplash.com/photo-1556229010-6c3f2c9ca5f8?auto=format&fit=crop&w=700&q=85',
    ),
    Product(
      'Long-wear Eyeliner',
      '\$22.00',
      'Eyeshadow',
      Color(0xFFF8E1D8),
      'https://images.unsplash.com/photo-1631730486572-226d1f595b68?auto=format&fit=crop&w=700&q=85',
    ),
    Product(
      'Crystal Lip Gloss',
      '\$19.00',
      'Lipstick',
      Color(0xFFFFE6E5),
      'https://images.unsplash.com/photo-1619451334792-150fd785ee74?auto=format&fit=crop&w=700&q=85',
    ),
    Product(
      'Volume Lash Mascara',
      '\$26.00',
      'Eyeshadow',
      Color(0xFFE8D6C7),
      'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=700&h=700&q=90',
    ),
  ];

  List<Product> get visibleProducts => _selectedCategory == 0
      ? products
      : products
            .where(
              (product) => product.category == categories[_selectedCategory],
            )
            .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildCategories()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = visibleProducts[index];
                  final productIndex = products.indexOf(product);
                  return ProductCard(
                    product: product,
                    liked: _likedProducts.contains(productIndex),
                    onLike: () => setState(() {
                      if (!_likedProducts.add(productIndex)) {
                        _likedProducts.remove(productIndex);
                      }
                    }),
                  );
                }, childCount: visibleProducts.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.64,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        selectedItemColor: const Color(0xFF78A9E8),
        unselectedItemColor: const Color(0xFFA6AFBC),
        selectedFontSize: 7,
        unselectedFontSize: 7,
        iconSize: 17,
        currentIndex: _selectedTab,
        onTap: (index) => setState(() => _selectedTab = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'SHOP',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'WISHLIST',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu, color: Color(0xFF30262A)),
                  tooltip: 'Menu',
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.7,
                  ),
                  children: [
                    TextSpan(
                      text: 'LUXE ',
                      style: TextStyle(color: Color(0xFFE96486)),
                    ),
                    TextSpan(
                      text: 'BEAUTY',
                      style: TextStyle(color: Color(0xFF382D31)),
                    ),
                  ],
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => const ShoppingBagScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xFF30262A),
                    ),
                    tooltip: 'Shopping bag',
                  ),
                  Positioned(
                    top: 3,
                    right: 3,
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE96486),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search lipsticks, foundations...',
              hintStyle: const TextStyle(
                color: Color(0xFF9D8F92),
                fontSize: 13,
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: 21,
                color: Color(0xFFE96486),
              ),
              filled: true,
              fillColor: Color(0xFFFFF0F4),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: Color(0xFFF6C8D5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: Color(0xFFF6C8D5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: Color(0xFFE96486)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 68,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => setState(() => _selectedCategory = index),
          child: Container(
            margin: const EdgeInsets.only(right: 26),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: index == _selectedCategory
                      ? const Color(0xFFE96486)
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              categories[index],
              style: TextStyle(
                color: index == _selectedCategory
                    ? const Color(0xFFE05F80)
                    : const Color(0xFF8C7B80),
                fontSize: 13,
                fontWeight: index == _selectedCategory
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFFFFAF8),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'LUXE BEAUTY',
                style: TextStyle(
                  color: Color(0xFFE96486),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 42),
              for (final item in [
                'Shop all products',
                'New arrivals',
                'Best sellers',
                'About Luxe Beauty',
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF493A3F),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.liked,
    required this.onLike,
    super.key,
  });

  final Product product;
  final bool liked;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 0.92,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: product.color,
                  borderRadius: BorderRadius.circular(18),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.auto_awesome,
                      size: 40,
                      color: Color(0xFFE69CA8),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: onLike,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Color(0xCCFFFAF8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_outline,
                      size: 18,
                      color: liked
                          ? const Color(0xFFE96486)
                          : const Color(0xFF5D4B50),
                    ),
                  ),
                ),
              ),
              if (product.badge != null)
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: product.badge == 'BESTSELLER'
                          ? const Color(0xFF77777D)
                          : const Color(0xFFFF6F91),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      product.badge!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 9),
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF3D3034),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          product.price,
          style: const TextStyle(
            color: Color(0xFFE05F80),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class Product {
  const Product(
    this.name,
    this.price,
    this.category,
    this.color,
    this.imageUrl, [
    this.badge,
  ]);

  final String name;
  final String price;
  final String category;
  final Color color;
  final String imageUrl;
  final String? badge;
}
