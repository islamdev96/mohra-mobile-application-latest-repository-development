
class TicketModel implements Comparable<TicketModel>{
  final String? avatar;
  final String? title;
  final String? subTile;

  TicketModel({this.avatar,this.title,this.subTile});

  @override
  int compareTo(TicketModel other) => title!.compareTo(other.title!);
}