import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';

class DropdownRow extends StatefulWidget {
  final String title;

  const DropdownRow({super.key, required this.title});

  @override
  State<DropdownRow> createState() => _DropdownRowState();
}

class _DropdownRowState extends State<DropdownRow> {
  bool isExpanded = true;
  RangeValues _currentRangeValues = const RangeValues(120, 820);
  int _selectedRating = 0;

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
                  style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold , color: AppColors.black),
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
                        max: 1000,
                        divisions: 100,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                        activeColor: AppColors.primary,
                        inactiveColor: AppColors.primary.withOpacity(0.3),
                      ),
                      Row(
                        children: [
                          Expanded(child:
                            TextFormField(
                              initialValue: _currentRangeValues.start.round().toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label:Text('From'),
                                border: OutlineInputBorder(
                                  
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _currentRangeValues = RangeValues(
                                      double.tryParse(value) ?? _currentRangeValues.start,
                                      _currentRangeValues.end);
                                });
                              },
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                           Expanded(child: TextFormField(
                              initialValue: _currentRangeValues.end.round().toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label:Text('To') ,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _currentRangeValues = RangeValues(
                                      _currentRangeValues.start,
                                      double.tryParse(value) ?? _currentRangeValues.end);
                                });
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
                              index < _selectedRating ? Icons.star : Icons.star_border,
                              color: AppColors.waring,
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
