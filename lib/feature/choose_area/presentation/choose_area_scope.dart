import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../bloc/choose_area_bloc.dart';

@immutable
class ChooseAreaScope extends SingleChildStatelessWidget {
  const ChooseAreaScope({super.key});

  static void readOf(BuildContext context) => context.read<ChooseAreaBloc>().add(const ChooseAreaEvent.read());

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider<ChooseAreaBloc>(
        create: (context) => getIt<ChooseAreaBloc>()..add(const ChooseAreaEvent.read()),
        child: child,
      );
}
