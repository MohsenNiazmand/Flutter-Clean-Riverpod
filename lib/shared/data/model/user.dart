class User {

  User({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.fullName,
    this.dateJoined,
    this.isActive,
    this.notesCount,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        username = json['username'] as String?,
        email = json['email'] as String?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?,
        fullName = json['full_name'] as String?,
        dateJoined = json['date_joined'] as String?,
        isActive = json['is_active'] as bool?,
        notesCount = json['notes_count'] as int?;
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? dateJoined;
  final bool? isActive;
  final int? notesCount;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'username' : username,
    'email' : email,
    'first_name' : firstName,
    'last_name' : lastName,
    'full_name' : fullName,
    'date_joined' : dateJoined,
    'is_active' : isActive,
    'notes_count' : notesCount
  };
}
