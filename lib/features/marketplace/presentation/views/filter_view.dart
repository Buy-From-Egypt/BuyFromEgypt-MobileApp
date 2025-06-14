import 'package:buy_from_egypt/features/marketplace/presentation/widgets/app_bar.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/industury_section.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/drop_down_row.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/toggle_row.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CAppBar(title: 'Filter',),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: FilterContent(),
        ),
      ),
    );
  }
}

class FilterContent extends StatelessWidget {
  const FilterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          IndustrySection(),
          SizedBox(height: 24),
          ToggleRow(title: 'Free shipping'),
          SizedBox(height: 24),
          ToggleRow(title: 'In-Stock only'),
          SizedBox(height: 24),
          DropdownRow(title: 'Price'),
          SizedBox(height: 24),
          DropdownRow(title: 'Ratings'),
        ],
      ),
    );
  }
}


