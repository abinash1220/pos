import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/views/customers_view/customer_view.dart';
import 'package:pos/src/views/home_view/home_view.dart';
import 'package:pos/src/views/profile_view/profile_view.dart';
import 'package:pos/src/views/recent_orders_view/recent_order.dart';

class HomePageWithNavigation extends StatefulWidget {
  int index;
  HomePageWithNavigation({Key? key, this.index = 0}) : super(key: key);

  @override
  State<HomePageWithNavigation> createState() => _HomePageWithNavigationState();
}

class _HomePageWithNavigationState extends State<HomePageWithNavigation> {
  int _selectedIndex = 0;
  Color color = const Color.fromARGB(
    255,
    0,
    96,
    50,
  );

  List pages = [
    HomeView(),
    RecentOrders(),
    CustomerSView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/home_icons.png",
              height: 20,
              color: _selectedIndex == 0
                  ? primaryColor
                  : primaryColor.withOpacity(0.5),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/menu_icons.png",
              height: 20,
              color: _selectedIndex == 1
                  ? primaryColor
                  : primaryColor.withOpacity(0.5),
            ),
            label: 'Recent Orderes',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/customers_icon.png",
              height: 20,
              color: _selectedIndex == 2
                  ? primaryColor
                  : primaryColor.withOpacity(0.5),
            ),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/profile_icons.png",
              height: 20,
              color: _selectedIndex == 3
                  ? primaryColor
                  : primaryColor.withOpacity(0.5),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        unselectedItemColor: primaryColor.withOpacity(0.5),
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
