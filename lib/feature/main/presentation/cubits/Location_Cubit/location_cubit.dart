import 'package:ecommerce/cores/help_func/getAddressFromLocation.dart';
import 'package:ecommerce/cores/help_func/getLocation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial()) {
    getLocation();
  }

  Future<void> getLocation() async {
    emit(LocationLoading());

    try {
      final position = await getUserLocation();

      final address = await getAddressFromLocation(position);

      emit(
        LocationSuccess(
          position: position,
          address: address,
        ),
      );
    } catch (e) {
      emit(
        LocationFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}