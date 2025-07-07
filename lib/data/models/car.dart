class Car {
  final String model;
  final double distance;
  final double fuelCapacity;
  final double pricePerHour;
  final String imageURL; // ✅ New field for Firebase image link

  Car({
    required this.model,
    required this.distance,
    required this.fuelCapacity,
    required this.pricePerHour,
    required this.imageURL,
  });

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      model: map['model'],
      distance: (map['distance'] as num).toDouble(),
      fuelCapacity: (map['fuelCapacity'] as num).toDouble(),
      pricePerHour: (map['pricePerHour'] as num).toDouble(),
      imageURL: map['imageURL'], // ✅ Read image URL from Firestore
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'distance': distance,
      'fuelCapacity': fuelCapacity,
      'pricePerHour': pricePerHour,
      'imageURL': imageURL,
    };
  }
}
