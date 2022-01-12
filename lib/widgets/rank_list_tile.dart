import 'package:flutter/material.dart';

class RankListTile extends StatelessWidget {
  String title;
  String sub_title;
  int index;
  String trailing;
  Color? rank_color;
  RankListTile({
    required this.title,
    required this.sub_title,
    required this.index,
    required this.trailing,
    this.rank_color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(sub_title),
      leading: CircleAvatar(
          radius: 22.0,
          backgroundColor: rank_color,
          child:
              CircleAvatar(radius: 20.0, child: Text((index + 1).toString()))),
      trailing: Text(trailing),
    );
  }
}
