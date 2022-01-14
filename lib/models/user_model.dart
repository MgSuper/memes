import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String user_id;
  final String name;
  final String email;
  final Timestamp creation_time;
  final int point;
  final String rank;

  UserModel({
    required this.user_id,
    required this.name,
    required this.email,
    required this.creation_time,
    required this.point,
    required this.rank,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [user_id, name, email, creation_time, point, rank];

  static UserModel fromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot);
    UserModel user = UserModel(
      user_id: snapshot['user_id'],
      name: snapshot['name'],
      email: snapshot['email'],
      creation_time: snapshot['creation_time'],
      point: snapshot['point'],
      rank: snapshot['rank'],
    );
    return user;
  }
}
