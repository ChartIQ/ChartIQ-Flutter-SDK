import 'package:example/common/widgets/custom_expandable_body.dart';
import 'package:example/common/widgets/custom_icon_button.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/data/model/chart_style_item_type_model.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_item_model.dart';
import 'package:example/gen/assets.gen.dart';
import 'package:example/screen/chart_type/chart_type_page.dart';
import 'package:example/screen/compare_series/compare_series_page.dart';
import 'package:example/screen/compare_series/compare_series_vm.dart';
import 'package:example/screen/drawing_tools/drawing_tools_page.dart';
import 'package:example/screen/home/main_vm.dart';
import 'package:example/screen/home/widgets/app_bar_controll_buttons_wrapper.dart';
import 'package:example/screen/home/widgets/app_bar_select_buttons.dart';
import 'package:example/screen/settings/settings_page.dart';
import 'package:example/screen/settings/settings_vm.dart';
import 'package:example/screen/signal/current_signals/current_signals_page.dart';
import 'package:example/screen/signal/current_signals/current_signals_vm.dart';
import 'package:example/screen/studies/active_studies/active_studies_page.dart';
import 'package:example/screen/studies/active_studies/active_studies_vm.dart';
import 'package:example/theme/app_assets.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatefulWidget {
  const MainAppBar({
    Key? key,
    this.isCollapsed = false,
    this.onExpandButtonPressed,
  }) : super(key: key);

  final bool isCollapsed;
  final VoidCallback? onExpandButtonPressed;

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  static const _kWidthForExpandedAppBar = 500.0;
  static const _kWidthForSelectButtons = 280.0;

  bool get isEnoughSpaceForSelectButtons =>
      MediaQuery.of(context).size.width - _kWidthForSelectButtons > 100.0;

  bool get shouldBeAlwaysExpanded =>
      MediaQuery.of(context).size.width > _kWidthForExpandedAppBar;

  bool shouldDisplayExpandButton(bool isPortrait, bool shouldBeAlwaysExpanded) {
    return !isPortrait && shouldBeAlwaysExpanded;
  }

  bool _isExpandedAdditionalSection = false;

  @override
  Widget build(BuildContext context) {
    final mainVM = context.watch<MainVM>();
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      decoration: BoxDecoration(
        color: context.colors.mainAppBarColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.5,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: CustomExpandableBody(
          expand: !widget.isCollapsed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: AppBarSelectButtons(),
                    ),
                    const HorizontalSpacing(16),
                    AppBarControlButtonsWrapper(
                      children: [
                        CustomIconButton(
                          icon: mainVM.selectedChartStyle?.icon,
                          isLoading: mainVM.selectedChartStyle == null,
                          onPressed: () async {
                            final newStyle =
                                await showAppBottomSheet<ChartTypeItemModel>(
                              context: context,
                              builder: (_) {
                                return ChartTypePage(
                                  selectedStyle: mainVM.selectedChartStyle,
                                );
                              },
                            );

                            mainVM.onChartStyleSelected(newStyle);
                          },
                        ),
                        if (isEnoughSpaceForSelectButtons)
                          ..._buildOptionalControlButtonsDependingOnTheSpace(
                            context,
                          ),
                        if (isPortrait && !shouldBeAlwaysExpanded)
                          CustomIconButton.selectable(
                            isSelected: _isExpandedAdditionalSection,
                            icon: Assets.icons.expandArrow.path,
                            selectedIcon: Assets.icons.expandArrowFocused.path,
                            onPressed: () {
                              setState(() {
                                _isExpandedAdditionalSection =
                                    !_isExpandedAdditionalSection;
                              });
                            },
                          ),
                        if (!isPortrait || shouldBeAlwaysExpanded)
                          _buildAdditionalControlButtons(
                            shouldDisplayExpandButton(
                                isPortrait, shouldBeAlwaysExpanded),
                          ),
                      ],
                    )
                  ],
                ),
                if (isPortrait && !shouldBeAlwaysExpanded)
                  CustomExpandableBody(
                    expand: _isExpandedAdditionalSection,
                    axisAlignment: -1,
                    child: Row(
                      children: [
                        const Spacer(),
                        Column(
                          children: [
                            const VerticalSpacing(8),
                            _buildAdditionalControlButtons(
                              shouldDisplayExpandButton(
                                isPortrait,
                                shouldBeAlwaysExpanded,
                              ),
                            ),
                            const VerticalSpacing(8),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOptionalControlButtonsDependingOnTheSpace(
      BuildContext context) {
    final mainVM = context.watch<MainVM>();

    return [
      CustomIconButton(
        icon: Assets.icons.chartStudy.path,
        onPressed: () {
          showAppBottomSheet(
              context: context,
              builder: (_) {
                return Material(
                  child: Navigator(
                    onGenerateRoute: (_) {
                      return MaterialPageRoute(
                        builder: (_) {
                          return ChangeNotifierProvider(
                            create: (_) => ActiveStudiesVM(
                              chartIQController: mainVM.chartIQController,
                            ),
                            child: const ActiveStudiesPage(),
                          );
                        },
                      );
                    },
                  ),
                );
              });
        },
      ),
      if (MediaQuery.of(context).orientation == Orientation.portrait)
        _buildCompareButton(context)
      else
        _buildSignalButton(context)
    ];
  }

  Widget _buildSignalButton(BuildContext context) {
    final mainVM = context.watch<MainVM>();
    return CustomIconButton(
      icon: Assets.icons.signal.path,
      onPressed: () {
        showAppBottomSheet(
          context: context,
          builder: (_) {
            return Material(
              child: Navigator(
                onGenerateRoute: (_) {
                  return MaterialPageRoute(
                    builder: (_) {
                      return ChangeNotifierProvider(
                        create: (_) => CurrentSignalsVM(
                          chartIQController: mainVM.chartIQController!,
                        ),
                        child: const CurrentSignalsPage(),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCompareButton(BuildContext context) {
    final mainVM = context.watch<MainVM>();
    return CustomIconButton(
      icon: Assets.icons.compare.path,
      onPressed: () {
        showAppBottomSheet(
          context: context,
          builder: (_) {
            return ChangeNotifierProvider(
              create: (_) => CompareSeriesVM(
                chartIQController: mainVM.chartIQController!,
              ),
              builder: (_, __) => const CompareSeriesPage(),
            );
          },
        );
      },
    );
  }

  Widget _buildAdditionalControlButtons(bool showFullViewButton) {
    final mainVM = context.watch<MainVM>();
    return AppBarControlButtonsWrapper(
      children: [
        if (!isEnoughSpaceForSelectButtons)
          ..._buildOptionalControlButtonsDependingOnTheSpace(
            context,
          ),
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          _buildSignalButton(context)
        else
          _buildCompareButton(context),
        CustomIconButton.selectable(
          isSelected: mainVM.isCrosshairEnabled,
          icon: Assets.icons.crosshair.path,
          selectedIcon: Assets.icons.crosshairFocused.path,
          onPressed: () {
            mainVM.onCrossHairEnabledChanged(!mainVM.isCrosshairEnabled);
          },
        ),
        CustomIconButton.selectable(
          isSelected: mainVM.selectedDrawingTool != null,
          icon: context.assets.drawIcon.path,
          selectedIcon: context.assets.drawFocusedIcon.path,
          followForegroundIconThemeColor: false,
          onPressed: () {
            if (mainVM.selectedDrawingTool != null) {
              return mainVM.onDrawingToolSelected(null);
            }
            showAppBottomSheet<DrawingToolItemModel>(
              context: context,
              builder: (_) {
                return ChangeNotifierProvider.value(
                  value: mainVM,
                  builder: (_, __) => const DrawingToolsPage(),
                );
              },
            );
          },
        ),
        CustomIconButton(
          icon: Assets.icons.navSettings.path,
          onPressed: () {
            showAppBottomSheet(
              context: context,
              builder: (_) {
                return Material(
                  child: Navigator(
                    onGenerateRoute: (_) {
                      return MaterialPageRoute(
                        builder: (_) {
                          return MultiProvider(
                            providers: [
                              ChangeNotifierProvider.value(value: mainVM),
                              ChangeNotifierProvider(
                                create: (_) => SettingsVM(
                                  chartIQController: mainVM.chartIQController,
                                ),
                              ),
                            ],
                            child: const SettingsPage(),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
        if (showFullViewButton)
          CustomIconButton(
            icon: Assets.icons.fullView.path,
            onPressed: widget.onExpandButtonPressed,
          ),
      ],
    );
  }
}
