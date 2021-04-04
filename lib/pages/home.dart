import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 2),
    Band(id: '3', name: 'Soda Stereo', votes: 4),
    Band(id: '4', name: 'Julio Nava', votes: 5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nombre de la Banda',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int i) {
          return _bandTile(bands[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: adNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      onDismissed: (direction) {
        //Para borrar del Servidor
        //
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 8),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Borrar banda',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      key: Key(band.id),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  adNewBand() {
    //Es para que tome el dato que se pone en el campo de texto (TextField)
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      //Android
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Agregar nueva Banda:'),
              content: TextField(controller: textController),
              actions: [
                MaterialButton(
                  child: Text('Agregar'),
                  onPressed: () {
                    addBandToList(textController.text);
                  },
                  textColor: Colors.blue,
                  elevation: 5,
                ),
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('Agregar una nueva Banda:'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('Agregar'),
                isDefaultAction: true,
                onPressed: () {
                  addBandToList(textController.text);
                },
              ),
              CupertinoDialogAction(
                child: Text('Salir'),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  addBandToList(String name) {
    print(name);
    if (name.length > 1) {
      //Podemos agregar
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 4));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
