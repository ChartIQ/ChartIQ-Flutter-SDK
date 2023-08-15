import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/buttons/custom_slidable_button.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/gen/localization/app_localizations.gen.dart';
import 'package:example/screen/studies/utils/study_callback.dart';
import 'package:example/screen/studies/utils/study_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ActiveStudyListItem extends StatelessWidget {
  const ActiveStudyListItem({
    Key? key,
    required this.study,
    required this.onRemoveStudy,
    required this.onCloneStudy,
    required this.onStudyTap,
  }) : super(key: key);

  final Study study;
  final StudyCallback onRemoveStudy, onCloneStudy, onStudyTap;

  List<String> get _studySplitted => StudyExtension.splitName(study.displayName);

  String get _studyName => _studySplitted[0];

  String get _studyParameters => _studySplitted[1];

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(study.hashCode),
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => onRemoveStudy(study),
        ),
        dragDismissible: true,
        extentRatio: 0.4,
        children: [
          CustomSlidableButton(
            text: L.of(context).clone,
            backgroundColor: Colors.blueAccent[700]!,
            onTap: () => onCloneStudy(study),
          ),
          CustomSlidableButton(
            text: context.translateWatch(RemoteLocaleKeys.delete),
            onTap: () => onRemoveStudy(study),
          ),
        ],
      ),
      child: CustomTextListTile(
        title: _studyName,
        subtitle: _studyParameters,
        onTap: () => onStudyTap(study),
        showChevron: true,
      ),
    );
  }
}
