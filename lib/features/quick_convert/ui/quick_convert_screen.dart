import 'package:flutter/material.dart';
import '../logic/quick_convert_logic.dart';
import 'quick_convert_form.dart';
import 'quick_convert_results.dart';

class QuickConvertScreen extends StatefulWidget {
  const QuickConvertScreen({super.key});

  @override
  State<QuickConvertScreen> createState() => _QuickConvertScreenState();
}

class _QuickConvertScreenState extends State<QuickConvertScreen> {
  final _logic = QuickConvertLogic();
  final _scrollController = ScrollController();
  ConversionResult _conversionResult = ConversionResult(
    results: [],
    equivalents: [],
    weightConversions: [],
  );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onCalculate({
    required double? quantity,
    required String? unit,
    required String? ingredient,
    required double? multiplier,
  }) {
    final result = _logic.calculate(
      quantity: quantity,
      unit: unit,
      multiplier: multiplier,
      ingredient: ingredient,
    );

    setState(() {
      _conversionResult = result;
    });

    // After the UI has rebuilt, scroll to the top of the results.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Quick Convert',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        QuickConvertForm(onCalculate: _onCalculate),
        if (_conversionResult.results.isNotEmpty ||
            _conversionResult.equivalents.isNotEmpty ||
            _conversionResult.weightConversions.isNotEmpty) ...[
          const SizedBox(height: 24.0),
          const Divider(),
          const SizedBox(height: 16.0),
          QuickConvertResults(
            conversionResult: _conversionResult,
            scrollController: _scrollController,
          ),
        ],
      ],
    );
  }
}
