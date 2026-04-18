import 'package:flutter/material.dart';

class CustomFormSheet extends StatefulWidget {
  final String title;
  final List<FormFieldData> fields;
  final void Function(Map<String, String> values) onSave;

  const CustomFormSheet({
    super.key,
    required this.title,
    required this.fields,
    required this.onSave,
  });

  @override
  State<CustomFormSheet> createState() => _CustomFormSheetState();
}

class _CustomFormSheetState extends State<CustomFormSheet> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            /// Dynamic Fields
            ...widget.fields.map((f) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: f.controller,
                  obscureText: f.isPassword,
                  keyboardType: f.inputType,
                  decoration: InputDecoration(labelText: f.label),
                  validator: (value) {
                    if (f.required && (value == null || value.isEmpty)) {
                      return "${f.label} is required";
                    }
                    if (f.validator != null) return f.validator!(value!);
                    return null;
                  },
                ),
              );
            }).toList(),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final values = <String, String>{};

                      for (var field in widget.fields) {
                        values[field.key] = field.controller.text.trim();
                      }

                      widget.onSave(values);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
class FormFieldData {
  final String key;
  final String label;
  final TextEditingController controller;
  final bool required;
  final bool isPassword;
  final TextInputType inputType;
  final String? Function(String)? validator;

  FormFieldData({
    required this.key,
    required this.label,
    this.required = true,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.validator,
    required this.controller,
  });
}
