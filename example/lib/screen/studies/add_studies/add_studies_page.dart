import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/common/widgets/custom_separated_sliver_list.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/screen/studies/widgets/full_screen_loader.dart';
import 'package:flutter/material.dart';

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
  List<Study> studies = [], selectedStudies = [];

  bool get isAddStudyAvailable => selectedStudies.isNotEmpty;

  String? _searchText;

  List<String> get _filteredStudies => studies
      .where(
        (element) =>
            element.name
                .toLowerCase()
                .contains(_searchText?.toLowerCase() ?? '') &&
            (widget.singleChoice ? !element.signalIQExclude : true),
      )
      .map((e) => e.name)
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
          (a, b) => a.name.compareTo(b.name),
        );
    });
  }

  void _onStudyTap(int index) {
    if (widget.singleChoice) {
      setState(() {
        selectedStudies
          ..clear()
          ..add(studies.firstWhere((e) => e.name == _filteredStudies[index]));
      });
      return;
    }
    setState(() {
      if (selectedStudies.any((e) => e.name == _filteredStudies[index])) {
        selectedStudies.removeWhere((e) => e.name == _filteredStudies[index]);
      } else {
        selectedStudies
            .add(studies.firstWhere((e) => e.name == _filteredStudies[index]));
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
          (e) async => await widget.chartIQController?.study.addStudy(e, false),
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
      appBar: ModalAppBar(
        middleText: 'Add Studies',
        showBottomLine: false,
        trailingWidget: AppBarTextButton(
          onPressed: !isAddStudyAvailable ? null : () => _addStudies(context),
          child: Text(context.translateWatch(RemoteLocaleKeys.done)),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: AddStudiesSearchDelegate(onChanged: _onTextChanged),
              ),
              CustomSeparatedSliverList(
                itemCount: _filteredStudies.length,
                itemBuilder: (_, index) {
                  return CustomTextListTile(
                    title: _filteredStudies[index],
                    trailing: selectedStudies
                            .any((e) => e.name == _filteredStudies[index])
                        ? const Icon(Icons.check,
                            color: ColorName.mountainMeadow)
                        : null,
                    onTap: () => _onStudyTap(index),
                  );
                },
              ),
            ],
          ),
          if (_isLoading) const FullScreenLoader(),
        ],
      ),
    );
  }
}
