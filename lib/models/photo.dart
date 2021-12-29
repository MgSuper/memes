import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum PhotoTypes { ALL, MEMES, CARTOONS, CELEBRITIES, OHNO }

class Photo extends Equatable {
  final String name;
  final String category;
  final String imageUrl;

  const Photo({
    required this.name,
    required this.category,
    required this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, category, imageUrl];

  static Photo fromSnapshot(DocumentSnapshot snapshot) {
    Photo photo = Photo(
      name: snapshot['name'],
      category: snapshot['category'],
      imageUrl: snapshot['imageUrl'],
    );
    return photo;
  }
}
