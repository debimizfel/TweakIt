import 'package:fraction/fraction.dart';

class ConversionResult {
  final List<String> results;
  final List<String> equivalents;
  final List<String> weightConversions;
  ConversionResult({
    required this.results,
    required this.equivalents,
    required this.weightConversions,
  });
}

class QuickConvertLogic {
  static final Map<String, double> _ingredientDensities = {
    'water': 236.0,
    'milk': 244.0,
    'butter': 227.0,
    'oil': 224.0,
    'all-purpose flour': 120.0,
    'flour': 120.0,
    'bread flour': 136.0,
    'cake flour': 114.0,
    'granulated sugar': 200.0,
    'sugar': 200.0,
    'brown sugar': 220.0,
    'powdered sugar': 120.0,
    'honey': 340.0,
    'cocoa powder': 100.0,
  };
  String _getDisplayUnit(String unit) {
    if (unit.contains('teaspoon') || unit.contains('tsp')) return 'teaspoons';
    if (unit.contains('tablespoon') || unit.contains('tbsp'))
      return 'tablespoons';
    if (unit.contains('cup')) return 'cups';
    return unit;
  }

  ConversionResult calculate({
    required double? quantity,
    required String? unit,
    required double? multiplier,
    required String? ingredient,
  }) {
    if (quantity == null ||
        multiplier == null ||
        unit == null ||
        unit.isEmpty) {
      return ConversionResult(
        results: [],
        equivalents: [],
        weightConversions: [],
      );
    }

    final String normalizedUnit = unit.trim().toLowerCase();
    final String displayUnit = _getDisplayUnit(normalizedUnit);
    final double resultValue = quantity * multiplier;
    final List<String> newResults = [];
    final List<String> newEquivalents = [];
    final List<String> newWeightConversions = [];

    // 1. Standard decimal result
    newResults.add('${resultValue.toStringAsFixed(2)} $displayUnit');

    // 2. Fractional result
    final fraction = resultValue.toFraction();
    newResults.add('${fraction.toString()} $displayUnit');

    // 3. Conversion to milliliters (for common units)
    final double? mlValue = _convertToMl(resultValue, normalizedUnit);
    if (mlValue != null) {
      newResults.add('${mlValue.toStringAsFixed(2)} ml');
    }

    // 4. Get equivalent measures
    newEquivalents.addAll(_getEquivalentMeasures(resultValue, normalizedUnit));

    // 5. Get weight conversions
    if (ingredient != null && ingredient.isNotEmpty) {
      newWeightConversions.addAll(
        _getWeightConversions(
          resultValue,
          normalizedUnit,
          ingredient.trim().toLowerCase(),
        ),
      );
    }

    return ConversionResult(
      results: newResults,
      equivalents: newEquivalents,
      weightConversions: newWeightConversions,
    );
  }

  List<String> _getWeightConversions(
    double value,
    String unit,
    String ingredient,
  ) {
    final density = _ingredientDensities[ingredient];
    final mlValue = _convertToMl(value, unit);

    if (density == null || mlValue == null) {
      return [];
    }

    const mlPerCup = 236.59;
    final grams = (mlValue / mlPerCup) * density;
    final ounces = grams * 0.035274;

    return [
      '${grams.toStringAsFixed(1)} grams',
      '${ounces.toStringAsFixed(1)} ounces',
    ];
  }

  List<String> _getEquivalentMeasures(double value, String unit) {
    final double? mlValue = _convertToMl(value, unit);
    if (mlValue == null) return [];

    final List<String> equivalents = [];
    const cupToMl = 236.59;
    const tbspToMl = 14.79;
    const tspToMl = 4.93;

    if (!unit.contains('cup')) {
      final cups = mlValue / cupToMl;
      equivalents.add('${cups.toStringAsFixed(2)} cups');
    }
    if (!unit.contains('tablespoon') && !unit.contains('tbsp')) {
      final tbsp = mlValue / tbspToMl;
      equivalents.add('${tbsp.toStringAsFixed(2)} tablespoons');
    }
    if (!unit.contains('teaspoon') && !unit.contains('tsp')) {
      final tsp = mlValue / tspToMl;
      equivalents.add('${tsp.toStringAsFixed(2)} teaspoons');
    }

    return equivalents;
  }

  double? _convertToMl(double value, String unit) {
    const cupToMl = 236.59;
    const tbspToMl = 14.79;
    const tspToMl = 4.93;

    if (unit.contains('cup')) {
      return value * cupToMl;
    } else if (unit.contains('tablespoon') || unit.contains('tbsp')) {
      return value * tbspToMl;
    } else if (unit.contains('teaspoon') || unit.contains('tsp')) {
      return value * tspToMl;
    }
    return null;
  }
}
