import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/theme.dart';

class CustomToggleListTile extends StatelessWidget {
  const CustomToggleListTile({
    super.key,
    required this.toggle,
    required this.value,
    required this.label,
  });

  final String label;
  final Function(bool) toggle;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
      trailing: CustomToggleButton(toggle: toggle, value: value),
    );
  }
}

class CustomToggleButton extends StatelessWidget {
  const CustomToggleButton({
    super.key,
    required this.toggle,
    required this.value,
  });
  final Function(bool) toggle;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(20),
      onPressed: (index) {
        index == 1 ? toggle(false) : toggle(true);
      },
      isSelected: [value, !value],
      children: [
        Text(
          'ON',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        Text(
          'OFF',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

class CheckRowBtn extends StatelessWidget {
  const CheckRowBtn({
    super.key,
    this.isPad,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final bool? isPad;
  final bool value;
  final Function(bool?) onChanged;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
      trailing: Transform.scale(
        scale: 1,
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: Colors.cyan.shade600,
          fillColor: WidgetStateProperty.resolveWith(
            (states) => Colors.grey[200],
          ),
        ),
      ),
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Text(
    //       label,
    //       style: TextStyle(
    //         fontSize: 12,
    //         fontWeight: FontWeight.w600,
    //         color: AppColors.mainColor,
    //       ),
    //     ),
    //     Transform.scale(
    //       scale: 1,
    //       child: Checkbox(
    //         value: value,
    //         onChanged: onChanged,
    //         checkColor: Colors.cyan.shade600,
    //         fillColor: WidgetStateProperty.resolveWith(
    //           (states) => Colors.white,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
// import 'package:flutter/material.dart';

// class CheckRowBtn extends StatelessWidget {
//   const CheckRowBtn(
//       {super.key,
//       required this.label,
//       required this.isChecked,
//       required this.onTap});

//   final bool isChecked;
//   final String label;
//   final Function() onTap;
//   @override
//   Widget build(BuildContext context) {
//     print('isChecked : ${isChecked}');

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 12,
//               backgroundColor:
//                   isChecked ? Colors.cyan.shade600 : Colors.grey[400],
//               foregroundColor: Colors.white,
//               child: const Icon(
//                 Icons.check,
//                 size: 16,
//               ),
//             ),
//             const SizedBox(width: 8),
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
