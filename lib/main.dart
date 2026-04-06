import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart'; 
import 'package:inventory_management/models/item_models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
} 

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
      ),
      body: Center(
        child: Text('Welcome to Inventory Management'),
      ),
    );
  }
}

final itemsRef = FirebaseFirestore.instance.collection('items');

// Create and Read operations
Future<void> addItem(Item item) async {
  await itemsRef.add(item.toMap());
}

Stream<List<Item>> streamItems() {
  return itemsRef.snapshots().map(
    (snap) => snap.docs
        .map((d) => Item.fromMap({
              ...d.data(),
              'id': d.id,
            }))
        .toList(),
  );
}

// Update and Delete operations
Future<void> updateItem(Item item) async {
  await itemsRef.doc(item.id).update(item.toMap());
}

Future<void> deleteItem(String id) async {
  await itemsRef.doc(id).delete();
}
