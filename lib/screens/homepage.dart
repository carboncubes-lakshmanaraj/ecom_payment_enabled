import 'package:ecom_payment/screens/cartpage.dart';
import 'package:ecom_payment/screens/home.dart';
import 'package:ecom_payment/screens/orders_table_full%20_history_viewpage.dart';
import 'package:ecom_payment/screens/settingpagetile.dart';
import 'package:ecom_payment/screens/wishlist.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    Home(),
    WishList(),
    CartPage(),
    Settingpagetile(),
    Settingpagetile(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedColor = const Color(0xFFF83758);
    final unselectedColor = Colors.grey;

    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents FAB from shifting
      body: _pages[_selectedIndex],
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () => _onItemTapped(2),
          shape: CircleBorder(),
          backgroundColor: _selectedIndex == 2
              ? selectedColor
              : Colors.grey[200],
          child: Icon(
            Icons.shopping_cart,
            color: _selectedIndex == 2
                ? const Color.fromARGB(255, 255, 255, 255)
                : Colors.grey,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 8, // Add elevation here
        color: Colors.grey[200],
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              _buildNavItem(
                icon: Icons.favorite,
                label: 'Wishlist',
                index: 1,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              const SizedBox(width: 40), // Space for FAB
              _buildNavItem(
                icon: Icons.search,
                label: 'Search',
                index: 3,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              _buildNavItem(
                icon: Icons.settings,
                label: 'Setting',
                index: 4,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? selectedColor : unselectedColor),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? selectedColor : unselectedColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
