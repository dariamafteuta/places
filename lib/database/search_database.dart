
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'search_database.g.dart';

@DriftDatabase(tables: [SearchList])
class SearchDatabase extends _$SearchDatabase{
  SearchDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<SearchListData>> getMySearchList() async {
    return select(searchList).get();
  }

  Future<int> insertMySearch(SearchListCompanion searchListCompanion) async {
    return into(searchList).insert(searchListCompanion);
  }

  Future<int> deleteMySearch(SearchListData searchListData) async {
    return (delete(searchList)
      ..where((tbl) => tbl.id.equals(searchListData.id)))
        .go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

class SearchList extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
}