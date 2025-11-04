import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_bloc.dart';

void showAddAddressSheet(BuildContext context) {
  final nameController = TextEditingController();
  final detailsController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add New Address",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Home/Work/.."),
            ),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: "Street Name"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: "City"),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    final details = detailsController.text.trim();
                    final phone = phoneController.text.trim();
                    final city = cityController.text.trim();

                    if ([name, details, phone, city].any((e) => e.isEmpty)) {
                      ScaffoldMessenger.of(sheetContext).showSnackBar(
                        const SnackBar(
                          content: Text("❌ Please fill all fields"),
                        ),
                      );
                      return;
                    }

                    sheetContext
                        .read<ProfileBloc>()
                        .add(AddAddress(name, details, phone, city));

                    Navigator.pop(sheetContext);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}
