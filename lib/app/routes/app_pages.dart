import 'package:get/get.dart';

import '../modules/add_task_view/bindings/add_task_view_binding.dart';
import '../modules/add_task_view/views/add_task_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/signIn/bindings/sign_in_binding.dart';
import '../modules/signIn/views/sign_in_view.dart';
import '../modules/signUp/bindings/sign_up_binding.dart';
import '../modules/signUp/views/sign_up_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_IN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TASK_VIEW,
      page: () => const AddTaskView(),
      binding: AddTaskViewBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () =>  SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () =>  SignUpView(),
      binding: SignUpBinding(),
    ),
  ];
}
