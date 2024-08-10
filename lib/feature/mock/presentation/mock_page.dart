import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/src/error_extension.dart';
import '../bloc/mock_bloc.dart';
import '../domain/entity/post.dart';
import 'mock_scope.dart';

@immutable
class MockPage extends StatelessWidget {
  const MockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MockScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('App Bar')),
        body: BlocBuilder<MockBloc, MockState>(
          builder: (context, state) => state.map(
            progress: (_) => const _ProgressLayout(),
            success: (data) => _DataLayout(post: data.post),
            error: (error) => _ErrorLayout(
              errorText: context.messageFromError(error.errorHandler),
              onTap: () => MockScope.readOf(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _DataLayout extends StatelessWidget {
  final Post post;
  const _DataLayout({required this.post});

  @override
  Widget build(BuildContext context) => const Center(child: Text('data'));
}

class _ErrorLayout extends StatelessWidget {
  final VoidCallback? onTap;
  final String errorText;
  const _ErrorLayout({required this.errorText, this.onTap});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorText,
              textAlign: TextAlign.center,
            ),
            OutlinedButton(
              onPressed: onTap,
              child: const Text('ОБНОВИТЬ'),
            ),
          ],
        ),
      );
}

class _ProgressLayout extends StatelessWidget {
  const _ProgressLayout();

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator());
}
