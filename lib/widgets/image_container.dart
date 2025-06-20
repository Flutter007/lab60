import 'package:flutter/material.dart';
import 'package:lab60/widgets/custom_text.dart';

class ImageContainer extends StatelessWidget {
  final String imageDescription;
  final String imageURL;
  const ImageContainer({
    super.key,
    required this.imageURL,
    required this.imageDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(txt: imageDescription),
        Container(
          width: 200,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: NetworkImage(imageURL),
              fit: BoxFit.fill,
            ),
          ),
          margin: EdgeInsets.all(20),
        ),
      ],
    );
  }
}
