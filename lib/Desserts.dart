import 'package:flutter/material.dart';

/// -------------------- MODELE --------------------
class DessertDish {
  final String name;
  final String price;
  final String cookName;
  final double rating;
  final String location;
  final String imageAsset;

  DessertDish({
    required this.name,
    required this.price,
    required this.cookName,
    required this.rating,
    required this.location,
    required this.imageAsset,
  });
}

/// -------------------- WIDGETS --------------------
class DessertDishCard extends StatelessWidget {
  final DessertDish dish;
  const DessertDishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(blurRadius: 8, color: Colors.black12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              dish.imageAsset,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  dish.price,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'من عند ${dish.cookName}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          dish.rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          dish.location,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Text(
        title,
        textDirection: TextDirection.rtl,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// -------------------- PAGE PRINCIPALE --------------------
class DessertsPage extends StatelessWidget {
  const DessertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dessertDishes = [
      DessertDish(
        name: 'بمبلوني',
        price: '4.50 د.ت',
        cookName: 'كوثر',
        rating: 4.6,
        location: 'سوسة',
        imageAsset: 'lib/assets/images/dessert1.jpg',
      ),
      DessertDish(
        name: 'زلابية',
        price: '9.00 د.ت',
        cookName: 'سعاد',
        rating: 4.8,
        location: 'تونس',
        imageAsset: 'lib/assets/images/dessert2.jpg',
      ),
      DessertDish(
        name: 'يويو',
        price: '7.50 د.ت',
        cookName: 'نجاة',
        rating: 4.7,
        location: 'صفاقس',
        imageAsset: 'lib/assets/images/dessert3.jpg',
      ),
      DessertDish(
        name: 'بقلاوة',
        price: '45.000 د.ت',
        cookName: 'نجاة',
        rating: 4.7,
        location: 'صفاقس',
        imageAsset: 'lib/assets/images/dessert4.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('حلويات'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          const SectionTitle(title: 'أطباق الحلويات'),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: dessertDishes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, i) => DessertDishCard(dish: dessertDishes[i]),
            ),
          ),
        ],
      ),
    );
  }
}
