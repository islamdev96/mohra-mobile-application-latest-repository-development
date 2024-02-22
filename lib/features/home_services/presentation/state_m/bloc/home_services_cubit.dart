import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_services_state.dart';

class HomeServicesCubit extends Cubit<HomeServicesState> {
  HomeServicesCubit() : super(HomeServicesInitial());
}
