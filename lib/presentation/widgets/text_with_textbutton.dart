import 'package:flutter/material.dart';

class TextWithTextButton extends StatelessWidget {
  const TextWithTextButton({
    Key? key,
    @required this.text,
    @required this.textButtonText,
    @required this.onPressed,
  }) : super(key: key);

  final String? text, textButtonText;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text!),
          TextButton(
            child: Text(textButtonText!),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
