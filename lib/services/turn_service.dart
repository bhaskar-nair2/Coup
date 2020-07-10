import 'package:coup/modals/firebase/fbModels.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/services/global.dart';
import 'package:coup/services/types.dart';
import 'package:rxdart/rxdart.dart';

class TurnService<T> {
  final String collection = 'turns';

  TurnService();

  Stream<T> get documentStream {
    Document<T> doc = Document<T>(path: '$collection/${IDManager.turnId}');
    return doc.streamData();
  }

  Future<T> getDocument() async {
    GameTable table = await Global.tableref.getDocument();

    if (table != null) {
      Document doc = Document<T>(path: '$collection/${table.turnId}');
      return doc.getData();
    } else {
      return null;
    }
  }

  Future<void> upsert(Map data) async {
    GameTable table = await Global.tableref.getDocument();
    Document<T> ref = Document(path: '$collection/${table.turnId}');
    return ref.upsert(data);
  }
}
