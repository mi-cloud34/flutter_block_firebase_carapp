class User {
  final String? uid;
  final String? name;
  final String? email;
  final String? imageUrl;
  final String? role;
  final Map<String, dynamic>? lastMessage;
  final int? unreadCounter;

  User(
      {this.uid,
      this.name,
      this.email,
      this.imageUrl,
      this.role,
      this.lastMessage,
      this.unreadCounter});
}
