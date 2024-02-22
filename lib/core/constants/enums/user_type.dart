enum UserType {
  CLIENT,
  EventOrganizer,
  OTHER,
}

int userType2Int(UserType type) {
  switch (type) {
    case UserType.CLIENT:
      return 1;
    case UserType.EventOrganizer:
      return 3;
    case UserType.OTHER:
      return 2;
  }
}

UserType int2UserType(int num) {
  switch (num) {
    case 1:
      return UserType.CLIENT;
    case 3:
      return UserType.EventOrganizer;

    default:
      return UserType.OTHER;
  }
}
