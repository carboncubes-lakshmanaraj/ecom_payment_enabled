import 'package:ecom_payment/datas/dummydata.dart';
import 'package:flutter/material.dart';

class CategoryRoundNavBar extends StatefulWidget {
  const CategoryRoundNavBar({super.key});

  @override
  State<CategoryRoundNavBar> createState() => _CategoryRoundNavBarState();
}

class _CategoryRoundNavBarState extends State<CategoryRoundNavBar> {
  @override
  Widget build(BuildContext context) {
    return // Categories
    Column(
      children: [
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (_, index) {
              final category = categoryList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    // Handle tap
                    print("Tapped on category: ${category.title}");
                    // You can navigate or filter based on category.id or title
                  },
                  borderRadius: BorderRadius.circular(30), // for ripple effect
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(category.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        category.title,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
