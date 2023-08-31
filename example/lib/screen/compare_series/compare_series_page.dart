import 'package:chart_iq/chart_iq.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/empty_view.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/data/model/symbol/symbol_model.dart';
import 'package:example/providers/locale_provider.dart';
import 'package:example/screen/symbol_search/symbol_search_page.dart';
import 'package:example/screen/symbol_search/symbol_search_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'compare_series_vm.dart';
import 'widgets/compare_series_list_item.dart';

class CompareSeriesPage extends StatefulWidget {
  const CompareSeriesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CompareSeriesPage> createState() => _CompareSeriesPageState();
}

class _CompareSeriesPageState extends State<CompareSeriesPage> {
  static const _kComparisonParameterColor = 'color';

  void _openSelectSymbolPage(BuildContext context) async {
    final newSymbol = await showAppBottomSheet<SymbolModel>(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => SymbolSearchVM(),
          builder: (_, __) => const SymbolSearchPage(),
        );
      },
    );

    if (!mounted || newSymbol == null) return;
    final vm = context.read<CompareSeriesVM>();
    vm.addCompareSeries(
      Series(
        symbolName: newSymbol.symbol,
        color: _defaultSeriesColors[
                (vm.series?.length ?? 0) % _defaultSeriesColors.length]
            .hexValueWithHash,
      ),
    );
  }

  void _changeSeriesColor(
    BuildContext context, {
    required int index,
    required PickerColor color,
  }) async {
    final vm = context.read<CompareSeriesVM>();
    final currentSeries = vm.series![index];
    vm.updateCompareSeries(
      currentSeries.symbolName,
      _kComparisonParameterColor,
      color.hexValueWithHash,
    );
  }

  void _removeSeries(Series series) {
    final vm = context.read<CompareSeriesVM>();
    vm.removeCompareSeries(series);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CompareSeriesVM>();
    return Scaffold(
      appBar: ModalAppBar(
        middleText: 'Compare Symbols',
        trailingWidget: vm.series != null && vm.series!.isNotEmpty
            ? AppBarTextButton(
                onPressed: () => _openSelectSymbolPage(context),
                child: Text(
                  context
                      .read<LocaleProvider>()
                      .translate(RemoteLocaleKeys.add),
                ),
              )
            : null,
      ),
      body: Builder(builder: (context) {
        if (vm.series == null || vm.series!.isEmpty) {
          return SingleChildScrollView(
            child: EmptyView(
              title: 'No Symbols to compare yet',
              buttonText: 'Add Symbol',
              onButtonPressed: () => _openSelectSymbolPage(context),
            ),
          );
        }

        return SlidableAutoCloseBehavior(
          child: CustomSeparatedListView(
            itemCount: vm.series!.length,
            physics: const BottomSheetScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 16),
            itemBuilder: (context, index) {
              final series = vm.series![index];
              return CompareSeriesListItem(
                series: series,
                onRemoveSeries: _removeSeries,
                onSeriesColorChanged: (color) => _changeSeriesColor(
                  context,
                  color: color,
                  index: index,
                ),
              );
            },
          ),
        );
      }),
    );
  }

  static const _defaultSeriesColors = [
    PickerColor("#8ec648"),
    PickerColor("#00afed"),
    PickerColor("#ee652e"),
    PickerColor("#912a8e"),
    PickerColor("#fff126"),
    PickerColor("#e9088c"),
    PickerColor("#ea1d2c"),
    PickerColor("#00a553"),
    PickerColor("#00a99c"),
    PickerColor("#0056a4"),
    PickerColor("#f4932f"),
    PickerColor("#0073ba"),
    PickerColor("#66308f"),
    PickerColor("#323390"),
  ];
}
