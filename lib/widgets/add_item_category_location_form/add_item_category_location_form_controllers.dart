import 'package:flutter/cupertino.dart';

class AddItemCategoryLocationFormControllers {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }
}
