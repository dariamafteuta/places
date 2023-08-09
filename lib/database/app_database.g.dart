// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SearchListTable extends SearchList
    with TableInfo<$SearchListTable, SearchListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchListTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'search_list';
  @override
  String get actualTableName => 'search_list';
  @override
  VerificationContext validateIntegrity(Insertable<SearchListData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SearchListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchListData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SearchListTable createAlias(String alias) {
    return $SearchListTable(attachedDatabase, alias);
  }
}

class SearchListData extends DataClass implements Insertable<SearchListData> {
  final int id;
  final String name;
  const SearchListData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  SearchListCompanion toCompanion(bool nullToAbsent) {
    return SearchListCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory SearchListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchListData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  SearchListData copyWith({int? id, String? name}) => SearchListData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SearchListData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchListData &&
          other.id == this.id &&
          other.name == this.name);
}

class SearchListCompanion extends UpdateCompanion<SearchListData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> rowid;
  const SearchListCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchListCompanion.insert({
    required int id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<SearchListData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchListCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? rowid}) {
    return SearchListCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchListCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoriteListTable extends FavoriteList
    with TableInfo<$FavoriteListTable, FavoriteListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteListTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _selectedDateMeta =
      const VerificationMeta('selectedDate');
  @override
  late final GeneratedColumn<DateTime> selectedDate = GeneratedColumn<DateTime>(
      'selected_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, selectedDate];
  @override
  String get aliasedName => _alias ?? 'favorite_list';
  @override
  String get actualTableName => 'favorite_list';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteListData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('selected_date')) {
      context.handle(
          _selectedDateMeta,
          selectedDate.isAcceptableOrUnknown(
              data['selected_date']!, _selectedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FavoriteListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteListData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      selectedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}selected_date']),
    );
  }

  @override
  $FavoriteListTable createAlias(String alias) {
    return $FavoriteListTable(attachedDatabase, alias);
  }
}

class FavoriteListData extends DataClass
    implements Insertable<FavoriteListData> {
  final int id;
  final DateTime? selectedDate;
  const FavoriteListData({required this.id, this.selectedDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || selectedDate != null) {
      map['selected_date'] = Variable<DateTime>(selectedDate);
    }
    return map;
  }

  FavoriteListCompanion toCompanion(bool nullToAbsent) {
    return FavoriteListCompanion(
      id: Value(id),
      selectedDate: selectedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedDate),
    );
  }

  factory FavoriteListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteListData(
      id: serializer.fromJson<int>(json['id']),
      selectedDate: serializer.fromJson<DateTime?>(json['selectedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'selectedDate': serializer.toJson<DateTime?>(selectedDate),
    };
  }

  FavoriteListData copyWith(
          {int? id, Value<DateTime?> selectedDate = const Value.absent()}) =>
      FavoriteListData(
        id: id ?? this.id,
        selectedDate:
            selectedDate.present ? selectedDate.value : this.selectedDate,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteListData(')
          ..write('id: $id, ')
          ..write('selectedDate: $selectedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, selectedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteListData &&
          other.id == this.id &&
          other.selectedDate == this.selectedDate);
}

class FavoriteListCompanion extends UpdateCompanion<FavoriteListData> {
  final Value<int> id;
  final Value<DateTime?> selectedDate;
  final Value<int> rowid;
  const FavoriteListCompanion({
    this.id = const Value.absent(),
    this.selectedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteListCompanion.insert({
    required int id,
    this.selectedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<FavoriteListData> custom({
    Expression<int>? id,
    Expression<DateTime>? selectedDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (selectedDate != null) 'selected_date': selectedDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteListCompanion copyWith(
      {Value<int>? id, Value<DateTime?>? selectedDate, Value<int>? rowid}) {
    return FavoriteListCompanion(
      id: id ?? this.id,
      selectedDate: selectedDate ?? this.selectedDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (selectedDate.present) {
      map['selected_date'] = Variable<DateTime>(selectedDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteListCompanion(')
          ..write('id: $id, ')
          ..write('selectedDate: $selectedDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VisitedListTable extends VisitedList
    with TableInfo<$VisitedListTable, VisitedListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisitedListTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _selectedDateMeta =
      const VerificationMeta('selectedDate');
  @override
  late final GeneratedColumn<DateTime> selectedDate = GeneratedColumn<DateTime>(
      'selected_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, selectedDate];
  @override
  String get aliasedName => _alias ?? 'visited_list';
  @override
  String get actualTableName => 'visited_list';
  @override
  VerificationContext validateIntegrity(Insertable<VisitedListData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('selected_date')) {
      context.handle(
          _selectedDateMeta,
          selectedDate.isAcceptableOrUnknown(
              data['selected_date']!, _selectedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  VisitedListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VisitedListData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      selectedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}selected_date']),
    );
  }

  @override
  $VisitedListTable createAlias(String alias) {
    return $VisitedListTable(attachedDatabase, alias);
  }
}

class VisitedListData extends DataClass implements Insertable<VisitedListData> {
  final int id;
  final DateTime? selectedDate;
  const VisitedListData({required this.id, this.selectedDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || selectedDate != null) {
      map['selected_date'] = Variable<DateTime>(selectedDate);
    }
    return map;
  }

  VisitedListCompanion toCompanion(bool nullToAbsent) {
    return VisitedListCompanion(
      id: Value(id),
      selectedDate: selectedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedDate),
    );
  }

  factory VisitedListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisitedListData(
      id: serializer.fromJson<int>(json['id']),
      selectedDate: serializer.fromJson<DateTime?>(json['selectedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'selectedDate': serializer.toJson<DateTime?>(selectedDate),
    };
  }

  VisitedListData copyWith(
          {int? id, Value<DateTime?> selectedDate = const Value.absent()}) =>
      VisitedListData(
        id: id ?? this.id,
        selectedDate:
            selectedDate.present ? selectedDate.value : this.selectedDate,
      );
  @override
  String toString() {
    return (StringBuffer('VisitedListData(')
          ..write('id: $id, ')
          ..write('selectedDate: $selectedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, selectedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisitedListData &&
          other.id == this.id &&
          other.selectedDate == this.selectedDate);
}

class VisitedListCompanion extends UpdateCompanion<VisitedListData> {
  final Value<int> id;
  final Value<DateTime?> selectedDate;
  final Value<int> rowid;
  const VisitedListCompanion({
    this.id = const Value.absent(),
    this.selectedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VisitedListCompanion.insert({
    required int id,
    this.selectedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<VisitedListData> custom({
    Expression<int>? id,
    Expression<DateTime>? selectedDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (selectedDate != null) 'selected_date': selectedDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VisitedListCompanion copyWith(
      {Value<int>? id, Value<DateTime?>? selectedDate, Value<int>? rowid}) {
    return VisitedListCompanion(
      id: id ?? this.id,
      selectedDate: selectedDate ?? this.selectedDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (selectedDate.present) {
      map['selected_date'] = Variable<DateTime>(selectedDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitedListCompanion(')
          ..write('id: $id, ')
          ..write('selectedDate: $selectedDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $SearchListTable searchList = $SearchListTable(this);
  late final $FavoriteListTable favoriteList = $FavoriteListTable(this);
  late final $VisitedListTable visitedList = $VisitedListTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [searchList, favoriteList, visitedList];
}
