import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  int selectedCompartment = 1;
  int selectedColor = 0;
  String selectedFrequency = "Everyday";
  String selectedTimesADay = "Three Time";

  List<String> compartments = ["1", "2", "3", "4", "5", "6"];
  List<Color> colors = [
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
  ];
  List<String> medicineTypes = ["Tablet", "Capsule", "Cream", "Liquid"];
  List<String> frequencyOptions = ["Everyday", "Alternate Days", "Weekly"];
  List<String> timesPerDay = ["Once", "Twice", "Three Time", "Four Time"];

  int totalCount = 1;
  double _sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Medicines"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search Medicine Name",
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Compartments Selection
            const Text("Compartment", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: compartments.map((comp) {
                int index = compartments.indexOf(comp);
                return GestureDetector(
                  onTap: () => setState(() => selectedCompartment = index + 1),
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedCompartment == index + 1
                              ? Colors.blue
                              : Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade100,
                    ),
                    child: Text(comp, style: const TextStyle(fontSize: 16)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Colors Selection
            const Text("Colour", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: colors.asMap().entries.map((entry) {
                int index = entry.key;
                Color color = entry.value;
                return GestureDetector(
                  onTap: () => setState(() => selectedColor = index),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: selectedColor == index
                              ? Colors.black
                              : Colors.transparent,
                          width: 2),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Medicine Types
            const Text("Type", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: medicineTypes.map((type) {
                return Column(
                  children: [
                    const Icon(Icons.medical_information,
                        color: Color.fromARGB(255, 219, 120, 153), size: 40),
                    Text(type),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Quantity
            const Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("Take $totalCount Pill"),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(
                      () => totalCount = (totalCount > 1) ? totalCount - 1 : 1),
                  icon: const Icon(Icons.remove, color: Colors.blue),
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Adjust radius as needed
                      side: const BorderSide(
                          color: Colors.blue,
                          width: 1), // This adds the outline
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() =>
                      totalCount = (totalCount < 10) ? totalCount + 1 : 10),
                  icon: const Icon(Icons.add, color: Colors.white),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Total Count Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Count",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(_sliderValue.toString()),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Slider(
              max: 100,
              min: 1,
              value: _sliderValue,
              label: _sliderValue.toString(),
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
              activeColor: Colors.blue,
            ),

            // Set Date
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Set Date",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                          "Today                                     >")),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                          "End Date                              >")),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Frequency of Days
            const Text(
              "Frequency of Days",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField(
                value: selectedFrequency,
                items: frequencyOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => selectedFrequency = value!),
              ),
            ),
            const SizedBox(height: 16),

            // How Many Times a Day
            const Text("How many times a Day", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField(
                value: selectedTimesADay,
                items: timesPerDay
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => selectedTimesADay = value!),
              ),
            ),
            const SizedBox(height: 16),

            // Dose List
            SizedBox(
              height: 100,
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        const Icon(Icons.lock_clock),
                        const SizedBox(width: 5),
                        Text("Dose ${index + 1}",
                          style: const TextStyle(fontSize: 15),
                        ),
                        const Expanded(child: SizedBox()),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    );
                  }),
            ),

            // Before Food / After Food / Before Sleep
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                    label: const Text("Before Food"),
                    backgroundColor: Colors.blue.shade100),
                const Chip(label: Text("After Food")),
                const Chip(label: Text("Before Sleep")),
              ],
            ),
            const SizedBox(height: 16),

            // Add Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("Add",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
