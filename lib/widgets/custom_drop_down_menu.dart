import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  final List<DropdownMenuEntry> dropdownMenuEntries;
  final String? initialSelection;
  final bool isError;
  final String label;
  final void Function(String?) onSelected;
  const CustomDropDownMenu({
    super.key,
    this.isError = false,
    required this.dropdownMenuEntries,
    required this.initialSelection,
    required this.onSelected,
    required this.label,
  });

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 380,
      label: Text(widget.label),
      initialSelection: widget.initialSelection,
      errorText: widget.isError ? 'Select something..' : null,
      dropdownMenuEntries: widget.dropdownMenuEntries,
      onSelected: (value) => widget.onSelected(value),
    );
  }
}
