import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String creationTime;
  final String point;
  final String rank;

  User(
      {required this.name,
      required this.email,
      required this.creationTime,
      required this.point,
      required this.rank});

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, creationTime, point, rank];

  static User fromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot);
    User user = User(
      name: snapshot['name'],
      email: snapshot['email'],
      creationTime: snapshot['creationTime'],
      point: snapshot['point'],
      rank: snapshot['rank'],
    );
    return user;
  }
}
