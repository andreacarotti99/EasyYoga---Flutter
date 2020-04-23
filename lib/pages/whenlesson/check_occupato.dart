import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


//funzione che controlla se il dato orario del dato giorno è occupato
Future<bool> controllaSeOccupatoIlGiorno(String formattedDay, String oraCheck) async {
  var orarioRicercato;
  var filtraggio = await Firestore.instance.collection('appointments')
      .where('data', isEqualTo: formattedDay)
      .where('ora', isEqualTo: oraCheck)
      .getDocuments(); 

  //ora ho un instanza di querysnapshot ma devo andare a prendere il documento che mi interessa, (insomma ho filtrato ma non ho 'preso' nulla)
  var listaElementiConOraCorrispondente = filtraggio.documents;
  if (listaElementiConOraCorrispondente.length > 0 ) {
    var elementoConOraCorrispondente = listaElementiConOraCorrispondente[0];
    orarioRicercato = elementoConOraCorrispondente.data['ora'];
  }
  
  if (orarioRicercato == null) {
    print('alle ${oraCheck} non è fissato nulla');
    return false;
  }
  else {
    print('alle ${oraCheck} è fissata una lezione');
    return true;
  }

}

