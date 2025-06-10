import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/providers/items_provider.dart';
import 'package:lab60/widgets/add_item_form/add_item_form.dart';

import '../providers/items_locations_categories_date_providers.dart';
import '../widgets/add_item_form/add_item_form_controllers.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key});

  @override
  ConsumerState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  final controllers = AddItemFormControllers();
  bool isCategoryError = false;
  bool isLocationError = false;

  bool checkCategoryAndLocationState() {
    final selectedCategory = ref.read(selectedItemCategory);
    final selectedLocation = ref.read(selectedItemLocation);
    setState(() {
      isCategoryError = selectedCategory == null;
      isLocationError = selectedLocation == null;
    });
    return isCategoryError || isLocationError;
  }

  void _showScaffoldMessage(String txt) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(txt)));
  }

  void addItem() async {
    bool isSelectedError = checkCategoryAndLocationState();
    if (controllers.formKey.currentState!.validate() && !isSelectedError) {
      await ref.read(createItemProvider.notifier).createItem(controllers);
      if (mounted) {
        clearControllers();
        Navigator.pop(context, true);
      }
    }
  }

  void checkStatusOfAction() {
    ref.listen(createItemProvider, (prev, next) {
      next.whenOrNull(
        data: (d) {
          _showScaffoldMessage('Successfully added');
        },
        error: (e, stack) {
          _showScaffoldMessage('Something went wrong...');
        },
      );
    });
  }

  void clearControllers() {
    controllers.nameController.clear();
    if (controllers.descriptionController.text.trim().isNotEmpty) {
      controllers.descriptionController.clear();
    }
    controllers.imageURLController.clear();
    controllers.dateController.clear();
    ref.read(selectedItemCategory.notifier).state = null;
    ref.read(selectedItemLocation.notifier).state = null;
    ref.read(selectedDateProvider.notifier).state = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
  }

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkStatusOfAction();
    return Scaffold(
      appBar: AppBar(title: Text('Add item to BD')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddItemForm(
              controllers: controllers,
              addNewItem: addItem,
              isCategoryError: isCategoryError,
              isLocationError: isLocationError,
            ),
          ],
        ),
      ),
    );
  }
}
