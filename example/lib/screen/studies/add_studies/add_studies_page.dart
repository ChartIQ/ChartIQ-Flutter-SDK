import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/common/widgets/custom_separated_sliver_list.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/screen/studies/widgets/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'widgets/add_studies_search_delegate.dart';

class AddStudiesPage extends StatefulWidget {
  const AddStudiesPage({
    Key? key,
    required this.chartIQController,
    this.singleChoice = false,
  }) : super(key: key);

  final ChartIQController? chartIQController;
  final bool singleChoice;

  @override
  State<AddStudiesPage> createState() => _AddStudiesPageState();
}

class _AddStudiesPageState extends State<AddStudiesPage> {
  bool _isLoading = false;
  List<Study> studies = [],
      selectedStudies = [];

  bool get isAddStudyAvailable => selectedStudies.isNotEmpty;

  String? _searchText;

  List<String> get _filteredStudies =>
      studies
          .where(
            (element) =>
        (element.displayName)
            .toLowerCase()
            .contains(_searchText?.toLowerCase() ?? '') &&
            (widget.singleChoice ? !element.signalIQExclude : true),
      )
          .map((e) => e.displayName)
          .sorted((a, b) => a.toLowerCase().compareTo(b.toLowerCase()))
          .toList();

  void _onTextChanged(String? text) {
    setState(() {
      _searchText = text;
    });
  }

  @override
  void initState() {
    _getStudies();
    super.initState();
  }

  Future<void> _getStudies() async {
    final studiesList = await widget.chartIQController?.study.getStudyList();
    if (!mounted || studiesList == null) return;
    setState(() {
      studies = studiesList
        ..sort(
              (a, b) => a.displayName.compareTo(b.displayName),
        );
    });
  }

  void _onStudyTap(int index) {
    if (widget.singleChoice) {
      setState(() {
        selectedStudies
          ..clear()
          ..add(studies
              .firstWhere((e) => e.displayName == _filteredStudies[index]));
      });
      return;
    }
    setState(() {
      if (selectedStudies
          .any((e) => e.displayName == _filteredStudies[index])) {
        selectedStudies
            .removeWhere((e) => e.displayName == _filteredStudies[index]);
      } else {
        selectedStudies.add(studies
            .firstWhere((e) => e.displayName == _filteredStudies[index]));
      }
    });
  }

  Future<void> _addStudies(BuildContext context) async {
    if (!widget.singleChoice) {
      setState(() {
        _isLoading = true;
      });
      await Future.wait(
        selectedStudies.map(
              (e) async =>
          await widget.chartIQController?.study.addStudy(e, false),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop(selectedStudies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ModalAppBar(
        middleText: 'Add Studies',
        showBottomLine: false,
        trailingWidget: AppBarTextButton(
          onPressed: !isAddStudyAvailable ? null : () => _addStudies(context),
          child: Text(context.translateWatch(RemoteLocaleKeys.done)),
        ),
      ),
      body: CustomScrollView(
        physics: const BottomSheetScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: AddStudiesSearchDelegate(onChanged: _onTextChanged),
          ),
          Builder(
            builder: (context) {
              if (_isLoading) {
                return const FullScreenLoader();
              }
              return SliverSafeArea(
                sliver: CustomSeparatedSliverList(
                  itemCount: _filteredStudies.length,
                  itemBuilder: (_, index) {
                    return CustomTextListTile(
                      title: _filteredStudies[index],
                      trailing: selectedStudies.any(
                              (e) => e.displayName == _filteredStudies[index])
                          ? const Icon(Icons.check,
                          color: ColorName.mountainMeadow)
                          : null,
                      onTap: () => _onStudyTap(index),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
