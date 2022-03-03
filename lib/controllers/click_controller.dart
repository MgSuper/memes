import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClickController extends GetxController {
// Check Clicked Count for guest user
  bool checkClickedCount() {
    GetStorage storage = GetStorage();
    String currentTimeString = DateTime.now().toString().substring(0, 10);
    final count = storage.read('count') ?? 0;
    print(count);
    // For setting the storage for the first time
    if (count == 0) {
      storage.write('count', 1);
      storage.write('date', currentTimeString);
      return true;
    } else {
      String? currentDateFromStorage = storage.read('date');
      if (isSameDay(currentDateFromStorage)) {
        if (count < 20) {
          storage.write('count', count + 1);
          return true;
        } else {
          return false;
        }
      } else {
        storage.write('count', 1);
        storage.write('date', currentTimeString);
        return true;
      }
    }
  }

  // Check whether it is the same day
  bool isSameDay(dateString) {
    DateTime checkedTime = DateTime.parse(dateString);
    DateTime currentTime = DateTime.now();
    if (checkedTime.day == currentTime.day &&
        checkedTime.month == currentTime.month &&
        checkedTime.year == currentTime.year) {
      return true;
    } else {
      return false;
    }
  }
}
