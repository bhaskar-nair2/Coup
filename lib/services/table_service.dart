import 'package:coup/modals/firebase/self.dart';
import 'package:coup/services/global.dart';
import 'package:coup/services/types.dart';
import 'package:rxdart/rxdart.dart';

class TableService<T> {
  final String collection = 'tables';

  TableService();

  Stream<T> get documentStream {
    return Global.selfRef.documentStream.switchMap((self) {
      if (self != null) {
        Document<T> doc = Document<T>(path: '$collection/${self.tableId}');
        return doc.streamData();
      } else {
        return null;
      }
    });
  }

  Future<T> getDocument() async {
    SelfPlayer player = await Global.selfRef.getDocument();

    if (player != null) {
      Document doc = Document<T>(path: '$collection/${player.tableId}');
      return doc.getData();
    } else {
      return null;
    }
  }

  Future<void> upsert(Map data) async {
    SelfPlayer player = await Global.selfRef.getDocument();
    Document<T> ref = Document(path: '$collection/${player.tableId}');
    return ref.upsert(data);
  }
}
