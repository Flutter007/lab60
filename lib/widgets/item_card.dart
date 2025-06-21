import 'package:flutter/material.dart';
import '../helpers/date_format.dart';
import '../models/item.dart';
import 'custom_text.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final void Function() onTap;
  const ItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 9,
          child: Column(
            children: [
              ListTile(
                title: Text('Name :'),
                subtitle: CustomText(txt: item.name),
              ),
              ListTile(
                title: Text('Category :'),
                subtitle: CustomText(txt: item.itemCategory!.title),
              ),
              ListTile(
                title: Text('Located at :'),
                subtitle: CustomText(txt: item.itemLocation!.title),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomText(txt: dateFormat.format(item.registeredAt)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
