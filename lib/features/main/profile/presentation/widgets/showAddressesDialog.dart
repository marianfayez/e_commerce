import 'package:e_commerce_app/features/main/profile/presentation/widgets/showAddAddressSheet.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';

void showAddressesDialog(BuildContext context, List<AddressData> addresses) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Your Shipping Addresses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: addresses.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final address = addresses[index];
              return ListTile(
                leading: const Icon(Icons.location_on, color: Colors.blueAccent),
                title: Text(address.name ?? ""),
                subtitle: Text(
                  "${address.details ?? ''}\n📞 ${address.phone ?? ''}\n🏙️ ${address.city ?? ''}",
                  style: const TextStyle(height: 1.4),
                ),
                isThreeLine: true,
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              showAddAddressSheet(context);
            },
            child: const Text('Add New Address'),
          ),
        ],
      );
    },
  );
}
