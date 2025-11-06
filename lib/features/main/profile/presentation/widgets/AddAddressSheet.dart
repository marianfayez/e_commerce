import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressSheet extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final void Function(String name, String details, String phone, String city)? onSave;

  AddAddressSheet({super.key,this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  final details = detailsController.text.trim();
                  final phone = phoneController.text.trim();
                  final city = cityController.text.trim();

                  if ([name, details, phone, city].any((e) => e.isEmpty)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("❌ Please fill all fields"),
                      ),
                    );
                    return;
                  }

                  onSave?.call(name, details, phone, city); // ⬅️ نستخدم الكولباك هنا

                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
