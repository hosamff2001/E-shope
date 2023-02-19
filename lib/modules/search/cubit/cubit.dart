import 'package:eshop/models/search_model/searchmodel.dart';
import 'package:eshop/modules/search/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cashmemory.dart';
import '../../../shared/network/rempte/dio.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(Searchinitialstates());
  static SearchCubit GetObject(context) => BlocProvider.of(context);
  SearchDataModel? searchdata;
  void search(String text) async {
    emit(Searchloadingstates());
    Token = await CashHelper.getdata(key: "token");
    
    DioHelper.post(url: SEARCH, data: {"text": text}, token: Token)
        .then((value) {
      
      searchdata = SearchDataModel.fromjson(value.data);
      
      emit(Searchsuccessstates());
    }).catchError((e) {
      print(e.toString());
      emit(Searcherorrstates());
    });
  }
  
}
