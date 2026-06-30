# AfriBook 🌍

**Plateforme mobile de contenus culturels africains**

Une application Flutter premium pour lire, écouter et explorer le patrimoine culturel africain.

## Stack technique

- **Flutter** (latest stable) + **Dart**
- **GetX** — State management, Navigation, DI
- **GetStorage + Hive** — Stockage local
- **just_audio + audio_service** — Lecteur audio background
- **video_player + chewie** — Lecteur vidéo
- **flutter_markdown** — Lecteur de texte enrichi
- **cached_network_image** — Cache d'images
- **flutter_screenutil** — Design responsive
- **google_fonts** — Typographie (Playfair Display + DM Sans)

## Architecture

```
lib/
├── main.dart
├── app/
│   ├── bindings/          # GetX Bindings
│   └── routes/            # AppPages + Routes
├── core/
│   └── theme/             # Design System complet
│       ├── app_colors.dart
│       ├── app_typography.dart
│       └── app_theme.dart
├── data/
│   ├── datasources/
│   │   └── local/         # Mock data (→ remplacer par API)
│   ├── models/            # Tous les modèles
│   └── repositories/      # Pattern Repository
├── domain/                # Entités + Use Cases
└── features/              # Feature-first architecture
    ├── auth/
    ├── splash/
    ├── onboarding/
    ├── home/
    ├── explore/
    ├── feed/
    ├── library/
    ├── profile/
    ├── settings/
    ├── detail/
    ├── search/
    ├── player/
    │   ├── audio/
    │   └── video/
    ├── reader/
    ├── map/
    ├── quiz/
    ├── community/
    ├── notifications/
    └── gamification/
```

## Installation

```bash
# 1. Installer les dépendances
flutter pub get

# 2. Générer le code Hive
flutter pub run build_runner build

# 3. Lancer l'app
flutter run
```

## Fonctionnalités implémentées

✅ Splash Screen animé  
✅ Onboarding avec swipe  
✅ Sélection de langue (12 langues africaines)  
✅ Sélection des centres d'intérêt  
✅ Authentification (Email, Google, Téléphone, OTP)  
✅ Accueil avec carrousel, sections dynamiques  
✅ Proverbe du jour  
✅ Explorer par région et catégorie  
✅ Feed (flux personnalisé)  
✅ Bibliothèque (favoris, téléchargements, historique)  
✅ Profil avec gamification (XP, niveaux, badges, séries)  
✅ Paramètres complets  
✅ Page de détail riche (onglets À propos / Contenu / Commentaires)  
✅ Lecteur Audio (waveform, sleep timer, vitesse, paroles synchronisées)  
✅ Lecteur Vidéo (Chewie, plein écran)  
✅ Lecteur Markdown (dark/light, police, taille)  
✅ Recherche instantanée avec filtres  
✅ Quiz de compréhension  
✅ Carte interactive de l'Afrique  
✅ Notifications  
✅ Design System africain complet (couleurs, typo, spacing, animations)  
✅ Données fictives riches (contenus, auteurs, quiz, proverbes)  

## Connexion API

Remplacez `lib/data/datasources/local/mock_data.dart` par des appels Dio :

```dart
// lib/data/datasources/remote/content_remote_source.dart
class ContentRemoteSource {
  final Dio _dio;
  
  Future<List<ContentModel>> getFeatured() async {
    final res = await _dio.get('/api/v1/contents/featured');
    return (res.data as List).map((e) => ContentModel.fromJson(e)).toList();
  }
}
```

## Design System

Palette inspirée de l'Afrique :
- **Or / Bronze** — Richesse Ashanti `#D4943A`
- **Vert forêt** — Forêt du Congo `#2D6A4F`
- **Terre rouge** — Ocre africaine `#C1440E`
- **Noir profond** — Nuit africaine `#0C0C0C`
- **Blanc cassé** — Sable du Sahara `#F5EFE6`
