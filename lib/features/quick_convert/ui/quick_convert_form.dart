import 'package:flutter/material.dart';

class QuickConvertForm extends StatefulWidget {
  final Function({
    required double? quantity,
    required String? unit,
    required String? ingredient,
    required double? multiplier,
  })
  onCalculate;

  const QuickConvertForm({super.key, required this.onCalculate});

  @override
  State<QuickConvertForm> createState() => _QuickConvertFormState();
}

class _QuickConvertFormState extends State<QuickConvertForm> {
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _multiplierController = TextEditingController();
  final _ingredientController = TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    _unitController.dispose();
    _multiplierController.dispose();
    _ingredientController.dispose();
    super.dispose();
  }

  double? _parseMultiplier(String text) {
    if (text.isEmpty) return null;
    if (text.contains('/')) {
      final parts = text.split('/');
      if (parts.length == 2) {
        final double? numerator = double.tryParse(parts[0].trim());
        final double? denominator = double.tryParse(parts[1].trim());
        if (numerator != null && denominator != null && denominator != 0) {
          return numerator / denominator;
        }
      }
      return null; // Invalid fraction format
    } else {
      return double.tryParse(text);
    }
  }

  void _triggerCalculate() {
    widget.onCalculate(
      quantity: double.tryParse(_quantityController.text),
      unit: _unitController.text,
      ingredient: _ingredientController.text,
      multiplier: _parseMultiplier(_multiplierController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextFormField(
                controller: _unitController,
                decoration: const InputDecoration(
                  labelText: 'Unit',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _ingredientController,
          decoration: const InputDecoration(
            labelText: 'Ingredient (optional)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _multiplierController,
          decoration: const InputDecoration(
            labelText: 'Multiplier (e.g., 2 or 0.5)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: _triggerCalculate,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text('Calculate'),
        ),
      ],
    );
  }
}
