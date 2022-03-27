import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layouts/register/shop_register_screen.dart';
import 'package:salla/layouts/shopLayout/shop_layout.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constant.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/styles.dart';

import 'cubit/cubit/cubit.dart';
import 'cubit/cubit/state.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  ShopLoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => ShopLoginCubit(),
          child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
            listener: (context, state) {
              if (state is ShopLoginSuccessState) {
                if (state.loginModel.status) {
                  print(state.loginModel.message);
                  print(state.loginModel.data.token);
                  CacheHelper.saveData(
                    key: 'token',
                    value: state.loginModel.data.token,
                  ).then((value) {
                    token = state.loginModel.data.token;
                    navigateAndFinish(context, ShopLayout());
                  });
                } else {
                  print(state.loginModel.message);
                  showToast(
                    text: state.loginModel.message,
                    state: ToastStates.ERROR,
                  );
                }
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "LOGIN",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(color: Colors.black),
                            ),
                            Text(
                              "login now to browse our hot offers",
                              style:
                                  Theme.of(context).textTheme.bodyText1?.copyWith(
                                        color: Colors.grey,
                                      ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "please Enter your Email Address";
                                }
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                labelText: "Email",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Password is too short";
                                }
                              },
                              onFieldSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              obscureText: ShopLoginCubit.get(context).isPassword,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: Icon(Icons.visibility_outlined),
                                labelText: "Password",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => Container(
                                height: 40.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(
                                    3.0,
                                  ),
                                ),
                                child: MaterialButton(
                                  child: Text(
                                    'LOGIN',
                                    style: white14bold(),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                ),
                              ),
                              /*defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                ShopLoginCubit.get(context).userLogin(email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            text: "login",
                          ),*/
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account?'),

                                TextButton(
                                  onPressed: () {
                                    navigateTo(context,  ShopRegisterScreen());
                                  },
                                  child: const Text(
                                    'REGISTER',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
