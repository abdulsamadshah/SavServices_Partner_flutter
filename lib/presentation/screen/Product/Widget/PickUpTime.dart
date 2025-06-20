import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickupTimeDropdown extends StatelessWidget {
  final List<String> timeSlots;
  final String? selectedTime;
  final void Function(String?) onChanged;

  const PickupTimeDropdown({
    Key? key,
    required this.timeSlots,
    required this.selectedTime,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedTime,
      decoration: InputDecoration(
        labelText: "Pickup Time",
        prefixIcon: Icon(Icons.access_time),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      icon: Icon(Icons.keyboard_arrow_down_rounded),
      isExpanded: true,
      items: timeSlots.map((time) {
        return DropdownMenuItem(
          value: time,
          child: Text(
            time,
            style: TextStyle(fontSize: 14.sp),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) =>
      value == null || value.isEmpty ? 'Please select pickup time' : null,
    );
  }
}
