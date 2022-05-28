
import 'dart:io';
import 'package:drift/native.dart';
import 'package:med/db/medicine_entity.dart';
import 'package:path/path.dart' as path;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
part 'app_db.g.dart';
LazyDatabase _openConnection(){
  return LazyDatabase(()async{

    final dbFolder=await getApplicationDocumentsDirectory();
    final file=File(path.join(dbFolder.path,'medicine.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables:[Medicine])
 class AppDb extends _$AppDb{

  AppDb():super(_openConnection());

  @override
  int get schemaVersion=>1;

  Future <List<MedicineData>> getMedicines()async{
    return await select(medicine).get();
  }

  Stream<List<MedicineData>> get allMedicines  {
   return  select(medicine).watch();
  }

  Future <MedicineData> getMedicine(int id)async{
    return await (select(medicine)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future <bool> updateMedicine(MedicineCompanion entity)async{
    return await update(medicine).replace(entity);
  }

  Future <int> insertMedicine(MedicineCompanion entity)async{
    return await into(medicine).insert(entity);
  }

  Future <int> deleteMedicine(int id)async{
    return await (delete(medicine)..where((tbl) => tbl.id.equals(id))).go();
  }
}