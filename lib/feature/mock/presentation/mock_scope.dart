import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../bloc/mock_bloc.dart';
import '../domain/repository/i_mock_repository.dart';

@immutable
class MockScope extends StatelessWidget {
  final Widget child;

  const MockScope({required this.child, super.key});

  static void readOf(BuildContext context) => context.read<MockBloc>().add(const MockEvent.read());

  @override
  Widget build(BuildContext context) => BlocProvider<MockBloc>(
        create: (context) => MockBloc(
          repository: getIt<IMockRepository>(),
        )..add(const MockEvent.read()),
        child: child,
      );
}
