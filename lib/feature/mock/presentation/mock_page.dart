import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/error_handler.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/primary_check_box.dart';
import '../../../core/ui_kit/error_page.dart';
import '../../../core/ui_kit/multi_selection_card.dart';
import '../../../core/ui_kit/primary_bottom_sheet.dart';
import '../../../core/ui_kit/primary_elevated_button.dart';
import '../../../core/ui_kit/range_text_field.dart';
import '../../../core/ui_kit/single_selection_card.dart';
import '../../../core/ui_kit/tag_card.dart';
import '../../../core/ui_kit/vip_card.dart';
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
            error: (error) => ErrorBody(
              error: ErrorHandler.fromError('object'),
              actions: [ElevatedButton(onPressed: () {}, child: const Text('try again'))],
            ),
          ),
        ),
      ),
    );
  }
}

class _DataLayout extends StatefulWidget {
  final Post post;
  const _DataLayout({required this.post});

  @override
  State<_DataLayout> createState() => _DataLayoutState();
}

class _DataLayoutState extends State<_DataLayout> {
  late final ValueNotifier<int?> _singleSelectionGroupValue;
  late final ValueNotifier<List<int>> _multiSelectionValue;
  late final ValueNotifier<bool> _checkboxController;

  @override
  void initState() {
    _singleSelectionGroupValue = ValueNotifier(null);
    _multiSelectionValue = ValueNotifier([]);
    _checkboxController = ValueNotifier(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InkWell(
            child: VipCard.vip(),
            onTap: () => PrimaryBottomSheet.show(
              context: context,
              builder: (context) => const Column(
                children: [Text('text'), Text('text')],
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _singleSelectionGroupValue,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SingleSelectionCard(
                    onTap: (value) => _singleSelectionGroupValue.value = value,
                    groupValue: _singleSelectionGroupValue.value,
                    value: 1,
                    title: 'Аренда',
                  ),
                  SingleSelectionCard(
                    onTap: (value) => _singleSelectionGroupValue.value = value,
                    groupValue: _singleSelectionGroupValue.value,
                    value: 2,
                    title: 'Продажа',
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _multiSelectionValue,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MultiSelectionCard(
                    onTap: (value) {
                      if (_multiSelectionValue.value.contains(1)) {
                        _multiSelectionValue.value = List.from(_multiSelectionValue.value)..remove(value);
                        return;
                      }
                      _multiSelectionValue.value = List.from(_multiSelectionValue.value)..add(value);
                    },
                    isSelected: _multiSelectionValue.value.contains(1),
                    value: 1,
                    title: 'Аренда',
                  ),
                  MultiSelectionCard(
                    onTap: (value) {
                      if (_multiSelectionValue.value.contains(2)) {
                        _multiSelectionValue.value = List.from(_multiSelectionValue.value)..remove(value);
                        return;
                      }
                      _multiSelectionValue.value = List.from(_multiSelectionValue.value)..add(value);
                    },
                    isSelected: _multiSelectionValue.value.contains(2),
                    value: 2,
                    title: 'Продажа',
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          PrimaryElevatedButton(
            child: const Text('PrimaryElevatedButton'),
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          PrimaryElevatedButton.secondary(
            child: const Text('PrimaryElevatedButton.secondary'),
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          Center(
            child: TagCard(
              icon: Assets.icons.arrow.svg(),
              text: 'Кодовая дверь',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: RangeTextField(
                  label: 'от',
                  suffix: r'$', //₾, м²
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: RangeTextField(
                  label: 'до',
                  suffix: r'$',
                  controller: TextEditingController(),
                  isError: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
              animation: _checkboxController,
              builder: (context, child) {
                return PrimaryCheckBox(
                  isChecked: _checkboxController.value,
                  onChanged: (value) => _checkboxController.value = value ?? false,
                );
              }),
        ],
      );

  @override
  void dispose() {
    _singleSelectionGroupValue.dispose();
    _multiSelectionValue.dispose();
    _checkboxController.dispose();
    super.dispose();
  }
}

class _ProgressLayout extends StatelessWidget {
  const _ProgressLayout();

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator());
}
