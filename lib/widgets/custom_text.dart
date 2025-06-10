import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String txt;
  const CustomText({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        txt,
        style: titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
