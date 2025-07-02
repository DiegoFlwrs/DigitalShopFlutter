import 'package:flutter/material.dart';

class VariantSelector extends StatelessWidget {
  final String? selectedValue;
  final List<String> options;
  final String label;
  final Function(String?) onChanged;
  final bool isLoading;

  const VariantSelector({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.label,
    required this.onChanged,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        isLoading && options.isEmpty
            ? const CircularProgressIndicator()
            : DropdownButtonFormField<String>(
                value: selectedValue,
                items: options.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onChanged,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
      ],
    );
  }
}