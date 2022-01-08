import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final Timestamp creation_time;
  final String point;
  final String rank;
  final bool is_dark_theme;

  User(
      {required this.name,
      required this.email,
      required this.creation_time,
      required this.point,
      required this.rank,
      required this.is_dark_theme});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [name, email, creation_time, point, rank, is_dark_theme];

  static User fromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot);
    User user = User(
      name: snapshot['name'],
      email: snapshot['email'],
      creation_time: snapshot['creation_time'],
      point: snapshot['point'],
      rank: snapshot['rank'],
      is_dark_theme: snapshot['is_dark_theme'],
    );
    return user;
  }
}
