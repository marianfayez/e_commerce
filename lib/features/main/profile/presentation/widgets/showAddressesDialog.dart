import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_bloc.dart';
import 'package:e_commerce_app/features/main/profile/presentation/widgets/showAddAddressSheet.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showAddressesDialog(
  BuildContext context,
  List<AddressData> addresses, {
  required ProfileBloc profileBloc,
}) {
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
                leading: InkWell(
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (confirmCtx) => AlertDialog(
                          title: const Text("Delete Address"),
                          content: const Text(
                              "Are you sure you want to delete this address?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(confirmCtx, false),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(confirmCtx, true),
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true && address.id != null) {
                        profileBloc
                            .add(DeleteAddressEvent(id: address.id ?? ""));
                        Navigator.pop(ctx);
                      }
                    },
                    child: const Icon(Icons.delete, color: Colors.blueAccent)),
                title: Text(address.name ?? ""),
                subtitle: Text(
                  "${address.details ?? ''}\n📞 ${address.city ?? ''}\n🏙️ ${address.phone ?? ''}",
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
