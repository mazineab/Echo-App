import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/widgets/custom_button.dart';
import 'package:myapp/common/widgets/custom_text_fields.dart';
import 'package:myapp/common/widgets/custom_text_navigation.dart';
import 'package:myapp/featues/auth/controllers/auth_controller.dart';
import 'package:myapp/routes/routes_names.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 7),
                const Text("Sign in to start sharing your updates!",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: MediaQuery.of(context).size.height / 6),
                CustomTextFeild(
                    label: "Email",
                    controller: controller.emailController,
                    isPassword: false),
                const SizedBox(height: 16.0),
                CustomTextFeild(
                    label: "Password",
                    controller: controller.passwordController,
                    isPassword: true),
                const SizedBox(height: 32.0),
                Obx(()=>
                   CustomButton(
                      child:controller.isload.value
                      ? const CircularProgressIndicator(color: Colors.white,)
                       : const Text('Login'),
                      onTap: () {
                        controller.login();
                      }),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                CustomTextNavigation(
                    firstText: "You dont have account?",
                    secondText: "create one!",
                    onTap: () => Get.offNamed(RoutesNames.register))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
