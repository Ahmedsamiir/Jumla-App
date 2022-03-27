
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layouts/search/search_screen.dart';
import 'package:salla/layouts/shopLayout/cubit/cubit.dart';
import 'package:salla/layouts/shopLayout/cubit/state.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/styles/colors.dart';
class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
        builder: (context, state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla'),
            actions: [
              IconButton(icon: const Icon(Icons.search), onPressed: (){
                //navigateTo(context, SearchScreen);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                ),
                );
              },),

            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index){
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
        },
    );
  }
}
