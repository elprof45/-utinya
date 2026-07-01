import 'package:egliloo/app/theme/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AvatarPlaceholder extends StatelessWidget {
  final int colorIndex;
  final double size;
  final String? initials;
  final IconData icon;

  const AvatarPlaceholder({
    super.key,
    required this.colorIndex,
    this.size = 44,
    this.initials,
    this.icon = Icons.person_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.avatarFor(colorIndex);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.6),
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: initials != null
          ? Text(
              initials!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size * 0.36,
              ),
            )
          : Icon(icon, color: Colors.white, size: size * 0.5),
    );
  }
}
