import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/models/item_category.dart';
import 'package:lab60/models/item_location.dart';
import 'package:lab60/widgets/add_item_form/add_item_form_controllers.dart';
import 'package:lab60/widgets/center_indicator.dart';
import '../../helpers/date_format.dart';
import '../../providers/items_locations_categories_date_providers.dart';
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
  final DateTime now = DateTime.now();
  late List<ItemCategory>? categories;
  late List<ItemLocation>? locations;

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
      lastDate: DateTime(now.year, now.month, now.day),
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
    final itemAddingState = ref.watch(createItemProvider);
    final itemCategories = ref.watch(itemCategoriesProvider).value;
    final itemLocations = ref.watch(itemLocationsProvider).value;
    final Widget body =
        itemLocations == null || itemCategories == null
            ? CenterIndicator()
            : Form(
              key: widget.controllers.formKey,
              child: SingleChildScrollView(
                child: SafeArea(
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
                      CustomTextFormField(
                        controller: widget.controllers.descriptionController,
                        validator: null,
                        labelText: 'Enter description :',
                        helperText: 'Not required',
                      ),
                      DropdownMenu(
                        width: 300,
                        label: Text('Select category :'),
                        initialSelection:
                            ref.read(selectedItemCategory.notifier).state,
                        dropdownMenuEntries:
                            itemCategories
                                .map(
                                  (i) => DropdownMenuEntry(
                                    value: i.id,
                                    label: i.title,
                                  ),
                                )
                                .toList(),
                        onSelected: (value) {
                          ref.read(selectedItemCategory.notifier).state = value;
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownMenu(
                        width: 300,
                        label: Text('Select location :'),
                        initialSelection:
                            ref.read(selectedItemLocation.notifier).state,
                        dropdownMenuEntries:
                            itemLocations
                                .map(
                                  (i) => DropdownMenuEntry(
                                    value: i.id,
                                    label: i.title,
                                  ),
                                )
                                .toList(),
                        onSelected: (value) {
                          ref.read(selectedItemLocation.notifier).state = value;
                        },
                      ),
                      CustomTextFormField(
                        labelText: 'Enter Image Link',
                        helperText: 'Example: https://example.com/image.jpg',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter image link';
                          }
                          bool isLinkRight =
                              value.contains('www') ||
                              value.contains('http') ||
                              value.contains('https');
                          if (!isLinkRight) {
                            return 'Please enter correct link';
                          }
                          return null;
                        },
                        controller: widget.controllers.imageURLController,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: TextField(
                          controller: widget.controllers.dateController,
                          readOnly: true,
                          decoration: InputDecoration(labelText: 'Enter date'),
                          onTap: showDatePickerFunc,
                        ),
                      ),
                      ElevatedButton(
                        onPressed:
                            itemAddingState.isLoading
                                ? null
                                : widget.addNewItem,
                        child:
                            itemAddingState.isLoading
                                ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Loading...'),
                                    SizedBox(width: 8),
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CenterIndicator(),
                                    ),
                                  ],
                                )
                                : Text('Add item'),
                      ),
                    ],
                  ),
                ),
              ),
            );
    return body;
  }
}
