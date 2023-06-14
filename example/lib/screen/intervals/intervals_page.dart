import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/custom_separated_sliver_list.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/data/model/interval.dart';
import 'package:example/data/model/time_unit_enum.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/gen/localization/app_localizations.gen.dart';
import 'package:example/screen/home/main_vm.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class IntervalsPage extends StatefulWidget {
  const IntervalsPage({super.key});

  @override
  State<IntervalsPage> createState() => _IntervalsPageState();
}

class _IntervalsPageState extends State<IntervalsPage> {

  final List<List<ChartInterval>> _defaultIntervals = [
    [
      ChartInterval(period: 1, interval: 1, timeUnit: ChartIQTimeUnit.day),
      ChartInterval(period: 1, interval: 1, timeUnit: ChartIQTimeUnit.week),
      ChartInterval(period: 1, interval: 1, timeUnit: ChartIQTimeUnit.month),
    ],
    [
      ChartInterval(period: 1, interval: 1, timeUnit: ChartIQTimeUnit.minute),
      ChartInterval(period: 1, interval: 5, timeUnit: ChartIQTimeUnit.minute),
      ChartInterval(period: 1, interval: 10, timeUnit: ChartIQTimeUnit.minute),
      ChartInterval(period: 3, interval: 5, timeUnit: ChartIQTimeUnit.minute),
      ChartInterval(period: 1, interval: 30, timeUnit: ChartIQTimeUnit.minute),
      ChartInterval(period: 2, interval: 30, timeUnit: ChartIQTimeUnit.hour),
      ChartInterval(period: 8, interval: 30, timeUnit: ChartIQTimeUnit.hour),
    ],
    [
      ChartInterval(period: 1, interval: 30, timeUnit: ChartIQTimeUnit.second),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: ModalAppBar(
        middleText: L.of(context).intervals,
      ),
      body: CustomScrollView(
        controller: ModalScrollController.of(context),
        // physics: const BottomSheetScrollPhysics(),
        slivers: [
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.only(bottom: 20),
              sliver: CustomSeparatedSliverList(
                itemCount: _defaultIntervals.length,
                separatorBuilder: (_) => const SizedBox(height: 40),
                itemBuilder: (_, index) {
                  return Consumer<MainVM>(
                    builder: (_, vm, __) => CustomSeparatedListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _defaultIntervals[index].length,
                      itemBuilder: (_, innerIndex) {
                        return _listItem(
                          _defaultIntervals[index][innerIndex],
                          isSelected: _defaultIntervals[index][innerIndex] ==
                              vm.selectedInterval,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listItem(ChartInterval interval, {bool isSelected = false}) {
    return CustomTextListTile(
      title: interval.getPrettyValue(context),
      trailing: isSelected
          ? const Icon(
              Icons.check,
              color: ColorName.mountainMeadow,
            )
          : null,
      onTap: () {
        context.read<MainVM>().onIntervalSelected(interval);
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
  }
}
