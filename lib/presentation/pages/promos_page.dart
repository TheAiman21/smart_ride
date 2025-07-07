import 'package:flutter/material.dart';

class PromosPage extends StatelessWidget {
  const PromosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Exclusive Promos Coming Soon!',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
