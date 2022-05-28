
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med/db/app_db.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/drop_down.dart';


class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _formkey=GlobalKey<FormState>();

  final TextEditingController _namecontroller =TextEditingController();
  final TextEditingController _notecontroller =TextEditingController();
  late final TextEditingController _startDcontroller =TextEditingController();
  late final TextEditingController _endDcontroller =TextEditingController();
  late final TextEditingController _timecontroller =TextEditingController();
  late final TextEditingController _frecontroller =TextEditingController();
  late final TextEditingController _remcontroller =TextEditingController();
  DateTime ? _startDate;
  DateTime ? _endDate;
  TimeOfDay ? _selectedTime;
  int _selectedremind=4;
  String _selectedfrequency='Weekly';
  List<String>frequencylist=["Daily","Weekly"];
  List<int>remindlist=[2, 4, 8,12, 24];

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    _namecontroller.dispose();
    _notecontroller.dispose();
    _startDcontroller.dispose();
    _timecontroller.dispose();
    _endDcontroller.dispose();
    _remcontroller.dispose();
    _frecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(('Add Medicine')),
        centerTitle: true,
        actions: [
         TextButton(
              onPressed: (){
                addMedicine();
              },
              child:const Padding(
                padding: EdgeInsets.only(top: 8.0,right: 4),
                child: Text('Add',style:TextStyle(color: Colors.white,fontSize: 18)),
              ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              const SizedBox(height: 7.0,),
              CustomTextFormField(controller: _namecontroller,txtlabel: 'Medicine Name'),
              const SizedBox(height: 10.0,),
              InputField(title: "Medicine Frequency", hint: '',controller: _frecontroller,
                widget: DropdownButton(
                  elevation: 4,
                  iconSize: 32,
                  underline: Container(width: 0.0),
                  icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey),
                  onChanged: (String? newval){
                    setState(() {
                      _selectedfrequency=newval!;
                      _frecontroller.text=_selectedfrequency;
                    });
                  },
                  items:frequencylist.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String> (
                        value: value,
                        child:Text(value)
                    );
                  }
                  ).toList(),
                ),
              ),
              const SizedBox(height: 20.0,),
              CustomDatepickerFormField(controller: _timecontroller, txtlabel: "Start Time",
                  callback: (){
                   pickTime(context);
                  }),
              const SizedBox(height: 10.0,),
              InputField(title: "Remind me ", hint:"Every $_selectedremind hours",controller: _remcontroller,
                widget:DropdownButton(
                    elevation:4,
                    underline: Container(width: 0),
                    icon:const Icon(Icons.keyboard_arrow_down,color: Colors.grey),
                    iconSize: 32,
                    onChanged: (String? newval){
                      setState(() {
                        _selectedremind=int.parse(newval!);
                        _remcontroller.text=newval;
                      });
                    },
                    items:remindlist.map<DropdownMenuItem<String>>((int value)
                    {
                      return DropdownMenuItem<String> (
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }
                    ).toList()
                ) ,
              ),
              const SizedBox(height: 20.0,),
              CustomDatepickerFormField(controller: _startDcontroller, txtlabel: 'Start Date',
                  callback:(){
                 pickStartDate(context);
                  }
                  ),
              const SizedBox(height: 20.0,),
              CustomDatepickerFormField(controller: _endDcontroller, txtlabel: "End Date",
                  callback: (){
                pickEndDate(context);
                  }
                  ),
              const SizedBox(height: 20.0,),
              CustomTextFormField(controller: _notecontroller,txtlabel: 'Note'),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> pickStartDate(BuildContext context)async{
    final initialDate=DateTime.now();
    final newDate=await showDatePicker(
        context: context,
        initialDate:_startDate?? initialDate,
        firstDate:DateTime(DateTime.now().year-10),
        lastDate: DateTime(DateTime.now().year+2)
    );
    if(newDate==null){
      return;
    }
    setState(() {
      _startDate=newDate;
      String date=DateFormat.yMd().format(newDate);
      _startDcontroller.text=date;
    });
  }
  Future<void> pickEndDate(BuildContext context)async{
    final initialDate=DateTime.now();
    final newDate=await showDatePicker(
        context: context,
        initialDate:_endDate?? initialDate,
        firstDate:DateTime(DateTime.now().year-10),
        lastDate: DateTime(DateTime.now().year+2)
    );
    if(newDate==null){
      return;
    }
    setState(() {
      _endDate=newDate;
      String date=DateFormat.yMd().format(newDate);
      _endDcontroller.text=date;
    });
  }
  Future<void> pickTime(BuildContext context)async{
    TimeOfDay initialTime=TimeOfDay.now();
    final  timeOfDay=
        await showTimePicker(context: context,
            initialTime:_selectedTime??initialTime
        );
    if(timeOfDay!=null) {
      setState(() {
        _selectedTime=timeOfDay;
        String time=timeOfDay.format(context);
        _timecontroller.text=time;
      });
    }
  }



  void addMedicine(){
    final isVaild=_formkey.currentState?.validate();
    if(isVaild!=null && isVaild) {
      final entity = MedicineCompanion(
          name: drift.Value(_namecontroller.text),
          note: drift.Value(_notecontroller.text),
          startDate: drift.Value(_startDate!),
          endDate: drift.Value(_endDate!),
          time: drift.Value(_timecontroller.text),
          remind: drift.Value(int.parse(_remcontroller.text)),
          frequency: drift.Value(_frecontroller.text)
      );
      Provider.of<AppDb>(context,listen: false).insertMedicine(entity).then((value) =>
          ScaffoldMessenger.of(context)
              .showMaterialBanner(
              MaterialBanner(
                backgroundColor: Colors.blue[900],
                content: Text('New Medicine inserted $value',
                  style: const TextStyle(color: Colors.white),),
                actions: [TextButton(
                    child: const Text(
                      'Close', style: TextStyle(color: Colors.white),),
                    onPressed: () => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner())
                ],
              )
          )
      );
    }
  }

}

