import 'package:get/get.dart';

class ChipController extends GetxController {
  var _selectedChip = 0.obs;
  get selectedChip => _selectedChip.value;
  set selectedChip(index) => _selectedChip.value = index ?? 0;
}
