import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout_screen.dart';
import 'package:social/modules/register_social/register_cubit/cubit_register.dart';
import 'package:social/modules/register_social/register_cubit/states_register.dart';
import 'package:social/shared/componets/components.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import 'package:social/shared/styles/style.dart';

class RegisterSocialScreen extends StatelessWidget {


  const RegisterSocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailRegisterController = TextEditingController();
    var passwordController = TextEditingController();
    var nameRegisterController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocilaRegisterStates>(
          listener: (context, state) {
            if(state is SocilaRegisterSuccessStates)
              {
                CacheHelper.saveData(key: 'uId', value: state.uid).then((value) => {
                  navigateAndFinish(context, const HomeLayoutScreen())
                });
              }
          },
          builder: (context, state) {
            return Scaffold(
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 100.0,
                            ),
                            Center(
                              child: Container(
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: colorAll),
                                  child: const Icon(
                                    Icons.lock_outlined,
                                    size: 50.0,
                                    color: Colors.white,
                                  )),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w600,
                                color: colorAll,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        textFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'enter user name';
                            }
                            return null;
                          },
                          controller: nameRegisterController,
                          label: 'Name',
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        textFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'enter the email address';
                            }
                            return null;
                          },
                          controller: emailRegisterController,
                          label: 'Email',
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        textFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'enter the password';
                            }
                            return null;
                          },
                          suffix: SocialRegisterCubit.get(context).prefix,
                          obscureText:
                              SocialRegisterCubit.get(context).isPassword,
                          controller: passwordController,
                          suffixPassword: () {
                            SocialRegisterCubit.get(context)
                                .changeRegisterPasswordVisibility();
                          },
                          label: 'Password',
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        textFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'enter the phone';
                            }
                            return null;
                          },
                          controller: phoneController,
                          label: 'Phone',
                          textInputType: TextInputType.phone,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocilaRegisterLoadingStates,
                          builder: (BuildContext context) => Center(
                            child: elevatedItemBuilder(
                              text: 'Register',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                    name: nameRegisterController.text,
                                    email: emailRegisterController.text,
                                    password: passwordController.text,
                                    phone: passwordController.text,
                                  );
                                }
                              },
                              width: 350.0,
                              color: colorAll,
                            ),
                          ),
                          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
