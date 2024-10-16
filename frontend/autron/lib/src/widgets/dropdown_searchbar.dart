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
  bool isDropdownOpen = false;

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
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16.0;

    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              borderSide: const BorderSide(color: Colors.grey), // Border color
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                  color: Colors.grey, width: 1.0), // Enabled border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                  color: Colors.blue, width: 2.0), // Focused border
            ),
            suffixIcon: IconButton(
              icon: Icon(
                  isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              onPressed: () {
                setState(() {
                  isDropdownOpen = !isDropdownOpen;
                });
              },
            ),
          ),
          onTap: () {
            setState(() {
              isDropdownOpen = true;
            });
          },
        ),
        if (isDropdownOpen)
          Container(
            height: 200, // Set the desired height for the dropdown
            color: Colors.white,
            child: ListView(
              children: filteredItems.map<Widget>((T item) {
                return ListTile(
                  title: Text(widget.getLabel(item)),
                  onTap: () {
                    setState(() {
                      _selectedItem = item;
                      isDropdownOpen = false;
                      _controller.text = widget.getLabel(item);
                    });
                    widget.onSelected(item);
                  },
                );
              }).toList(),
            ),
          ),
        if (filteredItems.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Text(
              'No department with this name', // Error message
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
