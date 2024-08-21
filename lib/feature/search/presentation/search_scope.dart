import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../bloc/search_bloc.dart';
import '../domain/entity/search_response.dart';

@immutable
class SearchScope extends StatelessWidget {
  final Widget child;

  const SearchScope({required this.child, super.key});

  static void search(BuildContext context) => context.read<SearchBloc>().add(const SearchEvent.search());

  static void loadMore(BuildContext context) => context.read<SearchBloc>().add(const SearchEvent.loadMore());

  static List<SearchItem> items(BuildContext context) => context.watch<SearchBloc>().state.items;

  static bool isLoadingMore(BuildContext context) => context.watch<SearchBloc>().state.isLoadingMore;
  @override
  Widget build(BuildContext context) => BlocProvider<SearchBloc>(
        create: (context) => getIt<SearchBloc>()..add(const SearchEvent.search()),
        child: child,
      );
}
