import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lab60/widgets/add_item_form/add_item_form_controllers.dart';
import 'package:lab60/widgets/center_indicator.dart';
import '../../providers/items_locations_categories_providers.dart';
import '../../providers/items_provider.dart';
import '../custom_text_form_field.dart';

class AddItemForm extends ConsumerStatefulWidget {
  final AddItemFormControllers controllers;
  final bool isCategoryError;
  final bool isLocationError;
  final void Function()? addNewItem;
  const AddItemForm({
    super.key,
    required this.controllers,
    required this.addNewItem,
    required this.isCategoryError,
    required this.isLocationError,
  });

  @override
  ConsumerState<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends ConsumerState<AddItemForm> {
  final dateFormat = DateFormat('dd.MM.yyyy');
  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    final selectedDate = ref.read(selectedDateProvider.notifier).state;
    widget.controllers.dateController.text = dateFormat.format(selectedDate);
  }

  void showDatePickerFunc() async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year, now.month - 1, now.day),
      lastDate: DateTime(now.year, now.month, now.day + 1),
    );
    if (dateTime != null) {
      ref.read(selectedDateProvider.notifier).state = dateTime;
      widget.controllers.dateController.text = dateFormat.format(
        ref.read(selectedDateProvider.notifier).state,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemCategory = ref.watch(selectedItemCategory);
    final itemCategoriesProvider = ref.watch(itemsCategoriesProvider);
    final itemLocation = ref.watch(selectedItemLocation);
    final itemLocationsProvider = ref.watch(itemsLocationProvider);
    final itemAddingState = ref.watch(createItemProvider);
    return Form(
      key: widget.controllers.formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextFormField(
              labelText: 'Enter item name :',
              helperText: 'Example: Chair',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Item name';
                }
                return null;
              },
              controller: widget.controllers.nameController,
            ),
            SizedBox(height: 20),
            DropdownMenu(
              label: Text('Choose category'),
              width: 370,
              key: ValueKey('dropdown-category-$itemCategory'),
              onSelected: (value) {
                ref.read(selectedItemCategory.notifier).state = value;
              },
              initialSelection: itemCategory,
              errorText:
                  widget.isCategoryError ? 'Please choose category' : null,
              dropdownMenuEntries:
                  itemCategoriesProvider
                      .map(
                        (c) => DropdownMenuEntry(value: c.id, label: c.title),
                      )
                      .toList(),
            ),
            SizedBox(height: 20),
            DropdownMenu(
              label: Text('Choose location'),
              width: 370,
              key: ValueKey('dropdown-location-$itemLocation'),
              onSelected: (value) {
                ref.read(selectedItemLocation.notifier).state = value;
              },
              initialSelection: itemLocation,
              errorText:
                  widget.isLocationError ? 'Please choose location' : null,
              dropdownMenuEntries:
                  itemLocationsProvider
                      .map(
                        (c) => DropdownMenuEntry(value: c.id, label: c.title),
                      )
                      .toList(),
            ),
            CustomTextFormField(
              controller: widget.controllers.descriptionController,
              validator: null,
              labelText: 'Enter description :',
              helperText: 'Not required',
            ),
            CustomTextFormField(
              labelText: 'Enter Image Link',
              helperText: 'Example: https://example.com/image.jpg',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter image link';
                }
                return null;
              },
              controller: widget.controllers.imageURLController,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: widget.controllers.dateController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Enter date'),
                onTap: showDatePickerFunc,
              ),
            ),
            ElevatedButton(
              onPressed: itemAddingState.isLoading ? null : widget.addNewItem,
              child:
                  itemAddingState.isLoading ? CenterIndicator() : Text('Add +'),
            ),
          ],
        ),
      ),
    );
  }
}
