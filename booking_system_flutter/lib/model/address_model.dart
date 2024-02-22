class Address {
  final double latitude;
  final double longitude;
  final String name;

  Address(
      {required this.latitude, required this.longitude, required this.name});

  @override
  String toString() {
    return 'Address(Name: $name, Latitude: $latitude, Longitude: $longitude)';
  }

  Address copyWith({
    double? latitude,
    double? longitude,
    String? name,
  }) {
    return Address(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
    );
  }
}
