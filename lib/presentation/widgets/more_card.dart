import 'package:flutter/material.dart';
import 'package:rentapp/data/models/car.dart';

class MoreCard extends StatelessWidget {
  final Car car;

  const MoreCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xff212020),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 8,
                offset: Offset(0, 4)
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                car.model,
                style: theme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Icon(Icons.directions_car, color: Colors.white, size: 16,),
                  const SizedBox(width: 5,),
                  Text(
                    '> ${car.distance} km',
                    style: theme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(width: 10,),
                  const Icon(Icons.battery_full, color: Colors.white, size: 16,),
                  const SizedBox(width: 5,),
                  Text(
                    car.fuelCapacity.toString(),
                    style: theme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ],
              )
            ],
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 24,)
        ],
      ),
    );
  }
}
