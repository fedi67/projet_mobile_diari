import 'package:flutter/material.dart';
import 'models/cooker.dart';
import 'cooker_messages.dart';

// Base de données des plats par cuisinier
class CookerDatabase {
  static List<DishItem> getDishesForCooker(String cookerName) {
    final dishes = {
      'مريم بن علي': [
        DishItem(
          image: 'lib/assets/images/koski.jpg',
          name: 'كسكسي تقليدي',
          price: 'TND 15.50',
          rating: 4.8,
          location: 'عوينة',
        ),
        DishItem(
          image: 'lib/assets/images/tajin.jpg',
          name: 'طاجين دجاج',
          price: 'TND 13.00',
          rating: 4.9,
          location: 'عوينة',
        ),
        DishItem(
          image: 'lib/assets/images/mloukhia.jpg',
          name: 'ملوخية باللحم',
          price: 'TND 18.00',
          rating: 4.7,
          location: 'عوينة',
        ),
      ],
      'علي الغربي': [
        DishItem(
          image: 'lib/assets/images/fish.jpg',
          name: 'سمك مشوي',
          price: 'TND 25.00',
          rating: 4.9,
          location: 'البحيرة',
        ),
        DishItem(
          image: 'lib/assets/images/seafood_pasta.jpg',
          name: 'مقرونة بالفواكه البحرية',
          price: 'TND 18.00',
          rating: 4.7,
          location: 'البحيرة',
        ),
        DishItem(
          image: 'lib/assets/images/mo9li.jpg',
          name: 'صحن مقلي',
          price: 'TND 22.00',
          rating: 4.8,
          location: 'البحيرة',
        ),
      ],
      'سارة منصور': [
        DishItem(
          image: 'lib/assets/images/baklava.jpg',
          name: 'بقلاوة تونسية',
          price: 'TND 8.00',
          rating: 4.9,
          location: 'المنزه',
        ),
        DishItem(
          image: 'lib/assets/images/makroudh.jpg',
          name: 'مقروض القيروان',
          price: 'TND 12.00',
          rating: 4.8,
          location: 'المنزه',
        ),
        DishItem(
          image: 'lib/assets/images/yoyo.jpg',
          name: 'يويو تونسي',
          price: 'TND 10.00',
          rating: 4.7,
          location: 'المنزه',
        ),
      ],
    };
    return dishes[cookerName] ?? [];
  }

  static List<ReviewItem> getReviewsForCooker(String cookerName) {
    final reviews = {
      'مريم بن علي': [
        ReviewItem(
          userName: 'أ. أحمد م',
          rating: 5,
          comment: 'أحسن كسكسي! يذكّرني بطبخ أمي',
          timeAgo: 'منذ يومين',
        ),
        ReviewItem(
          userName: 'س. ليلى',
          rating: 5,
          comment: 'كان لذيذ برشا وخدمت بسرعة',
          timeAgo: 'ساعة ضمّت',
        ),
        ReviewItem(
          userName: 'أمل.ب',
          rating: 5,
          comment: 'توصيل سريع وكسكسي هايل',
          timeAgo: 'منذ يوم',
        ),
      ],
      'علي الغربي': [
        ReviewItem(
          userName: 'ياسين.ك',
          rating: 5,
          comment: 'سمك طازج وطريقة شواء ممتازة',
          timeAgo: 'منذ 3 أيام',
        ),
        ReviewItem(
          userName: 'فاطمة.ز',
          rating: 5,
          comment: 'القمرون كان طايب برشا',
          timeAgo: 'منذ أسبوع',
        ),
        ReviewItem(
          userName: 'م. سامي',
          rating: 4,
          comment: 'جيد لكن التوصيل تأخر شوية',
          timeAgo: 'منذ يومين',
        ),
      ],
      'سارة منصور': [
        ReviewItem(
          userName: 'نادية.ح',
          rating: 5,
          comment: 'البقلاوة روعة! مثل اللي تعمل أمي',
          timeAgo: 'منذ يوم',
        ),
        ReviewItem(
          userName: 'رضا.ب',
          rating: 5,
          comment: 'مقروض ممتاز، ننصح بيه',
          timeAgo: 'منذ 5 أيام',
        ),
        ReviewItem(
          userName: 'ل. منى',
          rating: 4,
          comment: 'حلو برشا، لكن نحب الكمية تكون أكثر',
          timeAgo: 'منذ أسبوع',
        ),
      ],
    };
    return reviews[cookerName] ?? [];
  }

  static int getReviewCountForCooker(String cookerName) {
    final counts = {
      'مريم بن علي': 127,
      'علي الغربي': 95,
      'سارة منصور': 83,
    };
    return counts[cookerName] ?? 50;
  }
}

class DishItem {
  final String image;
  final String name;
  final String price;
  final double rating;
  final String location;

  DishItem({
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    required this.location,
  });
}

class ReviewItem {
  final String userName;
  final int rating;
  final String comment;
  final String timeAgo;

  ReviewItem({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.timeAgo,
  });
}

class CookerDetailsPage extends StatelessWidget {
  final Cooker cooker;

  const CookerDetailsPage({super.key, required this.cooker});

  @override
  Widget build(BuildContext context) {
    // Récupérer les plats et avis spécifiques du cuisinier
    final dishes = CookerDatabase.getDishesForCooker(cooker.name);
    final reviews = CookerDatabase.getReviewsForCooker(cooker.name);
    final reviewCount = CookerDatabase.getReviewCountForCooker(cooker.name);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top colored header
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFEE8C2B), Color(0xFFEE8C2B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(0),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black87,
                          ),
                          onPressed: () => Navigator.of(context).maybePop(),
                        ),
                      ),
                    ),
                  ),
                ),

                // Overlapping card + avatar
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 60, 16, 24),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                cooker.name,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    cooker.rating.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '($reviewCount تقييم)',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    cooker.location,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),

                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'نبذة',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                cooker.bio,
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(height: 18),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Avatar
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CircleAvatar(
                          radius: 54,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: cooker.avatarUrl.startsWith('http')
                                ? NetworkImage(cooker.avatarUrl)
                                : AssetImage(cooker.avatarUrl) as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Available dishes section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'الأطباق المتوفرة',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 230,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: dishes.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final dish = dishes[index];
                            return _DishSmallCard(
                              image: dish.image,
                              name: dish.name,
                              price: dish.price,
                              cookName: cooker.name,
                              rating: dish.rating,
                              location: dish.location,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Latest reviews section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'آخر التقييمات',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 12),
                      ...reviews.map((review) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review.userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 6),
                                      Text('${review.rating}'),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                review.comment,
                                style: const TextStyle(height: 1.6),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                review.timeAgo,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                // add bottom spacing so content can scroll above sticky button
                const SizedBox(height: 110),
              ],
            ),
          ),
        ),
        // Persistent sticky button shown above system inset
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: SizedBox(
            height: 64,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEE8C2B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CookerMessagesPage(cooker: cooker),
                  ),
                );
              },
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text(
                'رسل رسالة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DishSmallCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String cookName;
  final double rating;
  final String location;

  const _DishSmallCard({
    required this.image,
    required this.name,
    required this.price,
    required this.cookName,
    required this.rating,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              color: Colors.black12,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                image,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 110,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.restaurant, size: 40),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Color(0xFFEE8C2B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}