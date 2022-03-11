import 'package:flutter/material.dart';

class RankListTile extends StatelessWidget {
  String title;
  String sub_title;
  int index;
  String trailing;
  Color? rank_color;
  double? radius;
  bool isMe;
  RankListTile({
    required this.title,
    required this.sub_title,
    required this.index,
    required this.trailing,
    this.rank_color,
    required this.radius,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: isMe == true ? Text('${title} ( You )') : Text(title),
      subtitle: Text(sub_title),
      leading: CircleAvatar(
        radius: 22.0,
        backgroundColor: rank_color,
        child: CircleAvatar(
          backgroundColor: Colors.teal,
          radius: radius,
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      trailing: Text(trailing),
    );
  }
}
