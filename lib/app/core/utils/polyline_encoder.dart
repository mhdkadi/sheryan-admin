import 'dart:convert' show ascii;
import 'dart:math' as math show pow;

String encodePoint(num current, {num previous = 0, int accuracyExponent = 5}) {
  assert(() {
    if (accuracyExponent < 1) {
      throw ArgumentError.value(accuracyExponent, 'accuracyExponent',
          'Location accuracy exponent cannot be less than 1');
    }

    if (accuracyExponent > 9) {
      throw ArgumentError.value(
        accuracyExponent,
        'accuracyExponent',
      );
    }

    return true;
  }());

  final accuracyMultiplier = math.pow(10, accuracyExponent);

  final int curr = (current * accuracyMultiplier + 0.5).floor();
  final int prev = (previous * accuracyMultiplier + 0.5).floor();
  int value = curr - prev;

  /// Left-shift the `value` for one bit.
  value <<= 1;
  if (curr - prev < 0) {
    /// Inverting `value` if it is negative.
    value = ~value;
  }

  String point = '';

  /// Iterating while value is grater or equal of `32-bits` size
  while (value >= 0x20) {
    /// `AND` each `value` with `0x1f` to get 5-bit chunks.
    /// Then `OR` each `value` with `0x20` as per algorithm.
    /// Then add `63` to each `value` as per algorithm.
    point += String.fromCharCodes([(0x20 | (value & 0x1f)) + 63]);

    /// Rigth-shift the `value` for 5 bits
    value >>= 5;
  }

  point += ascii.decode([value + 63]);

  return point;
}

/// Encodes `List<List<num>>` of [coordinates] into a `String` via
/// [Encoded Polyline Algorithm Format](https://developers.google.com/maps/documentation/utilities/polylinealgorithm?hl=en)
///
/// For mode detailed info about encoding refer to [encodePoint].
String encodePolyline(List<List<num>> coordinates, {int accuracyExponent = 5}) {
  assert(() {
    if (accuracyExponent < 1) {
      throw ArgumentError.value(accuracyExponent, 'accuracyExponent',
          'Location accuracy exponent cannot be less than 1');
    }

    if (accuracyExponent > 9) {
      throw ArgumentError.value(
        accuracyExponent,
        'accuracyExponent',
      );
    }

    return true;
  }());

  if (coordinates.isEmpty) return '';

  String polyline =
      encodePoint(coordinates[0][0], accuracyExponent: accuracyExponent) +
          encodePoint(coordinates[0][1], accuracyExponent: accuracyExponent);

  for (var i = 1; i < coordinates.length; i++) {
    polyline += encodePoint(coordinates[i][0],
        previous: coordinates[i - 1][0], accuracyExponent: accuracyExponent);
    polyline += encodePoint(coordinates[i][1],
        previous: coordinates[i - 1][1], accuracyExponent: accuracyExponent);
  }

  return polyline;
}

/// Decodes [polyline] `String` via inverted
/// [Encoded Polyline Algorithm](https://developers.google.com/maps/documentation/utilities/polylinealgorithm?hl=en)
List<List<num>> decodePolyline(String polyline, {int accuracyExponent = 5}) {
  final accuracyMultiplier = math.pow(10, accuracyExponent);
  final List<List<num>> coordinates = [];

  int index = 0;
  int lat = 0;
  int lng = 0;

  while (index < polyline.length) {
    int char;
    int shift = 0;
    int result = 0;

    /// Method for getting **only** `1` coorditane `latitude` or `longitude` at a time
    int getCoordinate() {
      /// Iterating while value is grater or equal of `32-bits` size
      do {
        /// Substract `63` from `codeUnit`.
        char = polyline.codeUnitAt(index++) - 63;

        /// `AND` each `char` with `0x1f` to get 5-bit chunks.
        /// Then `OR` each `char` with `result`.
        /// Then left-shift for `shift` bits
        result |= (char & 0x1f) << shift;
        shift += 5;
      } while (char >= 0x20);

      /// Inversion of both:
      ///
      ///  * Left-shift the `value` for one bit
      ///  * Inversion `value` if it is negative
      final value = result >> 1;
      final coordinateChange =
          (result & 1) != 0 ? (~BigInt.from(value)).toInt() : value;

      /// It is needed to clear `shift` and `result` for next coordinate.
      shift = result = 0;

      return coordinateChange;
    }

    lat += getCoordinate();
    lng += getCoordinate();

    coordinates.add([lat / accuracyMultiplier, lng / accuracyMultiplier]);
  }

  return coordinates;
}
