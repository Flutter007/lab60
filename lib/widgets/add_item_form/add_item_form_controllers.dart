import 'package:flutter/material.dart';

class AddItemFormControllers {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageURLController = TextEditingController();
  final dateController = TextEditingController();

  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    imageURLController.dispose();
    dateController.dispose();
  }
}
