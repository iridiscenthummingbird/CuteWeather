import 'package:flutter/material.dart';

class CustomTooltip extends StatelessWidget {
  const CustomTooltip({
    Key? key,
    required this.message,
    required this.value,
    required this.image,
  }) : super(key: key);
  final String message;
  final int value;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 14),
          ),
          Padding(
            child: Image.asset(
              image,
              height: 14,
              width: 14,
            ),
            padding: const EdgeInsets.only(left: 5.0),
          )
        ],
      ),
    );
  }
}
