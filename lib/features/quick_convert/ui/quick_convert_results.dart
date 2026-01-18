import 'package:flutter/material.dart';
import '../logic/quick_convert_logic.dart';

class QuickConvertResults extends StatelessWidget {
  final ConversionResult conversionResult;
  final ScrollController scrollController;

  const QuickConvertResults({
    super.key,
    required this.conversionResult,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (conversionResult.results.isEmpty &&
        conversionResult.equivalents.isEmpty) {
      return const SizedBox.shrink(); // Return an empty widget if there are no results
    }

    return Expanded(
      child: ListView(
        controller: scrollController,
        children: [
          if (conversionResult.results.isNotEmpty) ...[
            Text(
              'Volume Results',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            ...conversionResult.results.map(
              (result) => ListTile(
                leading: const Icon(Icons.chevron_right),
                title: Text(result),
              ),
            ),
          ],
          if (conversionResult.equivalents.isNotEmpty) ...[
            const SizedBox(height: 16.0),
            Text(
              'Equivalent Measures',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            ...conversionResult.equivalents.map(
              (result) => ListTile(
                leading: const Icon(Icons.chevron_right),
                title: Text(result),
              ),
            ),
          ],
          if (conversionResult.weightConversions.isNotEmpty) ...[
            const SizedBox(height: 16.0),
            Text(
              'Weight Conversions',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            ...conversionResult.weightConversions.map(
              (result) => ListTile(
                leading: const Icon(Icons.scale),
                title: Text(result),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
