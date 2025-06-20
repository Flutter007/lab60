import 'package:flutter/material.dart';
import 'package:lab60/widgets/custom_text_form_field.dart';

class UniversalAddForm extends StatefulWidget {
  final TextEditingController titleController;
  final GlobalKey<FormState> formKey;
  const UniversalAddForm({
    super.key,
    required this.formKey,
    required this.titleController,
  });

  @override
  State<UniversalAddForm> createState() => _UniversalAddFormState();
}

class _UniversalAddFormState extends State<UniversalAddForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: 'Enter Category Name ',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Category name is required';
              }
              return null;
            },
            controller: widget.titleController,
          ),
        ],
      ),
    );
  }
}
