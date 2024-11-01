/// User model class
class User {
  final String id;
  final String name;
  final String locale;
  final String email;
  final String preferredUsername;
  final String givenName;
  final String familyName;
  final String zoneInfo;
  final int updatedAt;
  final bool emailVerified;
  final String firstName;

  User({
    required this.id,
    required this.name,
    required this.locale,
    required this.email,
    required this.preferredUsername,
    required this.givenName,
    required this.familyName,
    required this.zoneInfo,
    required this.updatedAt,
    required this.emailVerified,
    required this.firstName,
  });

  /// Create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['sub'],
      name: json['name'],
      locale: json['locale'],
      email: json['email'],
      preferredUsername: json['preferred_username'],
      givenName: json['given_name'],
      familyName: json['family_name'],
      zoneInfo: json['zoneinfo'],
      updatedAt: json['updated_at'],
      emailVerified: json['email_verified'],
      firstName: json['firstname'],
    );
  }

  /// Convert the User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'sub': id,
      'name': name,
      'locale': locale,
      'email': email,
      'preferred_username': preferredUsername,
      'given_name': givenName,
      'family_name': familyName,
      'zoneinfo': zoneInfo,
      'updated_at': updatedAt,
      'email_verified': emailVerified,
      'firstname': firstName,
    };
  }
}
