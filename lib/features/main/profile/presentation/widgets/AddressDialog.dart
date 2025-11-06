import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_bloc.dart';
import 'package:e_commerce_app/features/main/profile/presentation/widgets/AddAddressSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressDialog extends StatelessWidget {
  final List<dynamic> addresses;
  final ProfileBloc profileBloc;
  BuildContext context;
    AddressDialog({required this.addresses,required this.profileBloc,required this.context,super.key});

  @override
  Widget build(BuildContext context) {
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
                    profileBloc.add(DeleteAddressEvent(id: address.id ?? ""));
                    Navigator.pop(context); // close this dialog
                  }
                },
                child: const Icon(Icons.delete, color: Colors.blueAccent),
              ),
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
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // close current dialog first
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (sheetCtx) => BlocProvider.value(
                value: profileBloc,
                child: AddAddressSheet(
                  onSave: (name, details, phone, city) {
                    profileBloc.add(AddAddress(name, details, phone, city));
                  },
                ),
              ),
            );
          },
          child: const Text('Add New Address'),
        ),
      ],
    );
  }
}
