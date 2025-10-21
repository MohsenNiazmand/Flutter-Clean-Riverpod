import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Widget pageNumberWidget({
  required void Function()? onTap,
  required String text,
  required bool selected,
}) =>
    Row(
      children: [
        PrimaryRectangle(
          onTap: onTap,
          color: selected ? cPrimary50 : cBackground,
          width: 24,
          height: 32,
          // borderWith: 1,
          // borderColor: selected ? cPrimary : cSPlaceHolder,
          radius: dimen8,
          child: Center(
            child: Text(
              text,
              style: AppStyles()
                  .styleText_11_400()
                  .apply(color: selected ? cPrimary : cText),
            ),
          ),
        ),
        Gap.h8(),
      ],
    );

class PageNumbers extends HookConsumerWidget {
  const PageNumbers({
    required this.pageProvider,
    required this.itemsPerPage,
    required this.totalPages,
    required this.onPageSelected,
    super.key,
  });

  final StateProvider<int> pageProvider;
  final int itemsPerPage;
  final int totalPages;
  final void Function(int) onPageSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<int> pageNumbers = [];
    final currentPage = ref.watch(pageProvider);
    int startPage = (currentPage > 5) ? currentPage - 4 : 1;
    final int endPage =
        (startPage + 6 < totalPages) ? startPage + 6 : totalPages;

    if (endPage - startPage < 6) {
      startPage = (endPage - 6 > 0) ? endPage - 6 : 1;
    }

    for (int i = startPage; i <= endPage; i++) {
      pageNumbers.add(i);
    }

    return Container(
      // width: 300,
      margin: const EdgeInsets.only(bottom: dimen32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (startPage > 1) ...[
            pageNumberWidget(
              onTap: currentPage == 1
                  ? null
                  : () {
                      ref.read(pageProvider.notifier).state = 1;
                      onPageSelected(1);
                    },
              text: '1',
              selected: currentPage == 1,
            ),
            if (currentPage > 6)
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      ref.read(pageProvider.notifier).state = currentPage - 3;
                      onPageSelected(currentPage);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(dimen8),
                      child: Text('...'),
                    ),
                  ),
                  Gap.h8(),
                ],
              ),
          ],
          ...pageNumbers.map((page) {
            return pageNumberWidget(
              onTap: currentPage == page
                  ? null
                  : () {
                      ref.read(pageProvider.notifier).state = page;
                      onPageSelected(page);
                    },
              text: '$page',
              selected: currentPage == page,
            );
          }),
          if (endPage < totalPages) ...[
            if ((endPage < totalPages - 1) && currentPage > 6)
              InkWell(
                onTap: () {
                  ref.read(pageProvider.notifier).state = currentPage + 3;
                  onPageSelected(currentPage);
                },
                child: const Padding(
                  padding: EdgeInsets.all(dimen8),
                  child: Text('...'),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
