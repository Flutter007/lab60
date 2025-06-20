import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/models/item_category.dart';
import 'package:lab60/models/item_location.dart';
import 'package:lab60/providers/image_upload_provider.dart';
import 'package:lab60/widgets/add_item_form/add_item_form_controllers.dart';
import 'package:lab60/widgets/center_indicator.dart';
import 'package:lab60/widgets/image_picker_field.dart';
import '../../helpers/date_format.dart';
import '../../providers/items_locations_categories_date_providers.dart';
import '../../providers/items_provider.dart';
import '../custom_drop_down_menu.dart';
import '../custom_text_form_field.dart';

class AddItemForm extends ConsumerStatefulWidget {
  final AddItemFormControllers controllers;
  final bool isCategoryError;
  final bool isLocationError;
  final List<ItemLocation>? itemLocations;
  final List<ItemCategory>? itemCategories;
  final void Function()? addNewItem;
  const AddItemForm({
    super.key,
    required this.controllers,
    required this.addNewItem,
    required this.isCategoryError,
    required this.isLocationError,
    required this.itemLocations,
    required this.itemCategories,
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
    final Widget body = Form(
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
                    return 'Please enter item name';
                  }
                  return null;
                },
                controller: widget.controllers.nameController,
              ),

              CustomTextFormField(
                controller: widget.controllers.descriptionController,
                validator: null,
                labelText: 'Enter description :',
                helperText: 'Not required',
              ),
              SizedBox(height: 20),
              CustomDropDownMenu(
                label:
                    widget.itemCategories!.isNotEmpty
                        ? 'Select category :'
                        : 'Categories are empty',
                initialSelection: ref.read(selectedItemCategory.notifier).state,
                dropdownMenuEntries:
                    widget.itemCategories!
                        .map(
                          (i) => DropdownMenuEntry(value: i.id, label: i.title),
                        )
                        .toList(),
                onSelected: (value) {
                  ref.read(selectedItemCategory.notifier).state = value;
                },
                isError: widget.isCategoryError,
              ),
              SizedBox(height: 20),

              CustomDropDownMenu(
                label:
                    widget.itemLocations!.isNotEmpty
                        ? 'Select location :'
                        : 'Locations are empty',
                initialSelection: ref.read(selectedItemLocation.notifier).state,
                dropdownMenuEntries:
                    widget.itemLocations!
                        .map(
                          (i) => DropdownMenuEntry(value: i.id, label: i.title),
                        )
                        .toList(),
                onSelected: (value) {
                  ref.read(selectedItemLocation.notifier).state = value;
                },
                isError: widget.isLocationError,
              ),
              SizedBox(height: 20),
              ImagePickerField(
                onPickImage: (image) {
                  ref.read(selectedItemImage.notifier).state = image;
                },
                imageProvider: selectedItemImage,
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
    return Center(child: body);
  }
}
