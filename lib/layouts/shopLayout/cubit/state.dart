import 'package:salla/models/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeNavBottomState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  final error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{
  final error;

  ShopErrorCategoriesState(this.error);

}

class ShopChangeFavoritesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {
  final error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{
  final error;

  ShopErrorGetFavoritesState(this.error);

}

class ShopLoadingGetUserDataState extends ShopStates{}

class ShopSuccessGetUserDataState extends ShopStates{}

class ShopErrorGetUserDataState extends ShopStates{
  final error;

  ShopErrorGetUserDataState(this.error);

}

class ShopLoadingUpdateUserDataState extends ShopStates{}

class ShopSuccessUpdateUserDataState extends ShopStates{}

class ShopErrorUpdateUserDataState extends ShopStates{
  final error;

  ShopErrorUpdateUserDataState(this.error);

}

