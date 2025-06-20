import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/widgets/add_item_category_location_form/add_item_category_form.dart';

import '../providers/items_locations_categories_date_providers.dart';
import '../widgets/add_item_category_location_form/add_item_category_form_controllers.dart';

class AddItemLocationScreen extends ConsumerStatefulWidget {
  const AddItemLocationScreen({super.key});

  @override
  ConsumerState createState() => _AddItemLocationScreenState();
}

class _AddItemLocationScreenState extends ConsumerState<AddItemLocationScreen> {
  final controller = AddItemCategoryLocationFormControllers();
  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void onSave() {
    if (controller.formKey.currentState!.validate()) {
      ref
          .read(createItemLocationProvider.notifier)
          .createItemLocation(controller);
    }
  }

  void checkStatusOfAction() {
    ref.listen(createItemLocationProvider, (prev, next) {
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final creatingState = ref.watch(createItemLocationProvider).isLoading;
    checkStatusOfAction();
    return Scaffold(
      appBar: AppBar(title: Text('Add Location to BD')),
      body: Center(
        child: AddItemCategoryLocationForm(
          controller: controller,
          addNewItem: onSave,
          titleFieldText: 'Enter Location name :',
          descriptionFieldText: 'Enter description: ',
          imageURLFieldText: 'Enter Image Link',
          titleValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter location name';
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
      ),
    );
  }
}
