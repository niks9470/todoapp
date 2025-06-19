import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/task_model.dart';
import '../../home/controllers/home_controller.dart';

class AddTaskViewController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  int selectedPriority = 2;
  DateTime? dueDate;

  final HomeController homeController = Get.find();
  Task? existingTask;

  void init(Task? task) {
    existingTask = task;
    if (task != null) {
      titleCtrl.text = task.title;
      descCtrl.text = task.description;
      selectedPriority = task.priority;
      dueDate = task.dueDate;
    }
  }

  void setPriority(int val) {
    selectedPriority = val;
    update();
  }

  void setDueDate(DateTime date) {
    dueDate = date;
    update();
  }

  void submit(BuildContext context)async {
    if (!formKey.currentState!.validate() || dueDate == null) {
      if (dueDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a due date')),
        );
      }
      return;
    }
    final task = Task(
      id: existingTask?.id ?? Random().nextInt(1 << 31).toString(), // 32-bit int
      title: titleCtrl.text,
      description: descCtrl.text,
      dueDate: dueDate!,
      priority: selectedPriority,
    );
    if (existingTask == null) {
      await homeController.addTask(task);
    } else {
      await homeController.updateTask(task);
    }
    Navigator.of(context).pop();
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.onClose();
  }
}