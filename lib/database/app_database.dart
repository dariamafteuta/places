import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [SearchList, FavoriteList, VisitedList])
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(_openConnection());

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

  Future<List<FavoriteListData>> getMyFavoriteList() async {
    return select(favoriteList).get();
  }

  Future<int> insertMyFavorite(FavoriteListCompanion favoriteListCompanion) async {
    return into(favoriteList).insert(favoriteListCompanion);
  }

  Future<int> deleteMyFavorite(FavoriteListData favoriteListData) async {
    return (delete(favoriteList)
      ..where((tbl) => tbl.id.equals(favoriteListData.id)))
        .go();
  }

  Future<void> updateSelectedDate(int id, DateTime? selectedDate) {
    return (update(favoriteList)..where((tbl) => tbl.id.equals(id)))
        .write(FavoriteListCompanion(selectedDate: Value(selectedDate)));
  }

  Future<DateTime?> getSelectedDateByIdF(int id) {
    return (select(favoriteList)..where((tbl) => tbl.id.equals(id)))
        .map((row) => row.selectedDate)
        .getSingleOrNull();
  }

  Future<List<VisitedListData>> getMyVisitedList() async {
    return select(visitedList).get();
  }

  Future<int> insertMyVisited(VisitedListCompanion visitedListCompanion) async {
    return into(visitedList).insert(visitedListCompanion);
  }

  Future<int> deleteMyVisited(VisitedListData visitedListData) async {
    return (delete(visitedList)
      ..where((tbl) => tbl.id.equals(visitedListData.id)))
        .go();
  }

  Future<DateTime?> getSelectedDateByIdV(int id) {
    return (select(visitedList)..where((tbl) => tbl.id.equals(id)))
        .map((row) => row.selectedDate)
        .getSingleOrNull();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    debugPrint(dbFolder.path);
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}

class SearchList extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
}

class FavoriteList extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get selectedDate => dateTime().nullable()();
}

class VisitedList extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get selectedDate => dateTime().nullable()();
}