class GroupScreenParams {
  final List<int> friends;
  final bool firstEntry;
  final bool isAddToExistGroup;

  final int? groupId;
  GroupScreenParams(
      {required this.friends,
      this.isAddToExistGroup = false,
      this.groupId,
      this.firstEntry = false});
}
