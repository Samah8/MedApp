
import 'package:drift/drift.dart';


class Medicine extends Table{

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name=>text().named('Med_Name')();
  TextColumn get frequency=>text().named('Frequency')();
  TextColumn get time=>text().named('Time')();
  IntColumn get remind=>integer().named('Remind')();
  DateTimeColumn get startDate=>dateTime().named('Start_Date')();
  DateTimeColumn get endDate=>dateTime().named('End_Date')();
  TextColumn get note=> text().named('Note')();
}