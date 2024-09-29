import 'package:autron/globals/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DropdownSearchBar<T> extends StatefulWidget {
  final List<T> items;
  final String hintText;
  final Function(T) onSelected;
  final String Function(T) getLabel;

  const DropdownSearchBar({
    super.key,
    required this.items,
    required this.hintText,
    required this.onSelected,
    required this.getLabel,
  });

  @override
  _DropdownSearchBarState<T> createState() => _DropdownSearchBarState<T>();
}

class _DropdownSearchBarState<T> extends State<DropdownSearchBar<T>> {
  final TextEditingController _controller = TextEditingController();
  T? _selectedItem;
  List<T> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    _controller.addListener(_filterItems);
  }

  @override
  void dispose() {
    _controller.removeListener(_filterItems);
    _controller.dispose();
    super.dispose();
  }

  void _filterItems() {
    setState(() {
      filteredItems = widget.items.where((item) {
        final label = widget.getLabel(item).toLowerCase();
        return label.contains(_controller.text.toLowerCase());
      }).toList();
    });
  } //dispose and _filterItems are used to handle cases where no items are found with the search

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16.0;

    return Column(
      children: [
        DropdownMenu<T>(
          controller: _controller,
          width: width,
          hintText: widget.hintText,
          requestFocusOnTap: true,
          enableFilter: true,
          menuStyle: MenuStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(AppColors.autronGrey),
          ),
          label: const Text('Select Department'),
          onSelected: (T? item) {
            setState(() {
              _selectedItem = item;
            });
            if (item != null) {
              widget.onSelected(item);
            }
          },
          dropdownMenuEntries: _getDropdownMenuEntries(),
        ),
        if (filteredItems.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Text(
              'No department with this name', //Error message
              style: TextStyle(color: AppColors.autronDeclined),
            ),
          ),
      ],
    );
  }

  List<DropdownMenuEntry<T>> _getDropdownMenuEntries() {
    if (filteredItems.isEmpty) {
      return [];
    }

    return filteredItems.map<DropdownMenuEntry<T>>((T item) {
      return DropdownMenuEntry<T>(
        value: item,
        label: widget.getLabel(item),
      );
    }).toList();
  }
}
