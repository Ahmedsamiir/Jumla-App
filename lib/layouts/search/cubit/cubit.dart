

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layouts/search/cubit/states.dart';
import 'package:salla/models/search_model.dart';
import 'package:salla/shared/network/end_points.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

   SearchModel? model;
  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {
      'text': text,
    }
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());


    });
  }

}