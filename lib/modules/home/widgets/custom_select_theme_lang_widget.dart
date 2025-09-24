import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/manager/app_provider.dart';
import '../../../core/theme/app_colors.dart';

class CustomSelectThemeLangWidget extends StatelessWidget {
  final String selectedlabel;
  final ImageIcon icon;

  const CustomSelectThemeLangWidget({
    super.key,
    required this.selectedlabel,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final appProvider = Provider.of<AppProvider>(context);

    String selectedText =
    appProvider.themeMode == ThemeMode.dark ? "Dark" : "Light";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              selectedlabel,
              style: const TextStyle(fontWeight: FontWeight.bold,color: AppColors.lightBg),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: AppColors.lightBg),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedText,
                dropdownColor: Colors.black,
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 40,
                  color: Colors.white,
                ),
                items: ["Light", "Dark"].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue == "Light") {
                    appProvider.changeTheme(ThemeMode.light);
                  } else {
                    appProvider.changeTheme(ThemeMode.dark);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
