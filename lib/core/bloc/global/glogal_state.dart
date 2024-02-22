part of 'glogal_cubit.dart';

@immutable
abstract class GlogalState {}

class GlogalInitial extends GlogalState {}

class GlogalChanged extends GlogalState {
  final int? numberMessages;
  final int? numberNotificaions;

  GlogalChanged({this.numberMessages = 0,this.numberNotificaions = 0});

}