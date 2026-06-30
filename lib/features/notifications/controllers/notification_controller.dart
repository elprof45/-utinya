import 'package:egliloo/data/models/category_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationModel>[
    NotificationModel(
      id: 'n1',
      type: NotificationType.proverb,
      title: 'Proverbe du jour',
      body:
          '"L\'eau que tu portes dans tes mains ne te désaltère pas." — Wolof',
      isRead: false,
      createdAt: DateTime.now(),
    ),
    NotificationModel(
      id: 'n2',
      type: NotificationType.newContent,
      title: 'Nouveau conte disponible',
      body: 'Découvrez "Les Enfants de l\'Okapi" par Aminata Kouyaté',
      isRead: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationModel(
      id: 'n3',
      type: NotificationType.badge,
      title: 'Nouveau badge !',
      body: 'Vous avez obtenu le badge "Lecteur Assidu" 🏅',
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ].obs;

  void markAsRead(String id) {
    final i = notifications.indexWhere((n) => n.id == id);
    if (i >= 0) {
      final n = notifications[i];
      notifications[i] = NotificationModel(
        id: n.id,
        type: n.type,
        title: n.title,
        body: n.body,
        isRead: true,
        createdAt: n.createdAt,
      );
    }
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;
}
