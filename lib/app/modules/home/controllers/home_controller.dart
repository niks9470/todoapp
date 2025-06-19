
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/task_model.dart';

class HomeController extends GetxController {
  var tasks = <Task>[].obs;
  final _firestore = FirebaseFirestore.instance;

  final searchCtrl = TextEditingController();
  var searchQuery = ''.obs;

  var selectedPriority = 0.obs; // 0 = All, 1 = High, 2 = Medium, 3 = Low
  var selectedStatus = 'all'.obs; // 'all', 'complete', 'incomplete'
  List<Task> get filteredTasks {
    if (searchQuery.value.isEmpty) return tasks;
    return tasks.where((t) =>
    t.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        t.description.toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }

  @override
  void onInit() {
    super.onInit();
    listenToTasks();
  }

  void listenToTasks() {
    _firestore.collection('tasks').snapshots().listen((snapshot) {
      tasks.value = snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();
    });
  }

  Future<void> addTask(Task task) async {
    final docRef = _firestore.collection('tasks').doc(task.id);
    await docRef.set({
      ...task.toJson(),
      'id': task.id,
      'dueDate': Timestamp.fromDate(task.dueDate),
    });
  }


  Future<void> updateTask(Task updatedTask) async {
    await _firestore.collection('tasks').doc(updatedTask.id).update({
      ...updatedTask.toJson(),
      'dueDate': Timestamp.fromDate(updatedTask.dueDate),
    });
  }

  Future<void> deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }
  Future<void> toggleTaskCompleted(Task task) async {
    await _firestore.collection('tasks').doc(task.id).update({
      'completed': !task.completed,
    });
  }

}

