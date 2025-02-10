import 'package:flutter/material.dart';

class MedicineDetails extends StatelessWidget {
  const MedicineDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Monday 8:00 am",
            style: TextStyle(
              fontSize: 25,
            ),
            )
            ),
            const SizedBox(height: 10,),
          _medicineDetails(Icons.water_drop,"Calpol 500 mg tablet","Before Breakfast","Day 01","Taken"),
          _medicineDetails(Icons.medical_information,"Calpol 500 mg tablet","Before Breakfast","Day 01","Missed"),
          const SizedBox(height: 10,),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Afternoon 02:00 pm",
            style: TextStyle(
              fontSize: 25,
            ),
            )
            ),
            const SizedBox(height: 10,),
          _medicineDetails(Icons.water_drop,"Calpol 500 mg tablet","After Food","Day 01","Snoozed"),
          const SizedBox(height: 10,),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Night 09:00 pm",
            style: TextStyle(
              fontSize: 25,
            ),
            )
            ),
            const SizedBox(height: 10,),
          _medicineDetails(Icons.medical_services,"Calpol 500 mg tablet","Before Sleep","Day 01","left"),
           _medicineDetails(Icons.medical_services,"Calpol 500 mg tablet","Before Sleep","Day 01","left"),
            _medicineDetails(Icons.medical_services,"Calpol 500 mg tablet","Before Sleep","Day 01","left"),
             _medicineDetails(Icons.medical_services,"Calpol 500 mg tablet","Before Sleep","Day 01","left"),
        ],
      ),
    );
  }
  Widget _medicineDetails(IconData icon,String mname,String time,String day,String status){
    return Column(
      children: [
        Container(
          padding:EdgeInsets.symmetric(horizontal: 18,vertical: 30), 
          decoration: const BoxDecoration(
            color:  Color.fromARGB(255, 224, 239, 247),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(icon,color: const Color.fromARGB(255, 114, 166, 204),
              size: 30,
              ),
              const SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mname,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  ),
                  Text("$time   $day")
                ],
              ),
              Expanded(child: SizedBox()),
              Column(
                children: [
                  Icon(Icons.notifications_none_outlined,
                  color: status == "Taken" ? Colors.green : Colors.red,
                  ),
                  Text(status),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 8,)
      ],
    );
  }
}