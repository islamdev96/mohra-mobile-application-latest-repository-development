class SingleSettingOptionArguments<T>{
  final SingleSettingOptionType type;
   T model;

  SingleSettingOptionArguments({
   required this.type,
   required this.model,
});


}



enum SingleSettingOptionType{
 MOMENTS, COMMENTS
}