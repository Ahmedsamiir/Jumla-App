
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layouts/shopLayout/cubit/cubit.dart';
import 'package:salla/layouts/shopLayout/cubit/state.dart';
import 'package:salla/shared/components/constant.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/styles.dart';
class SettingsScreen extends StatelessWidget {

   SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel !=null,
          builder: (context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    const SizedBox(height: 20.0,),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (String? value){
                        if(value!.isEmpty){
                          return "name must not be empty";
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                        labelText: "Name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value){
                        if(value!.isEmpty){
                          return "email must not be empty";
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (String? value){
                        if(value!.isEmpty){
                          return "phone must not be empty";
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                        labelText: "Phone",
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Container(
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
                          'UPDATE',
                          style: white14bold(),
                        ),
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text
                            );
                          }

                        },
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Container(
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
                          'LOGOUT',
                          style: white14bold(),
                        ),
                        onPressed: () {
                        signOut(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
