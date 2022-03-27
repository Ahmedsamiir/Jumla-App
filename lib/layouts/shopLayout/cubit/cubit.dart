

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layouts/categories/categories_screen.dart';
import 'package:salla/layouts/favorites/favorites_screen.dart';
import 'package:salla/layouts/products/products_screen.dart';
import 'package:salla/layouts/settings/settings_screen.dart';
import 'package:salla/layouts/shopLayout/cubit/state.dart';
import 'package:salla/models/categories_model.dart';
import 'package:salla/models/change_favorites_model.dart';
import 'package:salla/models/favorites_model.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/models/profile_model.dart';
import 'package:salla/shared/components/constant.dart';
import 'package:salla/shared/network/end_points.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens =  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index){
    currentIndex = index;
    emit(ShopChangeNavBottomState());
  }
   HomeModel? homeModel;
  void getHomeData(){

    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites,
        });
      });
      print(favorites.toString());
      //print(homeModel.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories(){

    DioHelper.getData(
      url: GET_CATEGORIES,
      //token: token, hwa mch me7tago fe l postman
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel.toString());
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

    Map<int,bool> favorites={};
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId,
        },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }

  ProfileModel? userModel;

  void getUserData(){
    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value){
      userModel = ProfileModel.fromJson(value.data);
      print(userModel!.data.name.toString());
      emit(ShopSuccessGetUserDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }

  void updateUserData({
  required String name,
    required String email,
    required String phone,
}){
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value){
      userModel = ProfileModel.fromJson(value.data);
      print(userModel!.data.name.toString());
      emit(ShopSuccessUpdateUserDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }



}