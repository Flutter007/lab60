import 'package:flutter/material.dart';

class CenterContainer extends StatelessWidget {
  final String title;
  final IconData iconData;
  final String buttonText;
  final void Function() onButtonPressed;
  const CenterContainer({
    super.key,
    required this.title,
    required this.iconData,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData, size: 100, color: theme.colorScheme.primary),
              SizedBox(height: 16),
              Text(title, style: theme.textTheme.titleMedium),
            ],
          ),
        ),
        ElevatedButton(onPressed: onButtonPressed, child: Text(buttonText)),
      ],
    );
  }
}
