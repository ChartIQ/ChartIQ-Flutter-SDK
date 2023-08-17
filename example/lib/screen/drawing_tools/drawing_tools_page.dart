import 'package:example/app_preferences.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/utils/confirmation_dialog.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/custom_icon_button.dart';
import 'package:example/common/widgets/empty_view.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_category.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_item_model.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_section.dart';
import 'package:example/gen/assets.gen.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/screen/drawing_tools/default_drawing_tools.dart';
import 'package:example/screen/drawing_tools/widgets/drawing_tool_section_title.dart';
import 'package:example/screen/drawing_tools/widgets/drawing_tool_tabs_header_delegate.dart';
import 'package:example/screen/drawing_tools/widgets/drawing_tools_list.dart';
import 'package:example/screen/home/main_vm.dart';
import 'package:example/theme/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class DrawingToolsPage extends StatefulWidget {
  const DrawingToolsPage({Key? key}) : super(key: key);

  @override
  State<DrawingToolsPage> createState() => _DrawingToolsPageState();
}

class _DrawingToolsPageState extends State<DrawingToolsPage> with SingleTickerProviderStateMixin {
  DrawingToolCategory _selectedCategory = DrawingToolCategory.all;

  List<DrawingToolItemModel> _currentItems = DefaultDrawingTools.items;

  List<DrawingToolItemModel> _favouriteItems = [];

  @override
  void initState() {
    super.initState();
    _favouriteItems = AppPreferences.getFavouriteDrawingTools();
  }

  void _onFavoriteSelected(DrawingToolItemModel item) {
    setState(() {
      if (_favouriteItems.contains(item)) {
        _favouriteItems.remove(item);
      } else {
        _favouriteItems.add(item);
      }
    });
    AppPreferences.setFavouriteDrawingTools(_favouriteItems);
  }

  void _filterCurrentItems(DrawingToolCategory category) {
    setState(() {
      switch (category) {
        case DrawingToolCategory.all:
          _currentItems = DefaultDrawingTools.items;
          break;
        case DrawingToolCategory.favorites:
          _currentItems = _favouriteItems;
          break;
        default:
          _currentItems = DefaultDrawingTools.items
              .where((element) => element.category == category)
              .toList();
      }
    });
  }

  void _onCategorySelected(DrawingToolCategory category) {
    setState(() {
      _selectedCategory = category;
    });
    _filterCurrentItems(category);
  }

  void _onRestoreDefaultParameters(BuildContext context) async {
    final confirmation = await showConfirmationDialog(
      context,
      "Do You Want To Restore Default Parameters?",
      "All your drawing parameters will be restored to default",
      'Restore',
    );
    if (!(confirmation ?? false) || !mounted) return;
    final mainVM = context.read<MainVM>();
    mainVM.onRestoreDefaultDrawingParameters();
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _onClearExistingDrawings(BuildContext context) async {
    final confirmation = await showConfirmationDialog(
      context,
      "Do You Want To Clear All Existing Drawings?",
      "All your drawings will be cleared on the current chart",
      context.translate(RemoteLocaleKeys.clear),
    );
    if (!(confirmation ?? false) || !mounted) return;
    final mainVM = context.read<MainVM>();
    mainVM.onClearExistingDrawings();
    Navigator.of(context, rootNavigator: true).pop();
  }

  _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return CupertinoTheme(
          data: const CupertinoThemeData(
            textTheme: CupertinoTextThemeData(),
          ),
          child: CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(ctx);
                  _onRestoreDefaultParameters(context);
                },
                child: const Text('Restore Default Parameters'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(ctx);
                  _onClearExistingDrawings(context);
                },
                isDestructiveAction: true,
                child: const Text('Clear Existing Drawings'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: ModalAppBar(
        middleText: 'Drawing Tools',
        trailingWidget: CustomIconButton(
          icon: Assets.icons.more.path,
          followForegroundIconThemeColor: false,
          size: 25,
          foregroundColor: ColorName.mountainMeadow,
          onPressed: () => _showActionSheet(context),
        ),
      ),
      body: SlidableAutoCloseBehavior(
        child: CustomScrollView(
          physics: const BottomSheetScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: DrawingToolTabsHeaderDelegate(
                onSelected: _onCategorySelected,
                selectedCategory: _selectedCategory,
              ),
            ),
            if (_selectedCategory == DrawingToolCategory.favorites &&
                _currentItems.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyView(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  icon: context.assets.drawingTool.path,
                  title: "No favorite drawing tools yet",
                  subtitle:
                      "Swipe left to Add/Remove Drawing Tool to Favourites",
                ),
              ),
            if (_selectedCategory == DrawingToolCategory.all)
              ..._buildAllDrawingTools()
            else
              DrawingToolsList(
                items: _currentItems,
                favouriteItems: _favouriteItems,
                onFavoriteSelected: _onFavoriteSelected,
                isItemDismissible:
                    _selectedCategory == DrawingToolCategory.favorites,
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAllDrawingTools() {
    return DrawingToolSection.values
        .map((e) {
          final sectionItems =
              _currentItems.where((element) => element.section == e).toList();
          return <Widget>[
            SliverSafeArea(
              top: false,
              bottom: false,
              sliver: SliverToBoxAdapter(
                child: DrawingToolSectionTitle(
                  title: e.getPrettyTitle().toUpperCase(),
                ),
              ),
            ),
            DrawingToolsList(
              items: sectionItems,
              favouriteItems: _favouriteItems,
              onFavoriteSelected: _onFavoriteSelected,
              addBottomSafeArea: e == DrawingToolSection.values.last,
            ),
          ];
        })
        .expand((element) => element)
        .toList();
  }
}
