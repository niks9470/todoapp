// lib/app/modules/home/controllers/home_controller.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../data/models/task_model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  final AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class HomeController extends GetxController {
  var tasks = <Task>[].obs;
  // Add these lines inside HomeController
  final searchCtrl = TextEditingController();
  var searchQuery = ''.obs;

  List<Task> get filteredTasks {
    if (searchQuery.value.isEmpty) return tasks;
    return tasks.where((t) =>
    t.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        t.description.toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }



  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  void onInit() {
    super.onInit();
    initNotifications();
    loadTasks();
  }


  // void addTask(Task task) {
  //   tasks.add(task);
  //   saveTasks();
  // }

  // void updateTask(Task updatedTask) {
  //   final index = tasks.indexWhere((t) => t.id == updatedTask.id);
  //   if (index != -1) {
  //     tasks[index] = updatedTask;
  //     saveTasks();
  //   }
  // }

  // void deleteTask(String id) {
  //   tasks.removeWhere((t) => t.id == id);
  //   saveTasks();
  // }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((t) => t.toJson()).toList();
    prefs.setString('tasks', jsonEncode(taskList));
  }


  Future<void> scheduleTaskNotification(Task task) async {
    final scheduledTime = task.dueDate.subtract(const Duration(hours: 1));
    if (scheduledTime.isAfter(DateTime.now())) {
      final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);
      await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse(task.id),
        'Task Reminder',
        'Your task "${task.title}" is due soon!',
        tzScheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails('task_channel', 'Task Reminders'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    }
  }

  Future<void> cancelTaskNotification(String taskId) async {
    await flutterLocalNotificationsPlugin.cancel(int.parse(taskId));
  }

  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
    scheduleTaskNotification(task);
  }

  void updateTask(Task updatedTask) {
    final index = tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
      saveTasks();
      cancelTaskNotification(updatedTask.id);
      scheduleTaskNotification(updatedTask);
    }
  }

  void deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);
    saveTasks();
    cancelTaskNotification(id);
  }



  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tasks');
    if (data != null) {
      final List decoded = jsonDecode(data);
      tasks.value = decoded.map((e) => Task.fromJson(e)).toList();
    }
  }
}