import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsdk_assignment/Component/buttom_navbar.dart';
import 'package:hsdk_assignment/Screens/add_medicine.dart';
import 'package:hsdk_assignment/Screens/medicine_deetails.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Report",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Todays's Report",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "5",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Total",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "3",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Taken",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Missed",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Snoozed",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Check Dashboard",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Text(
                              "Here you will find everything related to your active and past medicine.",
                              style: TextStyle(fontSize: 15, color: Colors.grey),
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 1,
                                centerSpaceRadius: 20,
                                sections: [
                                  PieChartSectionData(
                                      color: Colors.teal,
                                      value: 40,
                                      radius: 6,
                                      showTitle: false),
                                  PieChartSectionData(
                                      color: Colors.orangeAccent,
                                      value: 30,
                                      radius: 6,
                                      showTitle: false),
                                  PieChartSectionData(
                                      color: Colors.redAccent,
                                      value: 20,
                                      radius: 6,
                                      showTitle: false),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Check History",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 30,
                        )),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _historData("SUN", "1", true),
                      _historData("MON", "2", false),
                      _historData("TUE", "3", false),
                      _historData("WED", "4", false),
                      _historData("THU", "5", false),
                      _historData("FRI", "6", false),
                      _historData("SAT", "7", false),
                    ],
                  ),
                ),
                const MedicineDetails(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const ButtomNavbar(),
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
    );
  }

  Widget _historData(String day, String count, bool isSelected) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              day,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: isSelected
                  ? Colors.blue
                  : const Color.fromARGB(255, 224, 239, 247),
              child: Text(
                count,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
