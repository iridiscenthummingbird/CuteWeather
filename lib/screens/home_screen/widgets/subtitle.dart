import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({
    Key? key,
    required this.subtitle,
  }) : super(key: key);
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: Align(
        child: Text(
          subtitle,
          style: const TextStyle(fontSize: 20),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
