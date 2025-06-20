import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/providers/image_upload_provider.dart';
import 'package:path/path.dart' as path;
import 'package:lab60/widgets/add_item_category_location_form/add_item_category_location_form.dart';
import '../providers/items_locations_categories_date_providers.dart';
import '../widgets/add_item_category_location_form/add_item_category_location_form_controllers.dart';

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

  void onSave() async {
    final image = ref.read(selectedCategoryImage.notifier).state;
    final now = DateTime.now();
    if (controller.formKey.currentState!.validate() && image != null) {
      final fileName =
          '${now.microsecondsSinceEpoch}${path.extension(image.path)}';
      await ref
          .read(uploadImageProvider.notifier)
          .uploadImage(image, fileName, 'items_categories_images');
      await ref
          .read(createItemCategoryLocationProvider.notifier)
          .createItemLocationCategory(controller, fileName);
      if (mounted) {
        setState(() {
          controller.titleController.clear();
          controller.descriptionController.clear();
          ref.read(selectedCategoryImage.notifier).state = null;
        });
        ref.invalidate(itemCategoriesProvider);
      } else {
        showSnackBarMessage('Please fill all fields');
      }
    }
  }

  void checkStatusOfAction() {
    ref.listen(createItemCategoryLocationProvider, (prev, next) {
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
    final creatingState =
        ref.watch(createItemCategoryLocationProvider).isLoading;
    checkStatusOfAction();
    return Scaffold(
      appBar: AppBar(title: Text('Add Category to BD')),
      body: SingleChildScrollView(
        child: AddItemCategoryLocationForm(
          controller: controller,
          addNewItem: onSave,
          titleFieldText: 'Enter category name :',
          descriptionFieldText: 'Enter description :',

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

          isLoading: creatingState,
          imageProvider: selectedCategoryImage,
        ),
      ),
    );
  }
}
