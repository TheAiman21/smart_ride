import 'package:flutter/material.dart';
import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/presentation/pages/car_details_page.dart';

class CarCard extends StatelessWidget {
  final Car car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailsPage(car: car),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xffF3F3F3),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 5,
            )
          ],
        ),
        child: Column(
          children: [
            // ✅ Use image from Firebase URL
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                car.imageURL,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 120,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 120,
                    child: Center(child: Icon(Icons.error)),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            Text(
              car.model,
              style: theme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/gps.png'),
                    Text(
                      ' ${car.distance.toStringAsFixed(0)}km',
                      style: theme.bodyMedium,
                    ),
                    const SizedBox(width: 8),
                    Image.asset('assets/pump.png'),
                    Text(
                      ' ${car.fuelCapacity.toStringAsFixed(0)}L',
                      style: theme.bodyMedium,
                    ),
                  ],
                ),
                Text(
                  'RM${car.pricePerHour.toStringAsFixed(2)}/h',
                  style: theme.bodyLarge,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

