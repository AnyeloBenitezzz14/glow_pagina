import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xFFF8F9FA);
const Color shippingBackground = Color(0xFFF0F8FF);
const Color primaryColor = Color(0xFFE93B81);
const Color cardColor = Color(0xFFFAF7F5);
const Color secondaryTextColor = Color(0xFF71717A);
const Color darkTextColor = Color(0xFF1A1A1A);

class ShoppingBagScreen extends StatefulWidget {
  const ShoppingBagScreen({super.key});

  @override
  State<ShoppingBagScreen> createState() => _ShoppingBagScreenState();
}

class _ShoppingBagScreenState extends State<ShoppingBagScreen> {
  final List<CartProduct> _products = [
    CartProduct(
      name: 'Velvet',
      detailLabel: 'Shade:',
      detailValue: 'Rose\nPetal',
      price: 24,
      quantity: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1586495777744-4413f21062fa?auto=format&fit=crop&w=300&q=85',
    ),
    CartProduct(
      name: 'Hydra1',
      detailLabel: 'Shade:',
      detailValue: 'Light\nBeige',
      price: 42,
      quantity: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=300&q=85',
    ),
    CartProduct(
      name: 'Volum',
      detailLabel: 'Color:',
      detailValue: 'Midni\nght\nBlack',
      price: 18,
      quantity: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1631730486572-226d1f595b68?auto=format&fit=crop&w=300&q=85',
    ),
  ];

  void _changeQuantity(int index, int change) {
    setState(() {
      final nextQuantity = _products[index].quantity + change;
      if (nextQuantity > 0) {
        _products[index].quantity = nextQuantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, color: darkTextColor),
          tooltip: 'Back',
        ),
        title: const Text(
          'Your Bag',
          style: TextStyle(
            color: darkTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: darkTextColor),
            tooltip: 'More options',
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShippingProgress(),
              const SizedBox(height: 18),
              ..._products.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ProductCartCard(
                    product: entry.value,
                    onDecrease: () => _changeQuantity(entry.key, -1),
                    onIncrease: () => _changeQuantity(entry.key, 1),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const OrderSummary(),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: primaryColor.withValues(alpha: 0.28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Checkout →',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const SecureCheckoutNote(),
            ],
          ),
        ),
      ),
    );
  }
}

class ShippingProgress extends StatelessWidget {
  const ShippingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: shippingBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FREE SHIPPING PROGRESS',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$18.00 left',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.8,
              minHeight: 8,
              backgroundColor: Color(0xFFFCE4EC),
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCartCard extends StatelessWidget {
  const ProductCartCard({
    required this.product,
    required this.onDecrease,
    required this.onIncrease,
    super.key,
  });

  final CartProduct product;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x24E93B81),
            blurRadius: 12,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ProductImage(imageUrl: product.imageUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    color: darkTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.detailLabel,
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  product.detailValue,
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          QuantityControl(
            quantity: product.quantity,
            onDecrease: onDecrease,
            onIncrease: onIncrease,
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({required this.imageUrl, super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 70,
        height: 70,
        color: const Color(0xFFF3DCD4),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.auto_awesome, color: Color(0xFFD68B9E)),
        ),
      ),
    );
  }
}

class QuantityControl extends StatelessWidget {
  const QuantityControl({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    super.key,
  });

  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        QuantityButton(icon: Icons.remove, onPressed: onDecrease),
        SizedBox(
          width: 28,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: darkTextColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        QuantityButton(icon: Icons.add, onPressed: onIncrease),
      ],
    );
  }
}

class QuantityButton extends StatelessWidget {
  const QuantityButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 1,
      shadowColor: const Color(0x22000000),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(icon, size: 16, color: darkTextColor),
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            color: darkTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 18),
        const SummaryRow(label: 'Subtotal', value: '\$102.00'),
        const SizedBox(height: 12),
        const SummaryRow(label: 'Estimated Shipping', value: '\$5.99'),
        const SizedBox(height: 12),
        const SummaryRow(label: 'Tax', value: '\$8.19'),
        const SizedBox(height: 18),
        const Divider(color: Color(0xFFE4E4E7), height: 1),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount',
              style: TextStyle(
                color: darkTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '\$116.15',
              style: TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: secondaryTextColor, fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(
            color: darkTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class SecureCheckoutNote extends StatelessWidget {
  const SecureCheckoutNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_outline, size: 13, color: Color(0xFFA1A1AA)),
        const SizedBox(width: 6),
        Text(
          'SECURE CHECKOUT POWERED BY STRIPE',
          style: const TextStyle(
            color: Color(0xFFA1A1AA),
            fontSize: 10,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

class CartProduct {
  CartProduct({
    required this.name,
    required this.detailLabel,
    required this.detailValue,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  final String name;
  final String detailLabel;
  final String detailValue;
  final double price;
  int quantity;
  final String imageUrl;
}
