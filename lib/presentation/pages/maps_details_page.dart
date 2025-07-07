import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentapp/data/models/car.dart';

class MapsDetailsPage extends StatefulWidget {
  final Car car;

  const MapsDetailsPage({super.key, required this.car});

  @override
  State<MapsDetailsPage> createState() => _MapsDetailsPageState();
}

class _MapsDetailsPageState extends State<MapsDetailsPage> {
  final popupController = PopupController();

  late final List<Marker> markers;

  @override
  void initState() {
    super.initState();
    markers = [
      Marker(
        point: LatLng(1.8656, 103.0832),
        width: 40,
        height: 40,
        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
      Marker(
        point: LatLng(1.8544, 102.9325),
        width: 40,
        height: 40,
        child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Example')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(1.8656, 103.0832),
          initialZoom: 11,
          onTap: (_, __) => popupController.hideAllPopups(),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          PopupMarkerLayer(
            options: PopupMarkerLayerOptions(
              markers: markers,
              popupController: popupController,
              markerTapBehavior: MarkerTapBehavior.togglePopup(),
              popupDisplayOptions: PopupDisplayOptions(
                builder: (BuildContext context, Marker marker) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Car Model: ${widget.car.model}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Price: RM${widget.car.pricePerHour}/day'),
                          Text('Distance: ${widget.car.distance} km'),
                          Text('Fuel: ${widget.car.fuelCapacity} L'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

