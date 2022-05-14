import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BarcodeListPage extends StatefulWidget {
  const BarcodeListPage({Key? key}) : super(key: key);

  @override
  State<BarcodeListPage> createState() => _BarcodeListPage();
}

class _BarcodeListPage extends State<BarcodeListPage> {
  List barcodeList = [];
  String _userInputBarcode = '';
  String _userInputReview = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список штрихкодів'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('barcodes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('');
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final item =
                    snapshot.data?.docs[index].id; //barcodeList[index];
                return ListTile(
                  title: Text(snapshot.data?.docs[index].get('barcode')),
                  subtitle: Text(snapshot.data?.docs[index].get('review')),
                  trailing: IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('barcodes').doc(item).delete();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      )),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Штрихкод'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        TextField(
                          decoration:
                              InputDecoration(hintText: 'Введіть штрихкод'),
                          onChanged: (String value) {
                            _userInputBarcode = value;
                          },
                        ),
                        TextField(
                          decoration:
                              InputDecoration(hintText: 'Введіть коментар'),
                          onChanged: (String value) {
                            _userInputReview = value;
                          },
                        )
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                                if (_userInputBarcode != '' &&
                                    _userInputReview != '')
                                  FirebaseFirestore.instance.collection('barcodes').add({
                                    'barcode': _userInputBarcode,
                                    'review': _userInputReview
                                  });
                              Navigator.of(context).pop();
                            },
                            child: Text('Додати')),
                      ],
                    )
                  ],
                );
              });
        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

