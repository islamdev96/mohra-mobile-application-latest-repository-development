
class SearchModel implements Comparable<SearchModel>{
  final String? avatar;
  final String? title;
  final String? subTile;

  SearchModel({this.avatar,this.title,this.subTile});

    @override
    int compareTo(SearchModel other) => title!.compareTo(other.title!);

}