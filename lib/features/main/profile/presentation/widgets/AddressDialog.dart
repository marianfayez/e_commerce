import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_bloc.dart';
import 'package:e_commerce_app/features/main/profile/presentation/widgets/AddAddressSheet.dart';
import 'package:e_commerce_app/features/main/profile/presentation/widgets/customFormSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressDialog extends StatefulWidget {
  final List<AddressData> addresses;
  final ProfileBloc profileBloc;
  final void Function(String name, String details, String phone, String city)? onSave;
  final void Function(AddressData selectedAddress)? onSelectAddress;

  const AddressDialog({
    required this.addresses,
    required this.profileBloc,
    required this.onSave,
    this.onSelectAddress,
    super.key,
  });

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: const Text(
        'Your Shipping Addresses',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: double.maxFinite,

        child: ListView.separated(
          shrinkWrap: true,
          itemCount: widget.addresses.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final address = widget.addresses[index];

            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.w),
              child: Row(
                children: [
                  Checkbox(
                    value: selectedIndex == index,
                    onChanged: (checked) {
                      setState(() {
                        selectedIndex = checked! ? index : null;
                      });
                      widget.onSelectAddress?.call(address);
                    },
                  ),
                   SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                             Icon(Icons.home, color: Colors.blueGrey, size: 20.w),
                             SizedBox(width: 6.w),
                            Text(address.name ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                         SizedBox(height: 2.h),
                        Row(
                          children: [
                             Icon(Icons.location_on, color: Colors.redAccent, size: 18.w),
                             SizedBox(width: 4.w),
                            Expanded(child: Text(address.details ?? "")),
                          ],
                        ),
                         SizedBox(height: 2.h),
                        Row(
                          children: [
                             Icon(Icons.phone, color: Colors.green, size: 18.w),
                             SizedBox(width: 4.w),
                            Text(address.phone ?? ""),
                          ],
                        ),
                         SizedBox(height: 2.h),
                        Row(
                          children: [
                             Icon(Icons.location_city, color: Colors.blue, size: 18.w),
                             SizedBox(width: 4.w),
                            Text(address.city ?? ""),
                          ],
                        ),
                      ],
                    ),
                  ),
                   SizedBox(width: 8.w),
                  InkWell(
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (confirmCtx) => AlertDialog(
                          title: const Text("Delete Address"),
                          content: const Text("Are you sure you want to delete this address?"),
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
                      if (!context.mounted) return;
                      if (confirm == true && address.id != null) {
                        widget.profileBloc.add(DeleteAddressEvent(id: address.id ?? ""));
                        Navigator.pop(context);
                      }
                    },
                    child: const Icon(Icons.delete, color: Colors.blueAccent),
                  ),
                ],
              ),
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
            Navigator.pop(context); // close dialog first
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              builder: (_) => SingleChildScrollView(
                child: CustomFormSheet(
                  title: "Add Address",
                  fields: [
                    FormFieldData(key: "name", label: "Home/Work/..", controller: TextEditingController()),
                    FormFieldData(key: "details", label: "Street Name", controller: TextEditingController()),
                    FormFieldData(key: "phone", label: "Phone", controller: TextEditingController(), inputType: TextInputType.phone),
                    FormFieldData(key: "city", label: "City", controller: TextEditingController()),
                  ],
                  onSave: (values) {
                     widget.onSave?.call(values["name"]!, values["details"]!, values["phone"]!, values["city"]!);
                  },
                ),
              ),
              // builder: (sheetCtx) {
              //   return Padding(
              //     padding: EdgeInsets.only(
              //       bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
              //     ),
              //     child: SingleChildScrollView(
              //       child: AddAddressSheet(
              //         onSave: (name, details, phone, city) {
              //           widget.onSave?.call(name, details, phone, city);
              //         },
              //       ),
              //     ),
              //   );
              // },
            );
          },
          child: const Text('Add New Address'),
        ),
      ],
    );
  }
}
