import 'dart:async';

import 'package:crewmeister_app/blocs/absence_manager/bloc.dart';
import 'package:crewmeister_app/blocs/absence_manager/enums/absence_type.dart';
import 'package:crewmeister_app/blocs/absence_manager/event.dart';
import 'package:crewmeister_app/blocs/absence_manager/models/absentee_item.dart';
import 'package:crewmeister_app/blocs/absence_manager/state.dart';
import 'package:crewmeister_app/configs/configs.dart';
import 'package:crewmeister_app/configs/extensions/color_extensions.dart';
import 'package:crewmeister_app/models/absence_filters.dart';
import 'package:crewmeister_app/services/responsive.dart';
import 'package:crewmeister_app/utils/utils.dart';
import 'package:crewmeister_app/widgets/input/app_dropdown.dart';
import 'package:crewmeister_app/widgets/input/app_text_field.dart';
import 'package:crewmeister_app/widgets/input/date_picker_button.dart';
import 'package:crewmeister_app/widgets/ui/app_button.dart';
import 'package:crewmeister_app/widgets/ui/app_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part './_state.dart';
part './views/desktop.dart';
part './views/mobile.dart';
part './views/tablet.dart';
part './widgets/_base_view.dart';
part './widgets/_note_widget.dart';
part './widgets/_absentee_card.dart';
part './widgets/_filters_row.dart';
part './widgets/_build_list.dart';
part './widgets/_search_view.dart';
part './widgets/_filters_model_sheet.dart';

class AbsenceManagerScreen extends StatelessWidget {
  const AbsenceManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _ScreenState(),
      child: SafeArea(
        child: Scaffold(
          body: Responsive(
            mobile: const _Mobile(),
            tablet: const _Tablet(),
            desktop: const _Desktop(),
          ),
        ),
      ),
    );
  }
}
