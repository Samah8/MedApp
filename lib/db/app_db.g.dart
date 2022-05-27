// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MedicineData extends DataClass implements Insertable<MedicineData> {
  final int id;
  final String name;
  final String frequency;
  final String time;
  final int remind;
  final DateTime startDate;
  final DateTime endDate;
  final String note;
  MedicineData(
      {required this.id,
      required this.name,
      required this.frequency,
      required this.time,
      required this.remind,
      required this.startDate,
      required this.endDate,
      required this.note});
  factory MedicineData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MedicineData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}Med_Name'])!,
      frequency: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}Frequency'])!,
      time: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}Time'])!,
      remind: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}Remind'])!,
      startDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}Start_Date'])!,
      endDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}End_Date'])!,
      note: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}Note'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['Med_Name'] = Variable<String>(name);
    map['Frequency'] = Variable<String>(frequency);
    map['Time'] = Variable<String>(time);
    map['Remind'] = Variable<int>(remind);
    map['Start_Date'] = Variable<DateTime>(startDate);
    map['End_Date'] = Variable<DateTime>(endDate);
    map['Note'] = Variable<String>(note);
    return map;
  }

  MedicineCompanion toCompanion(bool nullToAbsent) {
    return MedicineCompanion(
      id: Value(id),
      name: Value(name),
      frequency: Value(frequency),
      time: Value(time),
      remind: Value(remind),
      startDate: Value(startDate),
      endDate: Value(endDate),
      note: Value(note),
    );
  }

  factory MedicineData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicineData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      frequency: serializer.fromJson<String>(json['frequency']),
      time: serializer.fromJson<String>(json['time']),
      remind: serializer.fromJson<int>(json['remind']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'frequency': serializer.toJson<String>(frequency),
      'time': serializer.toJson<String>(time),
      'remind': serializer.toJson<int>(remind),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'note': serializer.toJson<String>(note),
    };
  }

  MedicineData copyWith(
          {int? id,
          String? name,
          String? frequency,
          String? time,
          int? remind,
          DateTime? startDate,
          DateTime? endDate,
          String? note}) =>
      MedicineData(
        id: id ?? this.id,
        name: name ?? this.name,
        frequency: frequency ?? this.frequency,
        time: time ?? this.time,
        remind: remind ?? this.remind,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        note: note ?? this.note,
      );
  @override
  String toString() {
    return (StringBuffer('MedicineData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('frequency: $frequency, ')
          ..write('time: $time, ')
          ..write('remind: $remind, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, frequency, time, remind, startDate, endDate, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicineData &&
          other.id == this.id &&
          other.name == this.name &&
          other.frequency == this.frequency &&
          other.time == this.time &&
          other.remind == this.remind &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.note == this.note);
}

class MedicineCompanion extends UpdateCompanion<MedicineData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> frequency;
  final Value<String> time;
  final Value<int> remind;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String> note;
  const MedicineCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.frequency = const Value.absent(),
    this.time = const Value.absent(),
    this.remind = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.note = const Value.absent(),
  });
  MedicineCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String frequency,
    required String time,
    required int remind,
    required DateTime startDate,
    required DateTime endDate,
    required String note,
  })  : name = Value(name),
        frequency = Value(frequency),
        time = Value(time),
        remind = Value(remind),
        startDate = Value(startDate),
        endDate = Value(endDate),
        note = Value(note);
  static Insertable<MedicineData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? frequency,
    Expression<String>? time,
    Expression<int>? remind,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'Med_Name': name,
      if (frequency != null) 'Frequency': frequency,
      if (time != null) 'Time': time,
      if (remind != null) 'Remind': remind,
      if (startDate != null) 'Start_Date': startDate,
      if (endDate != null) 'End_Date': endDate,
      if (note != null) 'Note': note,
    });
  }

  MedicineCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? frequency,
      Value<String>? time,
      Value<int>? remind,
      Value<DateTime>? startDate,
      Value<DateTime>? endDate,
      Value<String>? note}) {
    return MedicineCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
      time: time ?? this.time,
      remind: remind ?? this.remind,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['Med_Name'] = Variable<String>(name.value);
    }
    if (frequency.present) {
      map['Frequency'] = Variable<String>(frequency.value);
    }
    if (time.present) {
      map['Time'] = Variable<String>(time.value);
    }
    if (remind.present) {
      map['Remind'] = Variable<int>(remind.value);
    }
    if (startDate.present) {
      map['Start_Date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['End_Date'] = Variable<DateTime>(endDate.value);
    }
    if (note.present) {
      map['Note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicineCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('frequency: $frequency, ')
          ..write('time: $time, ')
          ..write('remind: $remind, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $MedicineTable extends Medicine
    with TableInfo<$MedicineTable, MedicineData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicineTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'Med_Name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _frequencyMeta = const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String?> frequency = GeneratedColumn<String?>(
      'Frequency', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String?> time = GeneratedColumn<String?>(
      'Time', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _remindMeta = const VerificationMeta('remind');
  @override
  late final GeneratedColumn<int?> remind = GeneratedColumn<int?>(
      'Remind', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime?> startDate = GeneratedColumn<DateTime?>(
      'Start_Date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _endDateMeta = const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime?> endDate = GeneratedColumn<DateTime?>(
      'End_Date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String?> note = GeneratedColumn<String?>(
      'Note', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, frequency, time, remind, startDate, endDate, note];
  @override
  String get aliasedName => _alias ?? 'medicine';
  @override
  String get actualTableName => 'medicine';
  @override
  VerificationContext validateIntegrity(Insertable<MedicineData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('Med_Name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['Med_Name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('Frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['Frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('Time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['Time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('Remind')) {
      context.handle(_remindMeta,
          remind.isAcceptableOrUnknown(data['Remind']!, _remindMeta));
    } else if (isInserting) {
      context.missing(_remindMeta);
    }
    if (data.containsKey('Start_Date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['Start_Date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('End_Date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['End_Date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('Note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['Note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicineData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MedicineData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MedicineTable createAlias(String alias) {
    return $MedicineTable(attachedDatabase, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $MedicineTable medicine = $MedicineTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [medicine];
}
