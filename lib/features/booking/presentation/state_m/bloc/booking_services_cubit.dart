import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'booking_services_state.dart';

class BookingServicesCubit extends Cubit<BookingServicesState> {
  BookingServicesCubit() : super(BookingServicesInitial());
}
