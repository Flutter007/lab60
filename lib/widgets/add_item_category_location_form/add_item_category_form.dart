import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/widgets/center_indicator.dart';

import '../custom_text_form_field.dart';
import 'add_item_category_form_controllers.dart';

class AddItemCategoryLocationForm extends ConsumerStatefulWidget {
  final AddItemCategoryLocationFormControllers controller;
  final String titleFieldText;
  final String descriptionFieldText;
  final String imageURLFieldText;
  final String? Function(String?)? titleValidator;
  final String? Function(String?)? descriptionValidator;
  final String? Function(String?)? imageURLValidator;
  final void Function()? addNewItem;
  final bool isLoading;

  const AddItemCategoryLocationForm({
    super.key,
    required this.controller,
    required this.addNewItem,
    required this.titleFieldText,
    required this.descriptionFieldText,
    required this.imageURLFieldText,
    required this.titleValidator,
    required this.descriptionValidator,
    required this.imageURLValidator,
    required this.isLoading,
  });

  @override
  ConsumerState<AddItemCategoryLocationForm> createState() =>
      _AddItemCategoryFormState();
}

class _AddItemCategoryFormState
    extends ConsumerState<AddItemCategoryLocationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: widget.titleFieldText,
            validator: widget.titleValidator,
            controller: widget.controller.titleController,
          ),
          CustomTextFormField(
            labelText: widget.descriptionFieldText,
            validator: widget.descriptionValidator,
            controller: widget.controller.descriptionController,
          ),
          CustomTextFormField(
            labelText: widget.imageURLFieldText,
            validator: widget.imageURLValidator,
            controller: widget.controller.imageURLController,
          ),
          ElevatedButton.icon(
            onPressed: widget.isLoading ? null : widget.addNewItem,
            label:
                widget.isLoading
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
                    : Text('Add'),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
