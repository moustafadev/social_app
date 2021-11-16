import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social/layout/home_layout_screen.dart';
import 'package:social/modules/register_social/register_screen.dart';
import 'package:social/shared/componets/components.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import 'package:social/shared/styles/style.dart';

import 'login_cubit/cubit_login.dart';
import 'login_cubit/states_login.dart';

class LoginSocialScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocilaLoginStates>(
          listener: (context, state) {
            if(state is SocilaLoginErrorStates)
              {
                showToast(text: state.error,color: HexColor('000814'));
              }
            if(state is SocilaLoginSuccessStates)
              {
                CacheHelper.saveData(key: 'uId', value: state.uId).then((value) => {
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
                                    width: 150.0,
                                    height: 150.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: colorAll),
                                    child: const Icon(
                                      Icons.email_outlined,
                                      size: 60.0,
                                      color: Colors.white,
                                    ))),
                            const SizedBox(
                              height: 50.0,
                            ),
                            Text(
                              'Login',
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
                              return 'enter the emil address';
                            }
                            return null;
                          },
                          controller: _emailController,
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
                          suffix: SocialLoginCubit.get(context).prefix,
                          obscureText: SocialLoginCubit.get(context).isPassword,
                          controller: _passwordController,
                          suffixPassword: () {
                            SocialLoginCubit.get(context)
                                .changeLoginPasswordVisibility();
                          },
                          label: 'Password',
                          textInputType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocilaLoginLoadingStates,
                          builder: (BuildContext context) => Center(
                            child: elevatedItemBuilder(
                              text: 'Login',
                              onPressed: () {
                                if(formKey.currentState!.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                }
                                _emailController.clear();
                                _passwordController.clear();
                              },
                              width: 350.0,
                              color: colorAll,
                            ),
                          ),
                          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            const Text('Don\'t have in account'),
                            TextButton(
                              onPressed: () {
                                navigatorTo(context, const RegisterSocialScreen());
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: colorAll,
                                ),
                              ),
                            ),
                          ],
                        )
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
