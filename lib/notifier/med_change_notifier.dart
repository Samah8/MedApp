
import 'package:flutter/foundation.dart';
import 'package:med/db/app_db.dart';
class MedChangeNotifier extends ChangeNotifier {

  AppDb? _appDb;

  void iniitDb(AppDb db) {
    _appDb = db;
  }

  List<MedicineData> _medicinelistfuture = [];

  List<MedicineData> get medicinelistfuture => _medicinelistfuture;
  List<MedicineData> _medicineliststream = [];

  List<MedicineData> get medicineliststream => _medicineliststream;
  MedicineData? _medicineData;

  MedicineData? get medicinedata => _medicineData;

  String _error = '';
  String get error => _error;

  bool _added = false;
  bool get added => _added;

  bool _isUpdated=false;
  bool get isUpdated=>_isUpdated;

  bool _isdeleted=false;
  bool get isdeleted=>_isdeleted;

  void getmedicinefuture() {
    _appDb?.getMedicines().then((value) {
      _medicinelistfuture = value;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }

  void getmedicinestream() {
    _appDb?.allMedicines.listen((event) {
      _medicinelistfuture = event;
    });
    notifyListeners();
  }

  void getsingleMedicine(int id) {
    _appDb?.getMedicine(id).then((value) {
      _medicineData = value;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }


  void createMedicine(MedicineCompanion entity) {
    _appDb?.insertMedicine(entity)
        .then((value) {
      _added = value ==1?true: false;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }


  void updateMedicine(MedicineCompanion entity) {
    _appDb?.updateMedicine(entity)
    .then((value) {
      _isUpdated = value;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }


  void deleteMedicine(int id) {
    _appDb?.deleteMedicine(id)
        .then((value) {
      _isdeleted = value==1 ?true:false;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }

}