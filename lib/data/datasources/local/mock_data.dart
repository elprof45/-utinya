import 'package:egliloo/data/models/author_model.dart';
import 'package:egliloo/data/models/category_model.dart';
import 'package:egliloo/data/models/content_model.dart';
import 'package:egliloo/data/models/quiz_model.dart';

abstract class MockData {
  // ─── AUTHORS ──────────────────────────────────────────────────────────────
  static final List<AuthorModel> authors = [
    AuthorModel(
      id: 'auth_001',
      name: 'Aminata Kouyaté',
      avatar:
          'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=400',
      bio:
          'Griotte et conteuse malienne. Gardienne des traditions orales du Mandé depuis trois générations.',
      country: 'Mali',
      contentCount: 47,
      followersCount: 12300,
      isVerified: true,
      genres: ['Contes', 'Mythologies', 'Histoires'],
    ),
    AuthorModel(
      id: 'auth_002',
      name: 'Kofi Mensah',
      avatar:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400',
      bio:
          'Historien et écrivain ghanéen. Spécialiste de l\'Empire Ashanti et de la résistance africaine.',
      country: 'Ghana',
      contentCount: 89,
      followersCount: 28500,
      isVerified: true,
      genres: ['Histoire', 'Biographies', 'Découvertes'],
    ),
    AuthorModel(
      id: 'auth_003',
      name: 'Nadia Bouzid',
      avatar: 'https://picsum.photos/400',
      bio:
          'Poétesse et romancière tunisienne. Ses œuvres célèbrent la beauté du Maghreb et du Sahara.',
      country: 'Tunisie',
      contentCount: 34,
      followersCount: 9800,
      isVerified: true,
      genres: ['Poésie', 'Romans', 'Traditions'],
    ),
    AuthorModel(
      id: 'auth_004',
      name: 'Emmanuel Okafor',
      avatar:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
      bio:
          'Réalisateur et podcasteur nigérian. Voix de la jeunesse africaine contemporaine.',
      country: 'Nigéria',
      contentCount: 156,
      followersCount: 45200,
      isVerified: true,
      genres: ['Podcasts', 'Documentaires', 'Culture'],
    ),
    AuthorModel(
      id: 'auth_005',
      name: 'Fatou Diallo',
      avatar:
          'https://images.unsplash.com/photo-1589156229687-496a31ad1d1f?w=400',
      bio:
          'Ethnologue et conteuse sénégalaise. Préserve les récits des peuples Wolof et Peul.',
      country: 'Sénégal',
      contentCount: 62,
      followersCount: 18700,
      isVerified: true,
      genres: ['Contes', 'Proverbes', 'Cultures'],
    ),
  ];

  // ─── CATEGORIES ───────────────────────────────────────────────────────────
  static final List<CategoryModel> categories = [
    CategoryModel(
      id: 'cat_001',
      name: 'Contes & Légendes',
      nameEn: 'Tales & Legends',
      icon: '🌙',
      color: '#D4943A',
      contentCount: 234,
      isFeatured: true,
    ),
    CategoryModel(
      id: 'cat_002',
      name: 'Histoire',
      nameEn: 'History',
      icon: '📜',
      color: '#C1440E',
      contentCount: 189,
      isFeatured: true,
    ),
    CategoryModel(
      id: 'cat_003',
      name: 'Mythologies',
      nameEn: 'Mythologies',
      icon: '⚡',
      color: '#2D6A4F',
      contentCount: 97,
      isFeatured: true,
    ),
    CategoryModel(
      id: 'cat_004',
      name: 'Proverbes',
      nameEn: 'Proverbs',
      icon: '💬',
      color: '#9E6B1F',
      contentCount: 412,
      isFeatured: false,
    ),
    CategoryModel(
      id: 'cat_005',
      name: 'Musique',
      nameEn: 'Music',
      icon: '🥁',
      color: '#52B788',
      contentCount: 78,
      isFeatured: true,
    ),
    CategoryModel(
      id: 'cat_006',
      name: 'Biographies',
      nameEn: 'Biographies',
      icon: '👑',
      color: '#E9C46A',
      contentCount: 143,
      isFeatured: false,
    ),
    CategoryModel(
      id: 'cat_007',
      name: 'Poésie',
      nameEn: 'Poetry',
      icon: '✍️',
      color: '#4895EF',
      contentCount: 67,
      isFeatured: false,
    ),
    CategoryModel(
      id: 'cat_008',
      name: 'Podcasts',
      nameEn: 'Podcasts',
      icon: '🎙️',
      color: '#E63946',
      contentCount: 89,
      isFeatured: true,
    ),
  ];

  // ─── CONTENT ──────────────────────────────────────────────────────────────
  static final List<ContentModel> contents = [
    // FEATURED - Anansi l'araignée
    ContentModel(
      id: 'cnt_001',
      type: ContentType.tale,
      format: ContentFormat.mixed,
      title: 'Anansi et le Soleil Volé',
      subtitle: 'Conte traditionnel Ashanti',
      description:
          'Dans les temps anciens, quand les animaux parlaient encore la langue des hommes, Anansi l\'araignée décida de voler le soleil pour éclairer les nuits de son peuple. Une histoire de ruse, de sagesse et de courage qui traverse les générations.',
      content: '''
# Anansi et le Soleil Volé

*Conte traditionnel du peuple Ashanti, Ghana*

---

Il y a très longtemps, bien avant que les hommes n'apprennent à forger le fer ou à tisser le coton, la nuit était absolument noire. Pas une étoile, pas une lune. Seul le soleil régnait, mais il se couchait tôt, laissant le monde dans une obscurité totale.

**Anansi**, l'araignée à huit pattes, vivait dans un grand fromager au cœur de la forêt. Elle tissait des toiles d'une beauté incomparable, mais ses fils d'or ne brillaient que le jour.

> « Si seulement je pouvais capturer un morceau de soleil, » songea-t-elle, « mes toiles illumineraient les nuits les plus sombres. »

## Le Voyage Commence

Anansi fit ses adieux à ses enfants et commença l'ascension vers le ciel...
      ''',
      coverImage:
          'https://images.unsplash.com/photo-1614332287897-cdc485fa562d?w=800',
      images: [
        'https://images.unsplash.com/photo-1614332287897-cdc485fa562d?w=800',
        'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=800',
      ],
      authorId: 'auth_002',
      authorName: 'Kofi Mensah',
      authorAvatar:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400',
      country: 'Ghana',
      region: AfricanRegion.westAfrica,
      language: 'fr',
      tags: ['Anansi', 'Ashanti', 'Araignée', 'Sagesse', 'Ghana'],
      categoryIds: ['cat_001', 'cat_003'],
      readingTimeMinutes: 12,
      durationSeconds: 1440,
      likesCount: 3420,
      viewsCount: 18900,
      commentsCount: 234,
      bookmarksCount: 892,
      downloadsCount: 456,
      rating: 4.8,
      ratingsCount: 1203,
      isFeatured: true,
      isTrending: true,
      hasAudio: true,
      hasSyncedText: true,
      quizIds: ['quiz_001'],
      publishedAt: DateTime.now().subtract(const Duration(days: 30)),
    ),

    // PROVERBE DU JOUR
    ContentModel(
      id: 'cnt_002',
      type: ContentType.proverb,
      format: ContentFormat.text,
      title: 'Ubuntu : Je suis parce que nous sommes',
      subtitle: 'Philosophie Zoulou',
      description:
          'Ubuntu est un concept philosophique africain fondamental qui exprime l\'interconnexion de l\'humanité.',
      content: '''
# Ubuntu

*"Umuntu ngumuntu ngabantu"*

**Je suis parce que nous sommes** — tel est le sens profond d'Ubuntu, concept fondateur des peuples Nguni d'Afrique australe.

Cette philosophie enseigne que notre humanité est révélée à travers notre relation aux autres. Un individu n'existe que dans la mesure où il reconnaît l'humanité des autres.

## L'origine du mot

Le mot *ubuntu* vient du Zoulou et du Xhosa. Il appartient à la famille linguistique Bantu dont les langues sont parlées dans toute l'Afrique sub-saharienne.

## Application moderne

Nelson Mandela, Desmond Tutu et d'autres grandes figures africaines ont fait d'Ubuntu un pilier de leur pensée politique et spirituelle.
      ''',
      coverImage:
          'https://images.unsplash.com/photo-1489749798305-4fea3ae63d43?w=800',
      authorId: 'auth_005',
      authorName: 'Fatou Diallo',
      country: 'Afrique du Sud',
      region: AfricanRegion.southernAfrica,
      language: 'fr',
      tags: ['Ubuntu', 'Philosophie', 'Zoulou', 'Humanité', 'Afrique Australe'],
      categoryIds: ['cat_004'],
      readingTimeMinutes: 5,
      likesCount: 8904,
      viewsCount: 45600,
      commentsCount: 567,
      rating: 4.9,
      ratingsCount: 2341,
      isFeatured: true,
      hasAudio: true,
      publishedAt: DateTime.now().subtract(const Duration(days: 7)),
    ),

    // HISTOIRE - Mansa Musa
    ContentModel(
      id: 'cnt_003',
      type: ContentType.biography,
      format: ContentFormat.mixed,
      title: 'Mansa Musa : L\'Homme le Plus Riche du Monde',
      subtitle: 'Biographie - Empire du Mali, XIVe siècle',
      description:
          'Au XIVe siècle, un roi africain entreprit un pèlerinage à La Mecque qui bouleversa l\'économie mondiale. Découvrez Mansa Musa, roi du Mali et homme le plus riche de l\'histoire de l\'humanité.',
      content: '''
# Mansa Musa : L'Homme le Plus Riche du Monde

*Empire du Mali, circa 1280 - 1337*

---

En l'an 1324 de notre ère, une caravane extraordinaire traverse le désert du Sahara en direction de La Mecque. À sa tête : **Mansa Musa Ier**, roi de l'Empire du Mali.

Sa suite compte **60 000 hommes**, dont 12 000 esclaves personnels vêtus de soie persane et de brocart. 500 hérauts portent chacun un bâton d'or pesant 2,7 kg. Et 80 à 100 chameaux transportent chacun 140 kg d'or pur.

## Un Empire Légendaire

L'Empire du Mali au XIVe siècle produisait **la moitié de l'or mondial**. Ses mines de Bambuk et de Bure alimentaient toute l'économie médiévale...

## L'Impact sur le Monde

Lors de son passage au Caire, Mansa Musa distribua tant d'or que le métal précieux perdit 25% de sa valeur. L'économie égyptienne ne s'en remit qu'une décennie plus tard.
      ''',
      coverImage:
          'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=800',
      authorId: 'auth_002',
      authorName: 'Kofi Mensah',
      country: 'Mali',
      region: AfricanRegion.westAfrica,
      language: 'fr',
      tags: [
        'Mansa Musa',
        'Empire du Mali',
        'Or',
        'Histoire',
        'Afrique Médiévale',
      ],
      categoryIds: ['cat_002', 'cat_006'],
      readingTimeMinutes: 20,
      durationSeconds: 2700,
      likesCount: 12400,
      viewsCount: 78900,
      commentsCount: 890,
      rating: 4.9,
      ratingsCount: 3456,
      isFeatured: true,
      isTrending: true,
      isNew: false,
      hasAudio: true,
      hasSyncedText: true,
      quizIds: ['quiz_002'],
      publishedAt: DateTime.now().subtract(const Duration(days: 60)),
    ),

    // PODCAST
    ContentModel(
      id: 'cnt_004',
      type: ContentType.podcast,
      format: ContentFormat.audio,
      title: 'Révolutions Africaines : La Résistance Indomptable',
      subtitle: 'Série : Histoires Oubliées — Épisode 12',
      description:
          'De la résistance Ashanti aux mouvements d\'indépendance du XXe siècle, plongez dans les luttes africaines pour la liberté avec Emmanuel Okafor.',
      coverImage:
          'https://images.unsplash.com/photo-1478737270239-2f02b77fc618?w=800',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      authorId: 'auth_004',
      authorName: 'Emmanuel Okafor',
      country: 'Nigéria',
      region: AfricanRegion.westAfrica,
      language: 'fr',
      tags: ['Podcast', 'Résistance', 'Indépendance', 'Histoire'],
      categoryIds: ['cat_002', 'cat_008'],
      durationSeconds: 3600,
      likesCount: 5670,
      viewsCount: 23400,
      commentsCount: 345,
      rating: 4.7,
      ratingsCount: 1123,
      isTrending: true,
      hasAudio: true,
      publishedAt: DateTime.now().subtract(const Duration(days: 14)),
    ),

    // POÉSIE
    ContentModel(
      id: 'cnt_005',
      type: ContentType.poetry,
      format: ContentFormat.text,
      title: 'Sahara, Mer de Sable',
      subtitle: 'Poème — Nadia Bouzid',
      description:
          'Un voyage poétique à travers le Grand Désert, berceau de civilisations et gardien de secrets millénaires.',
      content: '''
# Sahara, Mer de Sable

*— Nadia Bouzid*

---

Ô Sahara, mer de sable et de silence,  
Tu gardes en toi les secrets des étoiles,  
Les pas des caravanes, leurs lentes danses,  
L'or de Tombouctou sous tes voiles.

Tes dunes sont les vagues d'un océan figé,  
Tes nuits plus profondes que la nuit des temps,  
Dans tes profondeurs dort un monde engorgé  
De civilisations et de premiers enfants.

Rêves-tu encore des lions qui ont bu  
À tes rivières mortes il y a dix mille ans ?  
Quand le Sahara était vert, et revêtu  
De forêts où vivaient nos premiers parents ?

Ô Sahara, tu n'es pas que poussière,  
Tu es mémoire vivante de l'Afrique entière.
      ''',
      coverImage:
          'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=800',
      authorId: 'auth_003',
      authorName: 'Nadia Bouzid',
      country: 'Tunisie',
      region: AfricanRegion.northAfrica,
      language: 'fr',
      tags: ['Sahara', 'Poésie', 'Désert', 'Maghreb'],
      categoryIds: ['cat_007'],
      readingTimeMinutes: 3,
      likesCount: 4230,
      viewsCount: 15600,
      commentsCount: 212,
      rating: 4.8,
      ratingsCount: 987,
      hasAudio: true,
      publishedAt: DateTime.now().subtract(const Duration(days: 45)),
    ),

    // AUDIOBOOK
    ContentModel(
      id: 'cnt_006',
      type: ContentType.audiobook,
      format: ContentFormat.audio,
      title: 'Les Milles et Une Nuits Africaines',
      subtitle: 'Compilé par Aminata Kouyaté',
      description:
          'Une collection des plus belles histoires nocturnes de l\'Afrique de l\'Ouest, narrées par la grande griotte Aminata Kouyaté dans la pure tradition du griotisme malien.',
      coverImage:
          'https://images.unsplash.com/photo-1614332287897-cdc485fa562d?w=800',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      authorId: 'auth_001',
      authorName: 'Aminata Kouyaté',
      country: 'Mali',
      region: AfricanRegion.westAfrica,
      language: 'fr',
      tags: ['Livre Audio', 'Contes', 'Griot', 'Mali', 'Nuit'],
      categoryIds: ['cat_001'],
      durationSeconds: 18000,
      likesCount: 7890,
      viewsCount: 34500,
      commentsCount: 456,
      rating: 4.9,
      ratingsCount: 2234,
      isFeatured: true,
      hasAudio: true,
      publishedAt: DateTime.now().subtract(const Duration(days: 90)),
    ),

    // ISSU DE LA MYTHOLOGIE - Yoruba
    ContentModel(
      id: 'cnt_007',
      type: ContentType.mythology,
      format: ContentFormat.mixed,
      title: 'Shango : Dieu de la Foudre Yoruba',
      subtitle: 'Mythologie Yoruba — Nigéria',
      description:
          'Shango, quatrième Oba d\'Oyo devenu divinité, est le dieu de la foudre et de la justice dans le panthéon Yoruba. Découvrez son histoire épique.',
      content: '''
# Shango : Dieu de la Foudre

*Panthéon Yoruba — Nigéria*

---

## Qui est Shango ?

Dans la religion Yoruba, **Shango** (aussi écrit Ṣàngó) est l'un des Orishas — ces divinités qui peuplent le monde spirituel yoruba. Avant de devenir dieu, il fut un roi très puissant, le quatrième Alaafin (roi) d'Oyo.

## Le Double Tranchant du Pouvoir

La légende raconte que Shango reçut un jour un charme magique qui lui donnait le pouvoir de lancer des éclairs par la bouche. Lors d'une démonstration, il détruisit accidentellement sa propre palace...

## Héritage Universel

L'influence de Shango dépasse largement les frontières du Nigéria. Transporté par la diaspora africaine lors de la traite des esclaves, son culte est vivant aujourd'hui à Cuba (Candomblé), au Brésil et dans les Caraïbes.
      ''',
      coverImage:
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
      authorId: 'auth_004',
      authorName: 'Emmanuel Okafor',
      country: 'Nigéria',
      region: AfricanRegion.westAfrica,
      language: 'fr',
      tags: ['Shango', 'Yoruba', 'Mythologie', 'Orishas', 'Nigéria'],
      categoryIds: ['cat_003'],
      readingTimeMinutes: 15,
      durationSeconds: 1800,
      likesCount: 9023,
      viewsCount: 41200,
      commentsCount: 678,
      rating: 4.8,
      ratingsCount: 2890,
      isFeatured: true,
      hasAudio: true,
      publishedAt: DateTime.now().subtract(const Duration(days: 21)),
    ),

    // HISTOIRE RÉCENTE
    ContentModel(
      id: 'cnt_008',
      type: ContentType.history,
      format: ContentFormat.text,
      title: 'Les Reines d\'Afrique : Nzinga, Cléopâtre, Yaa Asantewaa',
      subtitle: 'Grande figures féminines africaines',
      description:
          'Des reines guerrières aux diplomates subtiles, l\'histoire africaine regorge de figures féminines extraordinaires dont les actes ont changé le cours de l\'histoire.',
      content:
          '# Les Grandes Reines d\'Afrique\n\n## Nzinga du Ndongo\n\nAu XVIIe siècle, **Nzinga Mbande** devint reine du Ndongo (actuel Angola) et s\'opposa pendant quarante ans aux tentatives de colonisation portugaise...\n\n## Yaa Asantewaa\n\nEn 1900, quand les Britanniques voulurent s\'emparer du trône d\'or Ashanti, c\'est **Yaa Asantewaa**, reine mère d\'Ejisu, qui prit les armes et mena la dernière grande guerre Ashanti...',
      coverImage:
          'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=800',
      authorId: 'auth_001',
      authorName: 'Aminata Kouyaté',
      region: AfricanRegion.panAfrica,
      language: 'fr',
      tags: ['Reines', 'Femmes', 'Histoire', 'Nzinga', 'Yaa Asantewaa'],
      categoryIds: ['cat_002', 'cat_006'],
      readingTimeMinutes: 18,
      likesCount: 15600,
      viewsCount: 89000,
      commentsCount: 1234,
      rating: 4.9,
      ratingsCount: 4567,
      isFeatured: true,
      isTrending: true,
      hasAudio: true,
      publishedAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
  ];

  // ─── QUIZZES ──────────────────────────────────────────────────────────────
  static final List<QuizModel> quizzes = [
    QuizModel(
      id: 'quiz_001',
      contentId: 'cnt_001',
      title: 'Avez-vous bien compris l\'histoire d\'Anansi ?',
      xpReward: 100,
      questions: [
        QuizQuestion(
          id: 'q_001',
          question: 'De quel peuple vient la tradition des contes d\'Anansi ?',
          options: [
            'Zoulou (Afrique du Sud)',
            'Ashanti (Ghana)',
            'Peul (Sénégal)',
            'Haoussa (Nigéria)',
          ],
          correctIndex: 1,
          explanation:
              'Anansi est un personnage central de la mythologie Ashanti du Ghana, et son histoire s\'est répandue dans toute l\'Afrique de l\'Ouest et les Caraïbes via la diaspora africaine.',
        ),
        QuizQuestion(
          id: 'q_002',
          question: 'Que symbolise Anansi dans la tradition Ashanti ?',
          options: [
            'La force brute et la guerre',
            'La fertilité et la pluie',
            'La ruse, la sagesse et la connaissance',
            'La mort et le passage dans l\'autre monde',
          ],
          correctIndex: 2,
          explanation:
              'Anansi est le dieu-araignée et est associé à la sagesse, aux histoires et à la connaissance. Il est souvent décrit comme rusé et ingénieux.',
        ),
        QuizQuestion(
          id: 'q_003',
          question: 'Dans quelles autres cultures retrouve-t-on Anansi ?',
          options: [
            'Uniquement au Ghana',
            'Dans les Caraïbes et l\'Amérique',
            'En Asie et en Europe',
            'Seulement en Afrique de l\'Ouest',
          ],
          correctIndex: 1,
          explanation:
              'La diaspora africaine a emporté les histoires d\'Anansi dans les Caraïbes (Jamaïque, Trinité) et aux États-Unis, où il est toujours présent dans le folklore populaire.',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_002',
      contentId: 'cnt_003',
      title: 'Testez vos connaissances sur Mansa Musa',
      xpReward: 150,
      questions: [
        QuizQuestion(
          id: 'q_004',
          question: 'En quelle année Mansa Musa entreprit-il son pèlerinage ?',
          options: ['1200', '1324', '1456', '1098'],
          correctIndex: 1,
          explanation:
              'Mansa Musa effectua son célèbre pèlerinage à La Mecque en 1324, marquant les esprits de toute la région méditerranéenne.',
        ),
        QuizQuestion(
          id: 'q_005',
          question:
              'Quel impact eut son passage au Caire sur l\'économie locale ?',
          options: [
            'Il enrichit considérablement l\'Égypte',
            'Rien de notable',
            'Il provoqua une inflation en distribuant trop d\'or',
            'Il pillé les marchés locaux',
          ],
          correctIndex: 2,
          explanation:
              'Mansa Musa distribua tant d\'or au Caire que la valeur du métal s\'effondra de 25%, perturbant l\'économie égyptienne pendant une décennie.',
        ),
      ],
    ),
  ];

  // ─── PROVERBES DU JOUR ───────────────────────────────────────────────────
  static final List<Map<String, String>> dailyProverbs = [
    {
      'text': 'Ubuntu : Je suis parce que nous sommes.',
      'origin': 'Philosophie Zoulou',
      'country': 'Afrique du Sud',
    },
    {
      'text':
          'Si tu veux aller vite, marche seul. Si tu veux aller loin, marche ensemble.',
      'origin': 'Proverbe Africain',
      'country': 'Afrique',
    },
    {
      'text':
          'La forêt serait silencieuse si aucun oiseau ne chantait hormis celui qui chante le mieux.',
      'origin': 'Proverbe Congolais',
      'country': 'Congo',
    },
    {
      'text':
          'Tant que les lions n\'auront pas leurs propres historiens, l\'histoire de la chasse glorifiera toujours le chasseur.',
      'origin': 'Proverbe Igbo',
      'country': 'Nigéria',
    },
    {
      'text': 'L\'eau que tu portes dans tes mains ne te désaltère pas.',
      'origin': 'Proverbe Wolof',
      'country': 'Sénégal',
    },
    {
      'text':
          'Quand les araignées tissent ensemble, elles peuvent attraper un lion.',
      'origin': 'Proverbe Éthiopien',
      'country': 'Éthiopie',
    },
    {
      'text':
          'Un enfant qui n\'est pas éduqué par ses parents le sera par la vie.',
      'origin': 'Proverbe Ashanti',
      'country': 'Ghana',
    },
  ];

  // ─── AFRICAN COUNTRIES FOR MAP ───────────────────────────────────────────
  static final List<Map<String, dynamic>> africanCountries = [
    {
      'code': 'SN',
      'name': 'Sénégal',
      'region': 'westAfrica',
      'contentCount': 89,
    },
    {'code': 'ML', 'name': 'Mali', 'region': 'westAfrica', 'contentCount': 134},
    {
      'code': 'GH',
      'name': 'Ghana',
      'region': 'westAfrica',
      'contentCount': 167,
    },
    {
      'code': 'NG',
      'name': 'Nigéria',
      'region': 'westAfrica',
      'contentCount': 245,
    },
    {
      'code': 'ET',
      'name': 'Éthiopie',
      'region': 'eastAfrica',
      'contentCount': 178,
    },
    {
      'code': 'KE',
      'name': 'Kenya',
      'region': 'eastAfrica',
      'contentCount': 145,
    },
    {
      'code': 'TZ',
      'name': 'Tanzanie',
      'region': 'eastAfrica',
      'contentCount': 123,
    },
    {
      'code': 'ZA',
      'name': 'Afrique du Sud',
      'region': 'southernAfrica',
      'contentCount': 198,
    },
    {
      'code': 'EG',
      'name': 'Égypte',
      'region': 'northAfrica',
      'contentCount': 212,
    },
    {
      'code': 'MA',
      'name': 'Maroc',
      'region': 'northAfrica',
      'contentCount': 156,
    },
    {
      'code': 'TN',
      'name': 'Tunisie',
      'region': 'northAfrica',
      'contentCount': 89,
    },
    {
      'code': 'CD',
      'name': 'Congo',
      'region': 'centralAfrica',
      'contentCount': 134,
    },
    {
      'code': 'CM',
      'name': 'Cameroun',
      'region': 'centralAfrica',
      'contentCount': 112,
    },
    {'code': 'TG', 'name': 'Togo', 'region': 'westAfrica', 'contentCount': 67},
    {
      'code': 'CI',
      'name': 'Côte d\'Ivoire',
      'region': 'westAfrica',
      'contentCount': 145,
    },
    {'code': 'BJ', 'name': 'Bénin', 'region': 'westAfrica', 'contentCount': 89},
  ];

  // ─── HISTORICAL TIMELINE ─────────────────────────────────────────────────
  static final List<Map<String, dynamic>> historicalEvents = [
    {
      'year': -3200,
      'title': 'Naissance de l\'écriture en Égypte',
      'description':
          'Les hiéroglyphes sont l\'un des premiers systèmes d\'écriture au monde.',
      'region': 'northAfrica',
      'country': 'Égypte',
    },
    {
      'year': -2560,
      'title': 'Construction de la Grande Pyramide',
      'description':
          'Kheops fait ériger la plus grande pyramide du monde à Gizeh.',
      'region': 'northAfrica',
      'country': 'Égypte',
    },
    {
      'year': 300,
      'title': 'Empire du Ghana',
      'description':
          'Le premier grand empire de l\'Afrique de l\'Ouest contrôle les routes commerciales de l\'or.',
      'region': 'westAfrica',
      'country': 'Mauritanie/Mali',
    },
    {
      'year': 1235,
      'title': 'Fondation de l\'Empire du Mali',
      'description':
          'Soundiata Keïta fonde l\'Empire du Mali après la bataille de Kirina.',
      'region': 'westAfrica',
      'country': 'Mali',
    },
    {
      'year': 1324,
      'title': 'Pèlerinage de Mansa Musa',
      'description':
          'Mansa Musa part en pèlerinage avec 60 000 hommes et bouleverse l\'économie mondiale.',
      'region': 'westAfrica',
      'country': 'Mali',
    },
    {
      'year': 1960,
      'title': 'L\'Année de l\'Afrique',
      'description':
          'Dix-sept pays africains accèdent à l\'indépendance en une seule année.',
      'region': 'panAfrica',
      'country': 'Afrique',
    },
  ];

  // ─── AVAILABLE LANGUAGES ─────────────────────────────────────────────────
  static final List<Map<String, String>> languages = [
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
    {'code': 'sw', 'name': 'Kiswahili', 'flag': '🇰🇪'},
    {'code': 'yo', 'name': 'Yoruba', 'flag': '🇳🇬'},
    {'code': 'fon', 'name': 'Fon', 'flag': '🇧🇯'},
    {'code': 'ewe', 'name': 'Ewe', 'flag': '🇹🇬'},
    {'code': 'ha', 'name': 'Hausa', 'flag': '🇳🇬'},
    {'code': 'ln', 'name': 'Lingala', 'flag': '🇨🇩'},
    {'code': 'bm', 'name': 'Bambara', 'flag': '🇲🇱'},
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
    {'code': 'am', 'name': 'አማርኛ', 'flag': '🇪🇹'},
    {'code': 'wo', 'name': 'Wolof', 'flag': '🇸🇳'},
  ];

  // Getters helpers
  static ContentModel? getContentById(String id) {
    try {
      return contents.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<ContentModel> getFeatured() =>
      contents.where((c) => c.isFeatured).toList();

  static List<ContentModel> getTrending() =>
      contents.where((c) => c.isTrending).toList();

  static List<ContentModel> getByType(ContentType type) =>
      contents.where((c) => c.type == type).toList();

  static List<ContentModel> getByRegion(AfricanRegion region) =>
      contents.where((c) => c.region == region).toList();

  static List<ContentModel> search(String query) {
    final q = query.toLowerCase();
    return contents
        .where(
          (c) =>
              c.title.toLowerCase().contains(q) ||
              c.description.toLowerCase().contains(q) ||
              c.tags.any((t) => t.toLowerCase().contains(q)) ||
              c.authorName.toLowerCase().contains(q),
        )
        .toList();
  }

  static String getTodayProverb() {
    final dayOfYear = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    return dailyProverbs[dayOfYear % dailyProverbs.length]['text']!;
  }

  static Map<String, String> getTodayProverbFull() {
    final dayOfYear = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    return dailyProverbs[dayOfYear % dailyProverbs.length];
  }
}
