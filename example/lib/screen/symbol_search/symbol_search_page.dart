import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/utils/debouncer.dart';
import 'package:example/common/widgets/animations/custom_fade_in_container.dart';
import 'package:example/common/widgets/app_bars/search_app_bar.dart';
import 'package:example/common/widgets/custom_separated_sliver_list.dart';
import 'package:example/common/widgets/empty_view.dart';
import 'package:example/common/widgets/list_tiles/custom_title_trailing_list_tile.dart';
import 'package:example/data/model/symbol/symbol_model.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/gen/localization/app_localizations.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'symbol_search_vm.dart';
import 'widgets/symbol_search_tabs_header_delegate.dart';

class SymbolSearchPage extends StatefulWidget {
  const SymbolSearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SymbolSearchPage> createState() => _SymbolSearchPageState();
}

class _SymbolSearchPageState extends State<SymbolSearchPage> {
  final _debouncer = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SymbolSearchVM>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onTextChanged: (text) {
        _debouncer.run(() => vm.onSearchChanged(text));
      }),
      body: CustomScrollView(
        physics: const BottomSheetScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SymbolSearchTabsHeaderDelegate(
              selectedFilter: vm.selectedFilter,
              onSelected: vm.onFilterSelected,
            ),
          ),
          Builder(
            builder: (context) {
              if (vm.isLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: CustomFadeInContainer(
                    child: CupertinoActivityIndicator(
                      color: ColorName.mountainMeadow,
                      radius: 20,
                    ),
                  ),
                );
              }

              if (vm.isSearchDirty &&
                  vm.symbols.isEmpty &&
                  vm.searchText.isNotEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyView(
                    title: L.of(context).symbolsNotFound,
                    subtitle: L.of(context).tryAnotherSymbolOrApplyCurrent,
                    onButtonPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(
                        SymbolModel(symbol: vm.searchText),
                      );
                    },
                    buttonText: L.of(context).apply,
                  ),
                );
              }

              if (!vm.isSearchDirty || vm.searchText.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyView(title: L.of(context).typeToStartSearching),
                );
              }

              return SliverSafeArea(
                sliver: CustomSeparatedSliverList(
                  itemCount: vm.symbols.length,
                  itemBuilder: (context, index) {
                    final currentSymbol = vm.symbols[index];
                    return CustomTitleTrailingListTile(
                      visualDensity: const VisualDensity(vertical: 3),
                      title: currentSymbol.symbol,
                      trailingText: Text(
                        currentSymbol.fund,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      subtitle: currentSymbol.fullName,
                      onTap: () => Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pop(SymbolModel(symbol: currentSymbol.symbol)),
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
