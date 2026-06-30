// lib/features/home/widgets/_build_shimmer.dart
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BuildShimmer extends StatelessWidget {
  const BuildShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceDark2,
      highlightColor: AppColors.surfaceDark3,
      child: SingleChildScrollView(
        physics:
            const NeverScrollableScrollPhysics(), // Bloque le scroll pendant le chargement
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100.h),
            // Bannière de proverbe Shimmer
            Padding(
              padding: EdgeInsets.all(AppSpacing.base),
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.baseAll,
                ),
              ),
            ),
            // Liste des sections Shimmer
            ...List.generate(
              3,
              (_) => Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre de la section
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.base,
                      ),
                      child: Container(
                        height: 20.h,
                        width: 180.w,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // CORRECTION : Remplacement de Row par une ListView horizontale fixe
                    SizedBox(
                      height: 180.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics:
                            const NeverScrollableScrollPhysics(), // Évite les frictions de scroll
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.base,
                        ),
                        itemCount: 3,
                        itemBuilder: (_, _) => Padding(
                          padding: EdgeInsets.only(right: AppSpacing.sm),
                          child: Container(
                            width: 120.w,
                            height: 180.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AppRadius
                                  .mdAll, // Aligné sur vos vraies cartes portrait
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
