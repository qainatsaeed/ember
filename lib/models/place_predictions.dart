class PlacePrediction {
  PlacePrediction({
    required this.description,
    required this.distance,

    /// Additional context for the place (optional)
    this.secondaryText,
  });

  /// Factory to create an instance from JSON
  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    // Convert distance_meters to a formatted string
    final distanceMeters = json['distance_meters'] as int?;
    final distanceFormatted = distanceMeters == null
        ? ''
        : distanceMeters >= 1000
            ? '${(distanceMeters / 1000).toStringAsFixed(1)} km'
            : '$distanceMeters m';

    // Extract secondary_text if available
    final structuredFormatting = json['structured_formatting'] as Map<String, dynamic>?;
    final secondaryText = structuredFormatting?['secondary_text'] as String?;

    return PlacePrediction(
      description: json['description'] as String,
      distance: distanceFormatted,
      secondaryText: secondaryText,
    );
  }

  final String description; // Main name or description of the place
  final String distance; // Formatted distance in km or m
  final String? secondaryText;

  /// Factory to create a list of PlacePrediction from JSON
  static List<PlacePrediction> fromJsonList(Map<String, dynamic> json) {
    if (json['predictions'] == null) return [];
    final predictions = json['predictions'] as List;
    return predictions.map((p) => PlacePrediction.fromJson(p as Map<String, dynamic>)).toList();
  }
}
