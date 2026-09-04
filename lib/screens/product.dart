import 'package:flutter/material.dart';

const _accent = Color(0xFFE93B81);
const _primaryText = Color(0xFF1A1A1A);
const _secondaryText = Color(0xFF71717A);
const _formulaBackground = Color(0xFFFFF1F5);
const _quantityBackground = Color(0xFFF0F4F8);
const _modelImageUrl =
    'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?auto=format&fit=crop&w=900&q=85';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class ProductScreen extends ProductDetailScreen {
  const ProductScreen({super.key});
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int _selectedShade = 0;

  static const _shades = [
    Color(0xFFE93B81),
    Color(0xFFB91C1C),
    Color(0xFFFB7185),
    Color(0xFF881337),
    Color(0xFFFCA5A5),
    Color(0xFF701A2D),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    _buildProductImage(),
                    _buildProductInfo(),
                    _buildFormula(),
                    _buildShadeSelector(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildActionBar(),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.maybePop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 40, height: 40),
              icon: const Icon(Icons.arrow_back_ios_new, color: _primaryText),
            ),
            const Expanded(
              child: Text(
                'Product Detail',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.share_outlined, color: _secondaryText, size: 21),
            const SizedBox(width: 16),
            const Icon(Icons.favorite_outline, color: _secondaryText, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 380,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                _modelImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Image.asset(
                  'assets/images/login_makeup.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const ColoredBox(
                    color: Color(0xFFF7A0AC),
                    child: Icon(Icons.image_outlined, color: Colors.white),
                  ),
                ),
              ),
              IgnorePointer(
                child: ColoredBox(
                  color: _accent.withAlpha(28),
                  child: const SizedBox.expand(),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xDDF1F5F9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'BEST SELLER',
                    style: TextStyle(
                      color: _primaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Velvet Matte Lipstick',
                  style: TextStyle(
                    color: _primaryText,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                '\$42.00',
                style: TextStyle(
                  color: _accent,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Ultra-Pigmented Finish',
            style: TextStyle(color: _secondaryText, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildFormula() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _formulaBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'THE FORMULA',
            style: TextStyle(
              color: _accent,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Indulge in our most luxurious matte finish yet. Formulated with rare botanical oils and hyaluronic acid, this lipstick glides on like silk while providing high-impact color that lasts for 12 hours without drying.',
            style: TextStyle(
              color: Color(0xFF52525B),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShadeSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SELECT SHADE',
            style: TextStyle(
              color: _primaryText,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(_shades.length, (index) {
              final isSelected = _selectedShade == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedShade = index),
                child: Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: _shades[index],
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                    boxShadow: isSelected
                        ? const [
                            BoxShadow(
                              color: Color(0x669E9E9E),
                              blurRadius: 0,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          const Text.rich(
            TextSpan(
              text: 'Current selection: ',
              style: TextStyle(color: _secondaryText, fontSize: 12),
              children: [
                TextSpan(
                  text: 'Iconic Ruby',
                  style: TextStyle(
                    color: _primaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          Container(
            width: 110,
            height: 50,
            decoration: BoxDecoration(
              color: _quantityBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _quantityButton(Icons.remove, () {
                  if (_quantity > 1) setState(() => _quantity--);
                }),
                Text(
                  '$_quantity',
                  style: const TextStyle(
                    color: _primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _quantityButton(Icons.add, () => setState(() => _quantity++)),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 180,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_bag_outlined, size: 20),
              label: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 30, height: 40),
      icon: Icon(icon, size: 17, color: _secondaryText),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 66,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavigationItem(icon: Icons.storefront, label: 'SHOP', active: true),
          _NavigationItem(icon: Icons.search, label: 'EXPLORE'),
          _NavigationItem(icon: Icons.favorite_outline, label: 'SAVED'),
          _NavigationItem(icon: Icons.person_outline, label: 'PROFILE'),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? _accent : const Color(0xFF9CA3AF);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
