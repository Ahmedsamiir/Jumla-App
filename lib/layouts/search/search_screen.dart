
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layouts/search/cubit/cubit.dart';
import 'package:salla/layouts/search/cubit/states.dart';
import 'package:salla/shared/components/components.dart';
class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "please Enter text to search";
                        }
                      },
                      onFieldSubmitted: (String text){
                        SearchCubit.get(context).search(text);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: "Search",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index)=> buildListProduct(SearchCubit.get(context).model!.data.data[index], context, isOldPrice: false),
                          separatorBuilder: (context, index)=> myDivider(),
                          itemCount: SearchCubit.get(context).model!.data.data.length,
                        ),
                      ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
