import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/models/item_models.dart';

class FirestoreService {
  final CollectionReference items =
      FirebaseFirestore.instance.collection('items');

  // create
  Future<void> addItem(Item item) async {
    await items.add(item.toMap());
  }

  // read
  Stream<List<Item>> streamItems() {
    return items.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) {
          return Item.fromMap(
            doc.data() as Map<String, dynamic>,
          )..id = doc.id;
        }).toList());
  }

  // update
  Future<void> updateItem(Item item) async {
    await items.doc(item.id).update(item.toMap());
  }

  // delete
  Future<void> deleteItem(String id) async {
    await items.doc(id).delete();
  }
}
