import 'package:flutter/material.dart';
import 'package:touristplace_web/detail_screen.dart';
import 'package:touristplace_web/model/tempat_wisata.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Plaze'),
        //  fungsi untuk menetukan ukuran browser
        //  Place. Size: ${MediaQuery.of(context).size.width}
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraint) {
          if (constraint.maxWidth <= 600) {
            return ListWisata();
          }
          else if(constraint.maxWidth <= 1200){
            return GridWisata(gridCount: 4);
          }
          else {
            return GridWisata(gridCount: 6);
          }
        }));
  }
}

class ListWisata extends StatelessWidget {
  const ListWisata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        late final TempatWisata place = tempatWisataList[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailScreen(place: place);
            }));
          },
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Image.asset(
                      place.imageAsset,
                      width: 200,
                    )),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          place.name,
                          style: TextStyle(fontFamily: 'Oxygen', fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(place.location)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: tempatWisataList.length,
    );
  }
}

class GridWisata extends StatelessWidget {

  late final int gridCount;

  GridWisata({required this.gridCount});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown : true,
        child: Padding(
      padding: EdgeInsets.all(8),
      child: GridView.count(
        //cross kanan dan kiri
        crossAxisSpacing: 16,
        //main atas dan bawah
        crossAxisCount: gridCount,
        children: tempatWisataList.map((datatempatwisata) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(place: datatempatwisata);
              }));
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      datatempatwisata.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      datatempatwisata.name,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 8),
                    child: Text(datatempatwisata.location),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ),
    );
  }
}
