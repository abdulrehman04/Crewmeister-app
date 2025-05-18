import 'dart:async';

import 'package:crewmeister_app/blocs/absence_manager/event.dart';
import 'package:crewmeister_app/blocs/absence_manager/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../absence_manager/../../api/api.dart';

part './repository.dart';
part './data_provider.dart';

class AbsenceManagerBloc
    extends Bloc<AbsenceManagerEvents, AbsenceManagerState> {
  AbsenceManagerBloc() : super(const AbsenceManagerDefault()) {
    on<AbsenceManagerTestEvent>(_onTestCall);
  }

  final _repo = _AbsenceManagerRepo();

  FutureOr<void> _onTestCall(
    AbsenceManagerTestEvent event,
    Emitter<AbsenceManagerState> emit,
  ) {
    _repo.testCall();
  }
}
