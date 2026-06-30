import 'dart:math';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/comment_model.dart';
import '../models/content_model.dart';
import '../models/history_entry_model.dart';

class MockDataProvider {
  MockDataProvider._();

  // ---------------------------------------------------------------------
  // Languages
  // ---------------------------------------------------------------------
  static const List<String> languages = [
    'English',
    'French',
    'Swahili',
    'Yoruba',
    'Wolof',
  ];

  // ---------------------------------------------------------------------
  // Categories
  // ---------------------------------------------------------------------
  static final List<CategoryModel> categories = [
    CategoryModel(id: 'west_african_tales', name: 'West African Tales', icon: Icons.auto_stories_rounded, colorIndex: 0),
    CategoryModel(id: 'zulu_heritage', name: 'Zulu Heritage', icon: Icons.format_quote_rounded, colorIndex: 1),
    CategoryModel(id: 'sahel_history', name: 'Sahel History', icon: Icons.account_balance_rounded, colorIndex: 2),
    CategoryModel(id: 'yoruba_mythology', name: 'Yoruba Mythology', icon: Icons.auto_awesome_rounded, colorIndex: 3),
    CategoryModel(id: 'swahili_coast', name: 'Swahili Coast Trade', icon: Icons.sailing_rounded, colorIndex: 4),
    CategoryModel(id: 'ethiopian_heritage', name: 'Ethiopian Heritage', icon: Icons.terrain_rounded, colorIndex: 5),
    CategoryModel(id: 'southern_african_art', name: 'Southern African Art', icon: Icons.brush_rounded, colorIndex: 0),
    CategoryModel(id: 'ashanti_kingdom', name: 'Ashanti Kingdom', icon: Icons.diamond_rounded, colorIndex: 1),
    CategoryModel(id: 'east_african_legends', name: 'East African Legends', icon: Icons.landscape_rounded, colorIndex: 2),
    CategoryModel(id: 'griot_songs', name: 'Griot Songs & Poetry', icon: Icons.music_note_rounded, colorIndex: 3),
  ];

  // ---------------------------------------------------------------------
  // Authors
  // ---------------------------------------------------------------------
  static final AuthorModel _awa = AuthorModel(
    id: 'a1',
    name: 'Griot Awa Touré',
    role: 'Narrator · Griot',
    avatarColorIndex: 0,
    bio: 'Master storyteller from Dakar, keeper of Wolof oral traditions for over twenty years.',
    followers: 12400,
  );
  static final AuthorModel _kwame = AuthorModel(
    id: 'a2',
    name: 'Prof. Kwame Asante',
    role: 'Historian · Author',
    avatarColorIndex: 1,
    bio: 'Historian specializing in West African empires and Sahelian trade routes.',
    followers: 8900,
  );
  static final AuthorModel _nomvula = AuthorModel(
    id: 'a3',
    name: 'Nomvula Khumalo',
    role: 'Storyteller',
    avatarColorIndex: 2,
    bio: 'Zulu praise-poet and proverb collector based in KwaZulu-Natal.',
    followers: 6700,
  );
  static final AuthorModel _ibrahim = AuthorModel(
    id: 'a4',
    name: 'Ibrahim Cissé',
    role: 'Narrator',
    avatarColorIndex: 3,
    bio: "Voice of Timbuktu's manuscript archives, narrating Sahel chronicles.",
    followers: 5400,
  );
  static final AuthorModel _amina = AuthorModel(
    id: 'a5',
    name: 'Amina Hassan',
    role: 'Author',
    avatarColorIndex: 4,
    bio: 'Writer documenting Ethiopian highland heritage and Aksumite history.',
    followers: 4100,
  );
  static final AuthorModel _tendai = AuthorModel(
    id: 'a6',
    name: 'Tendai Moyo',
    role: 'Narrator',
    avatarColorIndex: 5,
    bio: 'Storyteller bringing East African legends and folklore to audio.',
    followers: 7300,
  );

  // ---------------------------------------------------------------------
  // Content library
  // ---------------------------------------------------------------------
  static final List<ContentModel> allContent = [
    ContentModel(
      id: 'c1',
      title: 'The Proverb of the Baobab',
      subtitle: 'Daily Proverb',
      category: 'West African Tales',
      region: 'West Africa',
      language: 'English',
      type: ContentType.text,
      coverIndex: 0,
      author: _awa,
      tags: const ['featured', 'proverb', 'micro'],
      mediaLabels: const ['Baobab at Dusk'],
      isFeatured: true,
      likes: 342,
      commentsCount: 4,
      dateAdded: '2 days ago',
      body: '''
## A Saying Worth Planting

> "A single tree cannot make a forest, but a single seed can begin one."

Elders across the savanna tell this to children who feel too small to matter. The **baobab**, they say, grows slowly for a hundred years before it ever flowers — yet every baobab alive today began as one seed that someone bothered to plant.

### What it teaches

- Patience is not wasted time; it is preparation.
- Small, consistent acts outlast grand but fleeting ones.
- A community is built the same way a forest is — one seed, one person, at a time.

Many griots pair this proverb with a gesture: cupping a handful of soil and letting it fall slowly, to remind listeners that *what we plant now, others will rest beneath.*
''',
    ),
    ContentModel(
      id: 'c2',
      title: 'Sundiata: Lion of Mali',
      subtitle: 'Epic Chronicles',
      category: 'Sahel History',
      region: 'Mali',
      language: 'English',
      type: ContentType.audio,
      coverIndex: 2,
      author: _ibrahim,
      tags: const ['featured', 'history', 'audio', 'micro'],
      mediaLabels: const ['Manuscript Page', 'Empire Map'],
      durationSeconds: 1860,
      isFeatured: true,
      likes: 980,
      commentsCount: 12,
      dateAdded: '5 days ago',
      body: '''
## The Boy Who Could Not Walk

Long before he was remembered as the founder of a great Sahelian empire, the young prince was mocked for a body that would not obey him. Court rivals whispered that a kingdom needs a lion, not a crawling child.

### Exile and Return

Driven from his home, he spent his early years among neighboring courts, learning statecraft, archery, and the patience of the wronged. When tyranny finally became unbearable for his people, messengers were sent to find him.

> "He returned not as a boy who had been pitied, but as a man who had been tested."

His armies are remembered for uniting rival clans under a single pact — an early charter binding hunters, blacksmiths, and griots into one nation, built on shared oaths rather than conquest alone.

### Legacy

The empire that followed grew into one of the great trading powers of the Sahel, its caravans linking the gold fields of the south to the salt and scholarship of the north.
''',
    ),
    ContentModel(
      id: 'c3',
      title: 'How the Tortoise Earned His Cracked Shell',
      subtitle: 'Animal Folktale',
      category: 'West African Tales',
      region: 'West Africa',
      language: 'English',
      type: ContentType.audio,
      coverIndex: 6,
      author: _awa,
      tags: const ['audio'],
      durationSeconds: 540,
      likes: 210,
      commentsCount: 6,
      dateAdded: '1 week ago',
      body: '''
## A Feast in the Sky

When the birds of the forest were invited to a great feast among the clouds, the tortoise begged to come along. Too proud to be left behind, he convinced each bird to lend him a single feather, until he too could fly.

He gave himself a new name for the occasion — *"All of You"* — and when the hosts announced the feast was for **all of you**, he claimed it belonged to him alone, eating his fill before the birds could touch a bite.

### The Price of Cleverness

Furious, the birds reclaimed their feathers one by one mid-flight, leaving the tortoise to fall from the sky. He landed hard upon his back, and that, the storytellers say, is why every tortoise since has carried a shell of many cracked pieces — a lesson worn permanently into his back.

> "Cleverness without honesty always finds its way home."
''',
    ),
    ContentModel(
      id: 'c4',
      title: 'Zulu Sayings on Unity',
      subtitle: 'Proverb Collection',
      category: 'Zulu Heritage',
      region: 'Southern Africa',
      language: 'English',
      type: ContentType.text,
      coverIndex: 4,
      author: _nomvula,
      tags: const ['proverb', 'text', 'micro'],
      likes: 156,
      commentsCount: 2,
      dateAdded: '3 days ago',
      body: '''
## Three Sayings, One Thread

Among the many proverbs passed down through Zulu praise-poetry, three are recited most often at gatherings meant to mend old quarrels.

1. **"A person is a person through other people."** — Identity is never built alone; it is shaped in relationship with community.
2. **"One finger cannot kill a louse."** — Tasks that feel impossible alone become manageable when shared.
3. **"The visitor who stays too long becomes part of the house."** — Hospitality is a living bond, not a temporary courtesy.

### Why they endure

Praise-poets weave these sayings into longer recitations during weddings, councils, and homecomings, using them as anchors that the whole audience can recite together — a way of turning private wisdom into a shared, spoken inheritance.
''',
    ),
    ContentModel(
      id: 'c5',
      title: 'The Rise of the Ashanti Goldweights',
      subtitle: 'Craft & Kingdom',
      category: 'Ashanti Kingdom',
      region: 'Ghana',
      language: 'English',
      type: ContentType.video,
      coverIndex: 3,
      author: _kwame,
      tags: const ['video', 'history', 'micro'],
      mediaLabels: const ['Goldweight Display', 'Kumasi Palace'],
      durationSeconds: 420,
      likes: 430,
      commentsCount: 9,
      dateAdded: '4 days ago',
      body: '''
## Weighing More Than Gold

Brass goldweights once used across the Ashanti trading networks were never just measuring tools. Cast into the shapes of animals, tools, and proverbs, each weight carried a moral lesson alongside its function.

### A Visual Language

A crocodile gripping a fish might warn against greed; two birds sharing one beak could illustrate cooperation. Merchants weighing gold dust were, in effect, exchanging small sculpted parables along with their trade.

> "Even commerce, here, was taught to speak in wisdom."

The goldweights survive today in museums and private collections as some of the most detailed miniature bronze-casting traditions on the continent, evidence of a kingdom where craftsmanship and statecraft were deeply intertwined.
''',
    ),
    ContentModel(
      id: 'c6',
      title: 'Voices of the Sahel: Trade and Empire',
      subtitle: 'Documentary Short',
      category: 'Sahel History',
      region: 'West Africa',
      language: 'English',
      type: ContentType.video,
      coverIndex: 2,
      author: _kwame,
      tags: const ['video', 'history', 'featured', 'micro'],
      mediaLabels: const ['Caravan Route', 'Salt Market', 'Scholars at Work'],
      durationSeconds: 720,
      isFeatured: true,
      likes: 612,
      commentsCount: 18,
      dateAdded: '6 days ago',
      body: '''
## Gold, Salt, and Scholarship

For centuries, camel caravans crossed the Sahara carrying gold north and salt south, stitching together cities that became centers of trade and learning in their own right.

### A Network, Not a Single Empire

No single ruler controlled this exchange. Instead, a constellation of trading cities — bound by shared routes, currencies, and scholarly networks — allowed ideas to travel as freely as goods. Manuscripts on astronomy, law, and theology moved alongside bars of salt.

> "A caravan was a library on the move."

This is the often-overlooked engine behind the wealth historians associate with Sahelian kingdoms: not conquest alone, but logistics, diplomacy, and an appetite for knowledge.
''',
    ),
    ContentModel(
      id: 'c7',
      title: 'Why the Sky and Earth Parted',
      subtitle: 'Origin Myth',
      category: 'Yoruba Mythology',
      region: 'Nigeria',
      language: 'English',
      type: ContentType.text,
      coverIndex: 7,
      author: _amina,
      tags: const ['text', 'history'],
      likes: 298,
      commentsCount: 5,
      dateAdded: '1 week ago',
      body: '''
## When the Heavens Touched the Ground

In the oldest tellings, the sky once rested so close to the earth that people could reach up and touch it. Children played beneath its low ceiling, and elders warned them never to grow careless with its nearness.

### The Careless Hand

One day, a woman pounding yam struck the sky's edge with her heavy pestle, again and again, until the heavens recoiled in pain and rose far beyond reach, taking with it the easy closeness people once knew with the divine.

> "Since that day, prayer has had to travel farther to be heard."

### A Lesson in Reverence

The story is often told not as punishment, but as explanation: distance from the sacred is not abandonment, it is a reminder to approach it with more care than before.
''',
    ),
    ContentModel(
      id: 'c8',
      title: 'Dhows of the Swahili Coast',
      subtitle: 'Maritime Heritage',
      category: 'Swahili Coast Trade',
      region: 'East Africa',
      language: 'Swahili',
      type: ContentType.image,
      coverIndex: 4,
      author: _ibrahim,
      tags: const ['image'],
      mediaLabels: const ['Stone Town Harbor', 'Dhow Sails', 'Spice Market'],
      likes: 187,
      commentsCount: 3,
      dateAdded: '2 weeks ago',
      body: '''
## Wind, Wood, and Monsoon

The wooden dhows that once lined the Swahili coast were built to ride the seasonal monsoon winds, carrying ivory, spices, and textiles between East Africa, Arabia, and the wider Indian Ocean world.

### A Coast Built on Exchange

Towns like Kilwa and Lamu grew wealthy not by isolation but by connection, blending Bantu, Arab, and Persian influences into the distinct Swahili culture and language still spoken today.

> "Every plank of a dhow remembers a port it has visited."

Shipwrights passed construction knowledge down through families, stitching hulls together with coconut fiber rope long before iron nails became common — a craft as much a part of the coast's identity as its language.
''',
    ),
    ContentModel(
      id: 'c9',
      title: 'Aksum: The Forgotten Empire',
      subtitle: 'Ancient Civilizations',
      category: 'Ethiopian Heritage',
      region: 'Ethiopia',
      language: 'English',
      type: ContentType.text,
      coverIndex: 5,
      author: _amina,
      tags: const ['history', 'text'],
      likes: 401,
      commentsCount: 15,
      dateAdded: '3 days ago',
      body: '''
## A Kingdom of Stone and Trade

Long before its name faded from common memory outside the region, the kingdom of Aksum minted its own currency, raised towering carved stelae, and traded with Rome, Persia, and India through its Red Sea ports.

### Stelae That Still Stand

The tallest standing obelisk at Aksum rises over twenty meters, carved from a single block of granite — an engineering feat that still puzzles historians about the methods used to quarry and raise it.

> "A nation's confidence can often be read in the height of what it dares to carve."

### A Lasting Faith

Aksum was also among the earliest states in the world to adopt Christianity at a royal level, a heritage still visible today in Ethiopia's rock-hewn churches and ancient liturgical traditions.
''',
    ),
    ContentModel(
      id: 'c10',
      title: 'San Rock Art: Messages from the Ancestors',
      subtitle: 'Ancient Illustrations',
      category: 'Southern African Art',
      region: 'Southern Africa',
      language: 'English',
      type: ContentType.image,
      coverIndex: 1,
      author: _nomvula,
      tags: const ['image', 'history', 'micro'],
      mediaLabels: const ['Eland Painting', 'Trance Dance Scene'],
      likes: 145,
      commentsCount: 1,
      dateAdded: '10 days ago',
      body: '''
## Painted on Stone, Carried for Millennia

Across caves and rock shelters of southern Africa, San artists left behind paintings of eland, dancers, and half-human figures believed to depict trance states reached during healing ceremonies.

### Reading the Symbols

Far from simple hunting records, many researchers now believe these images document spiritual journeys, where the eland — a powerful, fat-rich antelope — symbolized the potency shamans sought to channel during ritual dances.

> "The rock did not just hold paint; it held a doorway."

Some of these paintings are thousands of years old, making them among the oldest continuously interpreted artistic traditions still spoken about by descendant communities today.
''',
    ),
    ContentModel(
      id: 'c11',
      title: 'The Legend of the Sky Cattle',
      subtitle: 'Pastoral Folklore',
      category: 'East African Legends',
      region: 'East Africa',
      language: 'English',
      type: ContentType.audio,
      coverIndex: 1,
      author: _tendai,
      tags: const ['audio'],
      durationSeconds: 480,
      likes: 233,
      commentsCount: 4,
      dateAdded: '3 days ago',
      body: '''
## A Gift Lowered from the Heavens

In this widely loved pastoral legend, the first cattle did not walk up from the plains — they were lowered to earth on a rope of leather let down from the sky, a gift meant to bind the sky-father and his earthbound children.

### A Broken Rope

A jealous hyena, the story goes, severed the rope out of envy, stranding the remaining cattle on earth forever and ending easy passage between worlds. This is why, elders say, cattle are treated not as mere property but as a sacred inheritance — the last living thread to a covenant with the sky.

> "To lose a cow, in this telling, is to lose a small piece of that ancient rope."

Herders still invoke this story when naming favored cattle, treating the act of naming as a small renewal of that original bond.
''',
    ),
    ContentModel(
      id: 'c12',
      title: "The Griot's Song of Remembrance",
      subtitle: 'Oral Poetry',
      category: 'Griot Songs & Poetry',
      region: 'West Africa',
      language: 'Wolof',
      type: ContentType.audio,
      coverIndex: 0,
      author: _awa,
      tags: const ['audio', 'featured', 'micro'],
      durationSeconds: 300,
      isFeatured: true,
      likes: 521,
      commentsCount: 10,
      dateAdded: '1 day ago',
      body: '''
## Memory Set to Rhythm

A griot does not simply sing — she **keeps**. Each lineage, treaty, and harvest worth remembering is set into rhythm and rhyme so that it survives the forgetting that plain speech cannot resist.

### Why Song, Not Just Speech

Melody anchors memory. A genealogy recited as song can be passed down accurately for generations in ways flat prose rarely is, because rhythm gives both the singer and the listener a structure to hold onto.

> "What is sung is rarely lost; what is only spoken often is."

This particular song of remembrance honors ancestors by name, pausing after each one so listeners can add their own breath of respect — turning a solo performance into a shared act of memory.
''',
    ),
    ContentModel(
      id: 'c13',
      title: 'Wisdom of the Elders: A Wolof Saying',
      subtitle: 'Daily Proverb',
      category: 'West African Tales',
      region: 'Senegal',
      language: 'Wolof',
      type: ContentType.text,
      coverIndex: 0,
      author: _awa,
      tags: const ['proverb', 'text', 'micro'],
      likes: 98,
      commentsCount: 1,
      dateAdded: '4 days ago',
      body: '''
## Borrowed Wisdom

> "The river that forgets its source will dry up first."

This saying is often offered to the young when they begin to outgrow the guidance of those who raised them. It is not a warning against growth, but against forgetting — a reminder that confidence and memory of origin can coexist.

### A Gentle Correction

Elders use it sparingly, usually with a smile rather than a scold, because its power lies in being remembered later, quietly, rather than obeyed immediately.
''',
    ),
    ContentModel(
      id: 'c14',
      title: 'Shaka: Reshaping a Nation',
      subtitle: 'Leadership & History',
      category: 'Zulu Heritage',
      region: 'Southern Africa',
      language: 'English',
      type: ContentType.text,
      coverIndex: 1,
      author: _nomvula,
      tags: const ['history', 'text'],
      likes: 367,
      commentsCount: 8,
      dateAdded: '5 days ago',
      body: '''
## A Military Reorganization

Among the most studied transformations in the region's history is the rapid reorganization of Zulu military and social structure in the early nineteenth century, which reshaped alliances across a wide stretch of southern Africa.

### New Formations, New Strategy

Traditional long-throwing spears were largely replaced with shorter stabbing weapons suited to close combat, while regiments were organized by age groups rather than by clan alone — a shift that prioritized unified command over fragmented loyalty.

> "Strategy, more than size alone, redrew the map."

### A Debated Legacy

Historians continue to debate the scale and causes of the disruption that followed these changes, but few dispute that the period permanently altered the political landscape of the region, prompting migrations and new kingdoms far beyond its origin.
''',
    ),
    ContentModel(
      id: 'c15',
      title: 'Timbuktu: City of Manuscripts',
      subtitle: 'Centers of Learning',
      category: 'Sahel History',
      region: 'Mali',
      language: 'French',
      type: ContentType.video,
      coverIndex: 7,
      author: _ibrahim,
      tags: const ['video', 'history'],
      mediaLabels: const ['Manuscript Library', 'Sankore Mosque'],
      durationSeconds: 600,
      likes: 289,
      commentsCount: 7,
      dateAdded: '2 weeks ago',
      body: '''
## A City Measured in Books

At its height, this Sahelian city was less famous for gold than for ink. Private libraries held tens of thousands of manuscripts on astronomy, medicine, law, and theology, copied and debated by scholars from across the region.

### Knowledge as Inheritance

Many of these manuscripts were passed down within families for centuries, hidden in trunks and walls during periods of unrest, and are still being catalogued and preserved by their descendants today.

> "A city can be a fortress of stone, or a fortress of memory. This one chose both."
''',
    ),
  ];

  // ---------------------------------------------------------------------
  // Comments
  // ---------------------------------------------------------------------
  static final Map<String, List<CommentModel>> _comments = {
    'c1': [
      CommentModel(id: 'cm1', authorName: 'Kofi B.', avatarColorIndex: 1, text: 'My grandmother used to say this exact line. Chills.', timeAgo: '1h ago', likes: 14),
      CommentModel(id: 'cm2', authorName: 'Zainab O.', avatarColorIndex: 2, text: 'Sharing this with my kids tonight.', timeAgo: '3h ago', likes: 9),
      CommentModel(id: 'cm3', authorName: 'Thabo M.', avatarColorIndex: 4, text: 'The baobab imagery is perfect for this one.', timeAgo: '5h ago', likes: 5),
    ],
    'c2': [
      CommentModel(id: 'cm4', authorName: 'Aïssatou D.', avatarColorIndex: 0, text: 'Ibrahim\'s narration gives me goosebumps every time.', timeAgo: '2h ago', likes: 22),
      CommentModel(id: 'cm5', authorName: 'Mensah K.', avatarColorIndex: 3, text: 'Would love a full series on the Mali Empire.', timeAgo: '1 day ago', likes: 17),
    ],
    'c12': [
      CommentModel(id: 'cm6', authorName: 'Fatou S.', avatarColorIndex: 5, text: 'The pause after each name is so powerful.', timeAgo: '40m ago', likes: 11),
      CommentModel(id: 'cm7', authorName: 'Jelani R.', avatarColorIndex: 2, text: 'This belongs in a museum exhibit.', timeAgo: '2h ago', likes: 8),
    ],
  };

  static List<CommentModel> commentsFor(String contentId) =>
      _comments.putIfAbsent(contentId, () => <CommentModel>[]);

  static CommentModel addComment(String contentId, String text) {
    final comment = CommentModel(
      id: 'cm_${DateTime.now().microsecondsSinceEpoch}',
      authorName: 'You',
      avatarColorIndex: 5,
      text: text,
      timeAgo: 'Just now',
    );
    commentsFor(contentId).insert(0, comment);
    return comment;
  }

  // ---------------------------------------------------------------------
  // History entries
  // ---------------------------------------------------------------------
  static final List<HistoryEntryModel> historyEntries = [
    HistoryEntryModel(contentId: 'c2', type: HistoryType.played, timestamp: '2h ago', progress: 0.65),
    HistoryEntryModel(contentId: 'c12', type: HistoryType.played, timestamp: 'Yesterday', progress: 1.0),
    HistoryEntryModel(contentId: 'c11', type: HistoryType.played, timestamp: '3 days ago', progress: 0.3),
    HistoryEntryModel(contentId: 'c9', type: HistoryType.read, timestamp: 'Yesterday', progress: 1.0),
    HistoryEntryModel(contentId: 'c7', type: HistoryType.read, timestamp: '4 days ago', progress: 0.8),
    HistoryEntryModel(contentId: 'c14', type: HistoryType.read, timestamp: '1 week ago', progress: 1.0),
    HistoryEntryModel(contentId: 'c1', type: HistoryType.bookmarked, timestamp: 'Saved 3 days ago'),
    HistoryEntryModel(contentId: 'c4', type: HistoryType.bookmarked, timestamp: 'Saved 5 days ago'),
    HistoryEntryModel(contentId: 'c13', type: HistoryType.bookmarked, timestamp: 'Saved 1 week ago'),
  ];

  // ---------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------
  static ContentModel? contentById(String id) {
    for (final c in allContent) {
      if (c.id == id) return c;
    }
    return null;
  }

  static List<ContentModel> get featured =>
      allContent.where((c) => c.isFeatured).toList();

  static List<ContentModel> byType(ContentType type) =>
      allContent.where((c) => c.type == type).toList();

  static List<ContentModel> byTag(String tag) =>
      allContent.where((c) => c.tags.contains(tag)).toList();

  static List<ContentModel> get richHistory => byTag('history');

  static List<ContentModel> get feedItems => byTag('micro');

  static List<ContentModel> get recommendedForYou {
    final list = List<ContentModel>.from(allContent);
    list.shuffle(Random(7));
    return list;
  }
}
