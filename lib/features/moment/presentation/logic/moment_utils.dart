class MomentUtils {
  MomentUtils._();
  static String? taggedFriendsToString(List<String?> names) {
    final noNullNames = names.whereType<String>().toList();
    if (noNullNames.length == 0) return "";
    if (noNullNames.length == 1) return noNullNames.first;
    if (noNullNames.length == 2)
      return "${noNullNames.first} & ${noNullNames[1]}";
    if (noNullNames.length > 2)
      return "${noNullNames.first} & ${noNullNames[1]} & ${noNullNames.length - 2} others";
  }
}
