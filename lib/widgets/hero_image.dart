import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    @required this.path,
    @required this.sementicLabel,
  }) : super(key: key);

  final String? path, sementicLabel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02),
        child: SvgPicture.asset(
          path!,
          semanticsLabel: sementicLabel,
        ),
      ),
    );
  }
}
