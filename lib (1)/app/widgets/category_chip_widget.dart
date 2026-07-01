import 'package:flutter/material.dart';
import '../data/models/category_model.dart';
import '../../../lib/app/theme/theme/app_colors.dart';

class CategoryChipWidget extends StatelessWidget {
  final CategoryModel category;
  final bool selected;
  final VoidCallback? onTap;

  const CategoryChipWidget({
    super.key,
    required this.category,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.avatarFor(category.colorIndex);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: selected
              ? LinearGradient(colors: [color, color.withValues(alpha: 0.65)])
              : null,
          color: selected ? null : Theme.of(context).cardColor,
          border: Border.all(
            color: selected ? color : color.withValues(alpha: 0.35),
            width: 1.3,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              category.icon,
              size: 20,
              color: selected ? Colors.white : color,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                category.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: selected
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle_rounded,
                size: 16,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
