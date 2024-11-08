import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Constants/colors.dart';
import 'package:myapp/common/widgets/custom_button.dart';
import 'package:myapp/common/widgets/custom_text_fields.dart';
import 'package:myapp/featues/auth/controllers/auth_controller.dart';

import '../../../common/widgets/custom_text_navigation.dart';
import '../../../routes/routes_names.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:MyColors.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 8),
              const Text("Sign up to start sharing your updates!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFeild(
                        hasMargin: false,
                        label: "First Name",
                        controller: controller.firstNameController,
                        isPassword: false),
                  ),
                  Expanded(
                    child: CustomTextFeild(
                        hasMargin: false,
                        label: "Last Name",
                        controller: controller.lastNameController,
                        isPassword: false),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              CustomTextFeild(
                  label: "Email",
                  controller: controller.emailController,
                  isPassword: false),
              const SizedBox(height: 16.0),
              CustomTextFeild(
                  label: "Phone number",
                  controller: controller.phoneController,
                  isPassword: false),
              const SizedBox(height: 16.0),
              CustomTextFeild(
                  label: "Password",
                  controller: controller.passwordController,
                  isPassword: true),
              const SizedBox(height: 16.0),
              GetBuilder<AuthController>(
                builder: (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(activeColor: Colors.white,
                        value: "Male",
                        groupValue: controller.sexeVal,
                        onChanged: (val) {
                          controller.changeSexeVal(val ?? "");
                        }),
                    const Text("Male",style: TextStyle(color: Colors.white)),
                    const SizedBox(
                      width: 50,
                    ),
                    Radio(
                      activeColor: Colors.white,
                        value: "Femel",
                        groupValue: controller.sexeVal,
                        onChanged: (val) {
                          controller.changeSexeVal(val ?? "");
                        }),
                    const Text("Femel",style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Obx(
                () => CustomButton(
                    onTap: controller.register,
                    child: controller.isload.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Register")),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              CustomTextNavigation(
                  firstText: "You have account?",
                  secondText: "sign in!",
                  onTap: () => Get.offNamed(RoutesNames.login))
            ],
          ),
        ),
      ),
    );
  }
}
