import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:egliloo/app/theme/app_colors.dart';

class SafeNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final int cacheSize; // Taille max en pixels pour préserver la RAM
  final Widget Function(BuildContext, ImageProvider)? imageBuilder;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, Object)? errorWidget;

  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.cacheSize = 400, // Sécurité ANR par défaut
    this.imageBuilder,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Règle 5 : Gestion des URLs vides, corrompues ou nulles
    if (imageUrl == null ||
        imageUrl!.trim().isEmpty ||
        !imageUrl!.startsWith('http')) {
      return _buildFallbackError(context, 'URL Invalide');
    }

    // ✅ Règle 2 & 4 : Protection globale contre les erreurs d'exécution internes
    try {
      return CachedNetworkImage(
        imageUrl: imageUrl!.trim(),
        width: width,
        height: height,
        fit: fit,
        // ✅ Règle 6 & Sécurité ANR : Bridage de la RAM pour éviter le gel du téléphone
        maxHeightDiskCache: cacheSize,
        maxWidthDiskCache: cacheSize,
        memCacheHeight: cacheSize,
        memCacheWidth: cacheSize,

        // ✅ Règle 4 : Sécurisation du constructeur d'image personnalisé
        imageBuilder: (context, imageProvider) {
          try {
            if (imageBuilder != null) {
              return imageBuilder!(context, imageProvider);
            }
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: fit),
              ),
            );
          } catch (e, stack) {
            _reportSilentError('Erreur imageBuilder', e, stack);
            return _buildFallbackError(context, e);
          }
        },

        // ✅ Règle 4 : Sécurisation du composant d'attente (Placeholder)
        placeholder: (context, url) {
          try {
            if (placeholder != null) return placeholder!(context, url);
            return Container(
              color: AppColors.surfaceDark2,
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                ),
              ),
            );
          } catch (e, stack) {
            _reportSilentError('Erreur placeholder', e, stack);
            return Container(color: AppColors.surfaceDark2);
          }
        },

        // ✅ Règle 1, 3 & 6 : Capture des exceptions de décodage, 404 et pannes de serveurs
        errorWidget: (context, url, error) {
          _reportSilentError(
            'Erreur de chargement d\'image (ex: 404)',
            error,
            StackTrace.current,
          );

          if (errorWidget != null) {
            try {
              return errorWidget!(context, url, error);
            } catch (e, stack) {
              _reportSilentError(
                'Erreur dans l\'errorWidget personnalisé',
                e,
                stack,
              );
            }
          }
          return _buildFallbackError(context, error);
        },
      );
    } catch (criticalError, stackTrace) {
      // Sécurité ultime si CachedNetworkImage venait à s'effondrer nativement
      _reportSilentError(
        'Crash critique CachedNetworkImage',
        criticalError,
        stackTrace,
      );
      return _buildFallbackError(context, criticalError);
    }
  }

  // ✅ Règle 3 : Interface graphique de secours standardisée
  Widget _buildFallbackError(BuildContext context, Object error) {
    return Container(
      width: width,
      height: height,
      color: AppColors.surfaceDark2,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_rounded,
          color: AppColors.textTertiaryDark,
          size: 24,
        ),
      ),
    );
  }

  // ✅ Règle 7 : Envoi de l'anomalie au framework Flutter au lieu de faire planter la machine
  void _reportSilentError(String context, Object error, StackTrace stack) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: Exception('[$context] -> $error'),
        stack: stack,
        library: 'SafeNetworkImage',
        context: ErrorDescription('Chargement d\'image asynchrone'),
      ),
    );
  }
}
