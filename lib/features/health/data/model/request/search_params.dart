import 'package:starter_application/core/params/base_params.dart';

class SearchParam extends BaseParams{
  String? searchText;

  SearchParam({
   this.searchText,
});

  @override
  Map<String, dynamic> toMap() {
   Map <String , dynamic> res = {};
   if(searchText != null) res['Keyword'] = searchText;
    return res;
  }
}