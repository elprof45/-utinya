import 'dart:ui';

import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key, required this.card, required this.isActive});

  final HeroCardData card;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final buttonWidthFactor = card.buttonWidthFactor.clamp(0.0, 1.0);

    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: AspectRatio(
          aspectRatio: card.aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(card.borderRadius),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  card.backgroundImage,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const ColoredBox(
                    color: Colors.black12,
                    child: Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: card.backgroundTint.withValues(
                    alpha: card.overlayOpacity,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.10),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.28),
                        Colors.black.withValues(alpha: 0.58),
                      ],
                      stops: const [0.0, 0.28, 0.70, 1.0],
                    ),
                  ),
                ),
                Padding(
                  padding: card.contentPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Chip(
                        label: card.chip,
                        color: card.chipColor,
                        padding: card.chipPadding,
                        fontSize: card.chipFontSize,
                      ),
                      SizedBox(height: card.chipToTitleSpacing),
                      Text(
                        card.title,
                        maxLines: card.titleMaxLines,
                        overflow: TextOverflow.ellipsis,
                        style:
                            card.titleStyle ??
                            const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.7,
                              height: 1.05,
                              color: Colors.white,
                            ),
                      ),
                      // const SizedBox(height: 12),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: card.descriptionBottomSpacing,
                          ),
                          child: Align(
                            alignment: card.descriptionAlignment,
                            child: Text(
                              card.description,
                              maxLines: card.descriptionMaxLines,
                              overflow: TextOverflow.ellipsis,
                              textAlign: card.descriptionTextAlign,
                              style:
                                  card.descriptionStyle ??
                                  TextStyle(
                                    fontSize: 18,
                                    height: 1.18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withValues(alpha: 0.95),
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: buttonWidthFactor,
                          child: _GradientButton(
                            label: card.buttonText,
                            onTap: card.onButtonTap,
                            icon: card.buttonIcon,
                            height: card.buttonHeight,
                            borderRadius: card.buttonBorderRadius,
                            gradient: card.buttonGradient,
                            padding: card.buttonPadding,
                            iconSize: card.buttonIconSize,
                            iconSpacing: card.buttonIconSpacing,
                            textStyle: card.buttonTextStyle,
                            minWidth: card.buttonMinWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
    this.fontSize = 13,
  });

  final String label;
  final Color color;
  final EdgeInsets padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.34),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.label,
    this.onTap,
    this.icon = Icons.play_arrow_rounded,
    this.height = 78,
    this.borderRadius = 18,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF2E98F4), Color(0xFFB33ACF)],
    ),
    this.padding = const EdgeInsets.symmetric(horizontal: 18),
    this.iconSize = 28,
    this.iconSpacing = 12,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
    ),
    this.minWidth = 0,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData icon;
  final double height;
  final double borderRadius;
  final Gradient gradient;
  final EdgeInsets padding;
  final double iconSize;
  final double iconSpacing;
  final TextStyle textStyle;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Ink(
            height: height,
            decoration: BoxDecoration(gradient: gradient, borderRadius: radius),
            child: Padding(
              padding: padding,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: iconSize, color: Colors.white),
                      SizedBox(width: iconSpacing),
                      Text(
                        label,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroCardData {
  const HeroCardData({
    required this.chip,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonWidthFactor,
    required this.backgroundImage,
    required this.backgroundTint,
    required this.chipColor,
    required this.overlayOpacity,
    this.onButtonTap,
    this.buttonIcon = Icons.play_arrow_rounded,
    this.buttonHeight = 78,
    this.buttonBorderRadius = 18,
    this.buttonGradient = const LinearGradient(
      colors: [Color(0xFF2E98F4), Color(0xFFB33ACF)],
    ),
    this.buttonPadding = const EdgeInsets.symmetric(horizontal: 18),
    this.buttonIconSize = 28,
    this.buttonIconSpacing = 12,
    this.buttonTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
    ),
    this.buttonMinWidth = 0,
    this.chipPadding = const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
    this.chipFontSize = 13,
    this.titleMaxLines = 1,
    this.descriptionMaxLines = 6,
    this.descriptionBottomSpacing = 18,
    this.titleStyle,
    this.descriptionStyle,
    this.aspectRatio = 0.82,
    this.borderRadius = 20,
    this.contentPadding = const EdgeInsets.fromLTRB(20, 24, 20, 18),
    this.chipToTitleSpacing = 28,
    this.descriptionAlignment = Alignment.center,
    this.descriptionTextAlign = TextAlign.center,
  });

  final String chip;
  final String title;
  final String description;
  final String buttonText;
  final double buttonWidthFactor;
  final String backgroundImage;
  final Color backgroundTint;
  final Color chipColor;
  final double overlayOpacity;

  final VoidCallback? onButtonTap;

  final IconData buttonIcon;
  final double buttonHeight;
  final double buttonBorderRadius;
  final Gradient buttonGradient;
  final EdgeInsets buttonPadding;
  final double buttonIconSize;
  final double buttonIconSpacing;
  final TextStyle buttonTextStyle;
  final double buttonMinWidth;

  final EdgeInsets chipPadding;
  final double chipFontSize;

  final int titleMaxLines;
  final int descriptionMaxLines;
  final double descriptionBottomSpacing;

  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  final double aspectRatio;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final double chipToTitleSpacing;
  final Alignment descriptionAlignment;
  final TextAlign descriptionTextAlign;
}
