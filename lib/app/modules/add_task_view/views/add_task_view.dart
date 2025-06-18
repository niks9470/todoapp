import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/task_model.dart';
import '../../../widgets/customAppBar.dart';
import '../controllers/add_task_view_controller.dart';

class AddTaskView extends StatelessWidget {
  final Task? existingTask;

  const AddTaskView({super.key, this.existingTask});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTaskViewController>(
      init: AddTaskViewController()..init(existingTask),
      builder: (controller) => Scaffold(
        appBar: CustomAppBarWidget(
          title: existingTask == null ? "Add Task" : "Edit Task",
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Card(
              elevation: 8,
              margin: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        existingTask == null ? "Create New Task" : "Edit Task",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: controller.titleCtrl,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          prefixIcon: const Icon(Icons.title),
                        ),
                        validator: (value) => value == null || value.trim().isEmpty ? 'Title is required' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: controller.descCtrl,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          prefixIcon: const Icon(Icons.description),
                        ),
                        maxLines: 2,
                        validator: (value) => value == null || value.trim().isEmpty ? 'Description is required' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        value: controller.selectedPriority,
                        items: const [
                          DropdownMenuItem(value: 1, child: Text('High')),
                          DropdownMenuItem(value: 2, child: Text('Medium')),
                          DropdownMenuItem(value: 3, child: Text('Low')),
                        ],
                        onChanged: (val) => controller.setPriority(val!),
                        decoration: InputDecoration(
                          labelText: 'Priority',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          prefixIcon: const Icon(Icons.flag),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          controller.dueDate == null
                              ? "Choose Due Date"
                              : DateFormat.yMMMEd().format(controller.dueDate!),
                          style: TextStyle(
                            color: controller.dueDate == null ? Colors.grey : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(Icons.calendar_today, color: Colors.deepPurple),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: controller.dueDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) controller.setDueDate(picked);
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.submit(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Save Task", style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}