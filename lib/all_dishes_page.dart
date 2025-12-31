import 'package:flutter/material.dart';
import 'models/dish.dart';
import 'home_page.dart'; // فيه allDishes و primary color

// Temporary placeholder list. Replace or populate from your data source.
final List<Dish> allDishes = [];

class AllDishesPage extends StatelessWidget {
  const AllDishesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('جميع الأطباق'),
          backgroundColor: HomePage.primary,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: allDishes.length,
          itemBuilder: (context, index) {
            final dish = allDishes[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    dish.imageAsset,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(dish.name),
                subtitle: Text(
                  'من عند ${dish.cookName}  ${dish.location}',
                ),
                trailing: Text(
                  dish.price,
                  style: const TextStyle(
                    color: HomePage.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
