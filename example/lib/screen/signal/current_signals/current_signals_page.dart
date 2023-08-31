import 'package:chart_iq/chart_iq.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/empty_view.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/screen/signal/add_signal/add_signal_page.dart';
import 'package:example/screen/signal/add_signal/add_signal_vm.dart';
import 'package:example/screen/signal/current_signals/current_signals_vm.dart';
import 'package:example/theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../signal_study_info_model.dart';
import 'widgets/signal_item.dart';

class CurrentSignalsPage extends StatefulWidget {
  const CurrentSignalsPage({Key? key}) : super(key: key);

  @override
  State<CurrentSignalsPage> createState() => _CurrentSignalsPageState();
}

class _CurrentSignalsPageState extends State<CurrentSignalsPage> {
  Future<void> _addSignal(BuildContext context) async {
    final vm = context.read<CurrentSignalsVM>();
    final signalStudyInfo = SignalStudyInfoModel.instance..clear();

    await _showSignalPage(context);

    if (!mounted) return;

    _clearAllUnnecessaryStudies(context, signalStudyInfo.studies);

    vm.getSignals();
  }

  Future<void> _editSignal(BuildContext context, Signal signal) async {
    await _showSignalPage(context, signal: signal);
    if (!mounted) return;
    final vm = context.read<CurrentSignalsVM>();
    vm.getSignals();
  }

  Future<void> _showSignalPage(
    BuildContext context, {
    Signal? signal,
  }) async {
    final vm = context.read<CurrentSignalsVM>();
    final page = ChangeNotifierProvider(
      create: (_) => AddSignalVM(
        chartIQController: vm.chartIQController,
        signal: signal,
      ),
      child: const AddSignalPage(),
    );

    if (signal == null) {
      return showAppBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return Navigator(
            onGenerateRoute: (context) {
              return MaterialPageRoute(
                builder: (_) => page,
              );
            },
          );
        },
      );
    }
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  Future<void> _clearAllUnnecessaryStudies(
      BuildContext context, List<Study> studies) async {
    final vm = context.read<CurrentSignalsVM>();
    if (studies.isEmpty) return;
    Future.wait(
      studies.map((e) async => await vm.chartIQController.study.removeStudy(e)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CurrentSignalsVM>();
    return Scaffold(
      appBar: ModalAppBar(
        middleText: 'SignalIQ',
        trailingWidget: vm.signals.isEmpty
            ? null
            : AppBarTextButton(
                onPressed: () => _addSignal(context),
                child: Text(context.translateWatch(RemoteLocaleKeys.add)),
              ),
      ),
      body: Builder(builder: (context) {
        if (vm.signals.isEmpty) {
          return Center(
            child: EmptyView(
              icon: context.assets.analysisIcon.path,
              title: 'No Signals to display yet',
              buttonText: 'Add Signal',
              onButtonPressed: () => _addSignal(context),
            ),
          );
        }
        return CustomSeparatedListView(
          physics: const BottomSheetScrollPhysics(),
          controller: ModalScrollController.of(context),
          itemCount: vm.signals.length,
          itemBuilder: (context, index) => SignalItem(
            signal: vm.signals[index],
            onSignalTap: (signal) => _editSignal(context, signal),
            onToggleSignal: (value) => vm.toggleSignal(index, value),
            onRemoveSignal: (signal) => vm.removeSignal(index, signal),
          ),
        );
      }),
    );
  }
}
