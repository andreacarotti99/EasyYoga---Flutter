import 'package:flutter/material.dart';
import 'package:yogaflutter/pages/description/third_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageYogaTypes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  Future<List<Widget>> createList() async {
    List typeOfYogas = [];
    List<Widget> items = new List<Widget>();    

    var documenti = await Firestore.instance.collection("typeofyogas").getDocuments(); 
    var allDocsInCollection = documenti.documents;
    for (int i = 0; i < allDocsInCollection.length; i++) {
      typeOfYogas.add(allDocsInCollection[i]);
    }
    print(typeOfYogas);

    for (int i = 0; i < typeOfYogas.length; i++){
      items.add(
        Padding(
          padding: EdgeInsets.all(2.0),
          child: FlatButton(
            onPressed: () {
              Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context) => 
                  TypeBeginnerYoga(
                    clickedNome: typeOfYogas[i].data['nome'], 
                    clickedDescrizione: typeOfYogas[i].data['descrizione'], 
                    clickedImmagine: typeOfYogas[i].data['immagine']
                  )));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2.0,
                    blurRadius: 5.0
                  ),
                ]
              ),
            margin: EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
                  child: Image(
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    image: NetworkImage(typeOfYogas[i].data['immagine']),
                    ),
                ),
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(typeOfYogas[i].data['nome'].toString()),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                          child: Text( typeOfYogas[i].data['descrizione'], style: TextStyle(fontSize: 12.0,color: Colors.black54,),),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          ),
        )
      );
    }
    return items;
  }

// List typesList = [];
// List<Widget> items = new List<Widget>();

// typesList.forEach((object) { 
//     String finalString= "";
//     List<dynamic> dataList = object["placeItems"];
//     dataList.forEach((item){
//       finalString = finalString + item;
//     });

//     //per ogni elemento in json che possiedo in instructors costruisce un elemento
//     items.add(Padding(padding: EdgeInsets.all(2.0),
//     child: FlatButton(
//         onPressed: () {
//           //salvo il tipo di yoga cliccato
//           clickedType = object["typeTitle"];
//           print(clickedType);
//           lesson.typeofyoga = clickedType;
          
//           Navigator.of(context).push(
//           new MaterialPageRoute(builder: (BuildContext context) => TypeBeginnerYoga(clickedYoga: clickedYoga,)));

//         },

//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 spreadRadius: 2.0,
//                 blurRadius: 5.0
//               ),
//             ]
//           ),
//         margin: EdgeInsets.all(5.0),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
//               child: Image.asset(object["typeImage"],width: 80,height: 80,fit: BoxFit.cover,),
//             ),
//             SizedBox(
//               width: 250,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(object["typeTitle"]),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
//                       child: Text(finalString, style: TextStyle(fontSize: 12.0,color: Colors.black54,),),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ),));
// });
    
    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo[400],),
      body: ListView(
        children: <Widget>[
          Container(child: FutureBuilder(
            //initialData: <Widget>[Text("")],
            future: createList(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: snapshot.data,
                  ),
                );
              } else {
                  return Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator()),
                  );
              }
            }),
          )
        ],
      ),
    );
  }
} 


// void getData() async {
    // databaseReference
    //   .collection("typeofyogas")
    //   .getDocuments()
    //   .then((QuerySnapshot snapshot) {
    //     snapshot.documents.forEach((f) {
    //       var datas = f.data['typeofyogas'];
    //       for (int i = 0; i < datas.length; i++) {
    //         typeOfYogas.add(f.data['typeofyogas'][i]);
    //       }
    //   });
    //   });
    // }