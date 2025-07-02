import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<String> colors;
  final int selectedIndex;
  final Function(int) onSelected;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getColorFromString(colors[index]),
                borderRadius: BorderRadius.circular(25),
                border: selectedIndex == index
                    ? Border.all(color: AppColors.primary, width: 3)
                    : null,
              ),
              child: selectedIndex == index
                  ? const Icon(Icons.check, color: Colors.white)
                  : null,
            ),
          );
        },
      ),
    );
  }

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'rojo':
        return Colors.red;
      case 'azul':
        return Colors.blue;
      case 'verde':
        return Colors.green;
      case 'negro':
        return Colors.black;
      case 'blanco':
        return Colors.white;
      case 'amarillo':
        return Colors.yellow;
      case 'morado':
        return Colors.purple;
      case 'rosa':
        return Colors.pink;
      case 'naranja':
        return Colors.orange;
      case 'gris':
        return Colors.grey;
      default:
        return Colors.grey; // Color por defecto
    }
  }
}