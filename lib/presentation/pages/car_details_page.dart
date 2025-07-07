import 'package:flutter/material.dart';
import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/presentation/pages/maps_details_page.dart';
import 'package:rentapp/presentation/widgets/car_card.dart';
import 'package:rentapp/presentation/widgets/more_card.dart';

class CardDetailsPage extends StatefulWidget {
  final Car car;

  const CardDetailsPage({super.key, required this.car});

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CarCard(car: widget.car),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xffF3F3F3),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/user.png'),
                      ),
                      const SizedBox(height: 10),
                      Text('Jane Cooper',
                          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                      Text('\$4,253',
                          style: textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapsDetailsPage(car: widget.car)),
                    );
                  },
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) => Transform.scale(
                          scale: _animation.value,
                          alignment: Alignment.center,
                          child: child,
                        ),
                        child: Image.asset('assets/maps.png', fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(3, (index) {
            final extraDistance = (index + 1) * 100;
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: MoreCard(
                car: Car(
                  model: "${widget.car.model}-${index + 1}",
                  distance: widget.car.distance + extraDistance,
                  fuelCapacity: widget.car.fuelCapacity + extraDistance,
                  pricePerHour: widget.car.pricePerHour + (index + 1) * 10, imageURL: '',
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
