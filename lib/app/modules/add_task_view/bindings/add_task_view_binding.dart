import 'package:get/get.dart';

import '../controllers/add_task_view_controller.dart';

class AddTaskViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTaskViewController>(
      () => AddTaskViewController(),
    );
  }
}
