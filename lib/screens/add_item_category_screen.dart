import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lab60/widgets/add_item_category_location_form/add_item_category_form.dart';

import '../providers/items_locations_categories_date_providers.dart';
import '../widgets/add_item_category_location_form/add_item_category_form_controllers.dart';

class AddItemCategoryScreen extends ConsumerStatefulWidget {
  const AddItemCategoryScreen({super.key});

  @override
  ConsumerState createState() => _AddItemCategoryScreenState();
}

class _AddItemCategoryScreenState extends ConsumerState<AddItemCategoryScreen> {
  final controller = AddItemCategoryLocationFormControllers();
  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void onSave() {
    if (controller.formKey.currentState!.validate()) {
      ref
          .read(createItemCategoryProvider.notifier)
          .createItemCategory(controller);
    }
  }

  void checkStatusOfAction() {
    ref.listen(createItemCategoryProvider, (prev, next) {
      next.whenOrNull(
        data: (d) {
          showSnackBarMessage('Successfully added');
        },
        error: (e, stack) {
          showSnackBarMessage('Something went wrong...');
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final creatingState = ref.watch(createItemCategoryProvider).isLoading;
    checkStatusOfAction();
    return Scaffold(
      appBar: AppBar(title: Text('Add item Category to BD')),
      body: AddItemCategoryLocationForm(
        controller: controller,
        addNewItem: onSave,
        titleFieldText: 'Enter category name :',
        descriptionFieldText: 'Enter description :',
        imageURLFieldText: 'Enter Image Link',
        titleValidator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter category name';
          }
          return null;
        },
        descriptionValidator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter description';
          }
          return null;
        },
        imageURLValidator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter image link';
          }
          return null;
        },
        isLoading: creatingState,
      ),
    );
  }
}
