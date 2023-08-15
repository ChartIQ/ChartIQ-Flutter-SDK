import 'package:example/common/widgets/custom_text_button.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/data/model/symbol/symbol_model.dart';
import 'package:example/screen/home/main_vm.dart';
import 'package:example/screen/intervals/intervals_page.dart';
import 'package:example/screen/symbol_search/symbol_search_page.dart';
import 'package:example/screen/symbol_search/symbol_search_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarSelectButtons extends StatelessWidget {
  const AppBarSelectButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainVM = context.watch<MainVM>();
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Flexible(
          child: CustomTextButton(
            text: mainVM.selectedSymbol?.symbol,
            isLoading: mainVM.selectedSymbol == null,
            padding: EdgeInsets.zero,
            onPressed: () async {
              final newSymbol = await showAppBottomSheet<SymbolModel>(
                context: context,
                builder: (context) {
                  return ChangeNotifierProvider<SymbolSearchVM>(
                    create: (_) => SymbolSearchVM(),
                    builder: (_, __) => const SymbolSearchPage(),
                  );
                },
              );
              mainVM.onSymbolSelected(newSymbol);
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
        const SizedBox(width: 8),
        CustomTextButton(
          text: mainVM.selectedInterval?.getShortValue(context),
          isLoading: mainVM.selectedInterval == null,
          onPressed: () async {
            showAppBottomSheet(
                context: context,
                builder: (context) {
                  return ChangeNotifierProvider<MainVM>.value(
                    value: mainVM,
                    builder: (_, __) {
                      return const IntervalsPage();
                    },
                  );
                });
          },
        ),
      ],
    );
  }
}
