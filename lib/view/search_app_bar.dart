import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

/// Creates a search bar inside an [AppBar].
///
/// By default the text style will be,
/// ```dart
///   const TextStyle(fontSize: 18, fontWeight: FontWeight.w200)
/// ```
///
/// Example usage:
///
/// ```dart
/// SearchAppBar(
///   searchHint: 'Search...',
///   searchController: TextEditingController(),
///   onChanged: (v) {},
///   onEscape: () {},
///   appBarHeight: AppBarTheme.of(context).toolbarHeight,
/// )
/// ```
class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    Key? key,
    this.searchController,
    required this.onChanged,
    required this.onEscape,
    this.searchIconData,
    this.appBarHeight = kToolbarHeight,
    this.searchHint,
    this.textStyle,
    this.automaticallyImplyLeading = false,
    this.clearSearchIconData,
  }) : super(key: key);

  /// An optional [TextEditingController].
  final TextEditingController? searchController;

  /// The callback that gets invoked when the value changes in the text field.
  final Function(String value) onChanged;

  /// The callback that gets invoked when `escape` key is pressed.
  final Function() onEscape;

  /// Search icon for search bar.
  final IconData? searchIconData;

  /// The height of the [SearchAppBar], needed if it is put into
  /// a container without height.
  /// It defaults to [kToolbarHeight].
  ///
  /// Recommended height is ```AppBarTheme.of(context).toolbarHeight```
  final double appBarHeight;

  /// Specifies the search hint.
  final String? searchHint;

  /// Specifies the [TextStyle]
  final TextStyle? textStyle;

  /// If false, hides the back icon in the [AppBar]
  final bool automaticallyImplyLeading;

  final IconData? clearSearchIconData;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).appBarTheme.foregroundColor;
    return AppBar(
      toolbarHeight: appBarHeight,
      foregroundColor: textColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: RawKeyboardListener(
        onKey: (event) {
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            onEscape();
            return;
          }
        },
        focusNode: FocusNode(),
        child: SizedBox(
          height: appBarHeight,
          child: TextField(
            expands: true,
            maxLines: null,
            minLines: null,
            cursorColor: textColor,
            textAlignVertical: TextAlignVertical.center,
            style: textStyle ??
                Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      fontWeight: FontWeight.w200,
                    ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 4),
              prefixIcon: Icon(
                searchIconData ?? Icons.search,
                color: textColor,
                size: 20,
              ),
              prefixIconConstraints:
                  BoxConstraints.expand(width: 40, height: appBarHeight),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: YaruIconButton(
                  onPressed: onEscape,
                  icon: Icon(
                    clearSearchIconData ?? Icons.close,
                    color: textColor,
                  ),
                ),
              ),
              hintText: searchHint,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: const UnderlineInputBorder(),
            ),
            controller: searchController,
            autofocus: false,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, appBarHeight);
}
