import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedItemCategory = StateProvider<String?>((ref) => null);

final selectedItemLocation = StateProvider<String?>((ref) => null);

final selectedDateProvider = StateProvider<DateTime>(
  (ref) =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
);
