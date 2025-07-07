import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PromosPage extends StatefulWidget {
  const PromosPage({super.key});

  @override
  State<PromosPage> createState() => _PromosPageState();
}

class _PromosPageState extends State<PromosPage> {
  final TextEditingController _promoController = TextEditingController();
  String _message = '';
  bool _isLoading = false;

  Future<void> applyPromoCode() async {
    final String code = _promoController.text.trim().toUpperCase();
    if (code.isEmpty) return;

    setState(() {
      _isLoading = true;
      _message = '';
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _message = 'User not logged in';
        _isLoading = false;
      });
      return;
    }

    final uid = user.uid;
    final promoDoc = await FirebaseFirestore.instance
        .collection('promo_codes')
        .doc(code)
        .get();

    if (!promoDoc.exists) {
      setState(() {
        _message = 'Promo code not found.';
        _isLoading = false;
      });
      return;
    }

    // Check if already redeemed
    final redeemed = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('redeemed_promos')
        .doc(code)
        .get();

    if (redeemed.exists) {
      setState(() {
        _message = 'You have already redeemed this promo.';
        _isLoading = false;
      });
      return;
    }

    final data = promoDoc.data()!;
    final discountAmount = data['discountAmount'] ?? 0;
    final carModel = data['carModel'] ?? 'ANY';

    // You can implement new user check here
    // For example, if user creation date < 7 days ago
    // But let's skip for simplicity

    // All checks passed, save redemption
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('redeemed_promos')
        .doc(code)
        .set({
      'code': code,
      'timestamp': FieldValue.serverTimestamp(),
      'discount': discountAmount,
    });

    setState(() {
      _message =
          'Promo applied: RM$discountAmount off for $carModel bookings!';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apply Promo Code"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Enter your promo code below:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _promoController,
              decoration: const InputDecoration(
                hintText: 'PROMOCODE',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : applyPromoCode,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Apply"),
            ),
            const SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(
                color: _message.contains("applied") ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
