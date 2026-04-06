import 'package:flutter/material.dart';
import 'package:inventory_management/models/item_models.dart';

class ItemForm extends StatefulWidget {
  final Item? item; // null = add, not null = edit
  final Function(Item) onSubmit;

  const ItemForm({
    super.key,
    this.item,
    required this.onSubmit,
  });

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();

    // ✅ Pre-fill if editing
    nameController =
        TextEditingController(text: widget.item?.name ?? '');
    quantityController =
        TextEditingController(text: widget.item?.quantity.toString() ?? '');
    priceController =
        TextEditingController(text: widget.item?.price.toString() ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      final newItem = Item(
        id: widget.item?.id ?? '', // empty for new
        name: nameController.text,
        quantity: int.parse(quantityController.text),
        price: double.parse(priceController.text),
      );

      widget.onSubmit(newItem);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "Add Item" : "Edit Item",
              style: const TextStyle(fontSize: 18),
            ),

            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
              validator: (value) =>
                  value == null || value.isEmpty ? "Required" : null,
            ),

            TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Quantity"),
              validator: (value) {
                if (value == null || value.isEmpty) return "Required";
                if (int.tryParse(value) == null) return "Must be a number";
                return null;
              },
            ),

            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Price"),
              validator: (value) {
                if (value == null || value.isEmpty) return "Required";
                if (double.tryParse(value) == null) return "Must be a number";
                return null;
              },
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: submit,
              child: Text(widget.item == null ? "Add" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
