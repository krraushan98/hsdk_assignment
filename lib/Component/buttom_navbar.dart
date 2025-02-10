import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsdk_assignment/Screens/home.dart';
import 'package:hsdk_assignment/Screens/report.dart';

class ButtomNavbar extends StatefulWidget {
  const ButtomNavbar({super.key});

  @override
  State<ButtomNavbar> createState() => _ButtomNavbarState();
}

class _ButtomNavbarState extends State<ButtomNavbar> {
  static int _selectedIndex = 0;
  static int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavBarItem(CupertinoIcons.house_fill, 'Home', 0),
          const SizedBox(width: 20),
          buildNavBarItem(CupertinoIcons.chart_bar_alt_fill, 'Report', 1),
        ],
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        if (_currentIndex != _selectedIndex) {
          if (index == 1) {
            _currentIndex = 1;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReportPage()),
            );
          }
          if (index == 0) {
            _currentIndex = 0;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? Colors.blue : Colors.black87,
          ),
          Text(
            label,
          ),
        ],
      ),
    );
  }
}
