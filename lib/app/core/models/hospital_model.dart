import 'package:google_maps_flutter/google_maps_flutter.dart';

class Hospital {
  final String id;
  final String name;
  final String address;
  final String type;
  final LatLng location;

  Hospital({
    required this.id,
    required this.name,
    required this.address,
    required this.type,
    required this.location,
  });

  factory Hospital.fromMap(Map<String, dynamic> json) => Hospital(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        type: json["type"],
        location: LatLng(
          json["location"]["lat"]?.toDouble(),
          json["location"]["lng"]?.toDouble(),
        ),
      );
  static List<Hospital> hospitals(List data) =>
      data.map((e) => Hospital.fromMap(e)).toList();
}
