
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layouts/shopLayout/cubit/cubit.dart';
import 'package:salla/layouts/shopLayout/cubit/state.dart';
import 'package:salla/shared/components/components.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder:(context, state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
            itemBuilder: (context, index)=> buildListProduct(ShopCubit.get(context).favoritesModel!.data.data[index].product, context),
            separatorBuilder: (context, index)=> myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data.data.length,
          ),
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },

    );
  }


}
