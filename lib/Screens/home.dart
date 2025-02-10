import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsdk_assignment/Component/buttom_navbar.dart';
import 'package:hsdk_assignment/Screens/add_medicine.dart';
import 'package:hsdk_assignment/Screens/medicine_deetails.dart';
import 'package:hsdk_assignment/Screens/profile.dart';
import 'package:hsdk_assignment/Services/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDateIndex = 2;

  static final List<Widget> _screens = [
    const Placeholder(),
    const Placeholder(),
    const MedicineDetails(),
    const Center(
      child: Text("Nothing is Here, Add medicine "),
    ),
    const Placeholder(),
  ];

  final List<String> _dates = ["Thu", "Fri", "Saturday, Sep 3", "Sun", "Mon"];

  void _onDateTapped(int index) {
    setState(() {
      _selectedDateIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (user?.displayName != null) ...[
                          Text(
                            'Hii ${user!.displayName} !',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ] else ...[
                          const Text(
                            'Hii User !',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                        const Text("5 Medicines left"),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.medical_services,
                        color: Colors.blue,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage()),
                      ),
                      child: user?.photoURL != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(user!.photoURL!),
                            )
                          : const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                    ),
                  ],
                ),
              ),

              // Scrollable Date Tab Bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Left Arrow
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.blue),
                      onPressed: _selectedDateIndex > 0
                          ? () => _onDateTapped(_selectedDateIndex - 1)
                          : null,
                    ),

                    // Scrollable Date Tabs
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_dates.length, (index) {
                            bool isSelected = _selectedDateIndex == index;
                            return GestureDetector(
                              onTap: () => _onDateTapped(index),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.blueGrey[900]
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    _dates[index],
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                    // Right Arrow
                    IconButton(
                      icon: const Icon(Icons.chevron_right, color: Colors.blue),
                      onPressed: _selectedDateIndex < _dates.length - 1
                          ? () => _onDateTapped(_selectedDateIndex + 1)
                          : null,
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                    child: _screens[_selectedDateIndex]), // Show selected screen
              ),
            ],
          ),
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: const ButtomNavbar(),

        // Floating Action Button
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddMedicinePage()),
            );
          },
          child: const ClipOval(
            child: Material(
              color: Colors.black,
              elevation: 10,
              child: InkWell(
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    CupertinoIcons.add,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
