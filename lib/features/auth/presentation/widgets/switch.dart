import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActiveColorSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final double scale; 

  const ActiveColorSwitch({
    super.key,
    this.initialValue = false,
    required this.onChanged,
    this.scale = 1.0, 
  });

  @override
  State<ActiveColorSwitch> createState() => _ActiveColorSwitchState();
}

class _ActiveColorSwitchState extends State<ActiveColorSwitch> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale, 
      child: CupertinoSwitch(
        value: isActive,
        activeColor: const Color(0xFF2563EB),
        onChanged: (bool value) {
          setState(() {
            isActive = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}
