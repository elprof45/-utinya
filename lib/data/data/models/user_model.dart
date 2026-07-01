class UserModel {
  String name;
  String email;
  int avatarColorIndex;
  List<String> interests;
  String language;
  double hoursListened;
  int storiesRead;
  int proverbsSaved;
  int videosWatched;
  String joinDate;
  bool isAuthenticated;

  UserModel({
    this.name = 'Amara Diallo',
    this.email = 'amara.diallo@example.com',
    this.avatarColorIndex = 0,
    this.interests = const [],
    this.language = 'English',
    this.hoursListened = 0,
    this.storiesRead = 0,
    this.proverbsSaved = 0,
    this.videosWatched = 0,
    this.joinDate = 'June 2026',
    this.isAuthenticated = false,
  });
}
