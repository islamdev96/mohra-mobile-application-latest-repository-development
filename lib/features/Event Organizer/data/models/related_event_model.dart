
class RelatedEvents {
  final String? avatar;
  final String? title;
  final String? subTile;

  RelatedEvents({this.avatar,this.title,this.subTile});

  @override
  int compareTo(RelatedEvents other) => title!.compareTo(other.title!);
}