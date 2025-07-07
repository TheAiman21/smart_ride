import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  DateTimeRange? selectedDateRange;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? selectedCarModel;

  final List<String> carModels = [
    'Perodua Axia',
    'Perodua Bezza',
    'Perodua Myvi',
    'Perodua Alza',
    'Perodua Aruz',
    'Proton Iriz',
    'Proton Saga',
    'Proton Persona',
    'Proton Exora',
    'Toyota Yaris',
    'Toyota Vios',
  ];

  Future<void> pickDateRange() async {
    final DateTime now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  Future<void> pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo animation
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/smartride_logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header text
          const Text(
            "Welcome to Smart Ride",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // Subheading text
          const Text(
            "Begin your journey with us",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),

          // Date picker
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            onPressed: pickDateRange,
            child: Text(selectedDateRange == null
                ? "Select Rental Dates"
                : "From: ${DateFormat('dd MMM').format(selectedDateRange!.start)} "
                  "- To: ${DateFormat('dd MMM').format(selectedDateRange!.end)}"),
          ),
          const SizedBox(height: 15),

          // Time pickers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () => pickTime(isStart: true),
                child: Text(startTime == null
                    ? "Start Time"
                    : "Start: ${startTime!.format(context)}"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () => pickTime(isStart: false),
                child: Text(endTime == null
                    ? "End Time"
                    : "End: ${endTime!.format(context)}"),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Car model dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<String>(
              hint: const Text("Select Car Model"),
              value: selectedCarModel,
              isExpanded: true,
              dropdownColor: Colors.white,
              items: carModels.map((model) {
                return DropdownMenuItem(
                  value: model,
                  child: Text(model),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCarModel = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
