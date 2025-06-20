import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';

class DropdownRow extends StatefulWidget {
  final String title;
  final Function(double, double)? onPriceRangeSelected;

  const DropdownRow(
      {super.key, required this.title, this.onPriceRangeSelected});

  @override
  State<DropdownRow> createState() => _DropdownRowState();
}

class _DropdownRowState extends State<DropdownRow> {
  bool isExpanded = true;
  RangeValues _currentRangeValues = const RangeValues(0, 0);
  int _selectedRating = 0;
  late TextEditingController _minController;
  late TextEditingController _maxController;

  @override
  void initState() {
    super.initState();
    _minController = TextEditingController(
        text: _currentRangeValues.start.round().toString());
    _maxController =
        TextEditingController(text: _currentRangeValues.end.round().toString());
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: Styles.textStyle16.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.black),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: isExpanded ? 0.5 : 0.0,
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Column(
                  children: [
                    if (widget.title == 'Price') ...[
                      RangeSlider(
                        values: _currentRangeValues,
                        min: 0,
                        max: 10000,
                        divisions: 100,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                            _minController.text =
                                values.start.round().toString();
                            _maxController.text = values.end.round().toString();
                          });
                          widget.onPriceRangeSelected
                              ?.call(values.start, values.end);
                        },
                        activeColor: AppColors.primary,
                        inactiveColor: AppColors.primary.withOpacity(0.3),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _minController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label: Text('From'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _currentRangeValues = RangeValues(
                                      double.tryParse(value) ??
                                          _currentRangeValues.start,
                                      _currentRangeValues.end);
                                });
                                widget.onPriceRangeSelected?.call(
                                    _currentRangeValues.start,
                                    _currentRangeValues.end);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _maxController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label: Text('To'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _currentRangeValues = RangeValues(
                                      _currentRangeValues.start,
                                      double.tryParse(value) ??
                                          _currentRangeValues.end);
                                });
                                widget.onPriceRangeSelected?.call(
                                    _currentRangeValues.start,
                                    _currentRangeValues.end);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ] else if (widget.title == 'Ratings') ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRating = index + 1;
                              });
                            },
                            child: Icon(
                              index < _selectedRating
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              color: index < _selectedRating
                                  ? AppColors.waring
                                  : AppColors.c5,
                              size: 30,
                            ),
                          );
                        }),
                      ),
                    ],
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
