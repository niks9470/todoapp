import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/customAppBar.dart';
import '../../../widgets/customDialogBox.dart';
import '../../add_task_view/views/add_task_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final controller = Get.find<HomeController>();

  Color getPriorityColor(int p) {
    return switch (p) {
      1 => Colors.red,
      2 => Colors.orange,
      3 => Colors.green,
      _ => Colors.grey,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: "To do List"),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F6FD), Color(0xFFE9F0FB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
              child: TextField(
                controller: controller.searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (val) => controller.searchQuery.value = val,
              ),
            ),
            SizedBox(height: 6.sp,),
            Expanded(
              child: Obx(() {
                final sortedTasks = List.of(controller.filteredTasks)
                  ..sort((a, b) => a.priority.compareTo(b.priority));
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  itemCount: sortedTasks.length,
                  itemBuilder: (context, index) {
                    final task = sortedTasks[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => AddTaskView(existingTask: task)),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    task.title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert),
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      Get.to(() => AddTaskView(existingTask: task));
                                    } else if (value == 'delete') {
                                      showDialog(
                                        context: context,
                                        builder: (context) => CustomDialogBox(
                                          title: 'Delete Task',
                                          content: 'Are you sure you want to delete this task?',
                                          leftButtonText: 'Cancel',
                                          rightButtonText: 'Delete',
                                          onLeftPressed: () => Navigator.of(context).pop(),
                                          onRightPressed: () {
                                            controller.deleteTask(task.id);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 0),
                            Text(
                              task.description,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Due: ${task.dueDate.toLocal().toString().split(' ')[0]}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6D5DF6),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Get.to(() => const AddTaskView()),
      ),
    );
  }
}