
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:med/db/app_db.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/drop_down.dart';


class EditMedicine extends StatefulWidget {
 final int id;
   const EditMedicine({Key? key,required this.id}) : super(key: key);

  @override
  _EditMedicineState createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {
   late AppDb _db;
  late MedicineData _medicineData;
  final TextEditingController _namecontroller =TextEditingController();
  final TextEditingController _notecontroller =TextEditingController();
  late TextEditingController _startDcontroller =TextEditingController();
  late TextEditingController _endDcontroller =TextEditingController();
  late TextEditingController _timecontroller =TextEditingController();
  late TextEditingController _frecontroller =TextEditingController();
  late TextEditingController _remcontroller =TextEditingController();
  DateTime  _startDate=DateTime.now();
  DateTime  _endDate=DateTime.now();
  TimeOfDay ? _selectedTime;
  int _selectedremind=4;
  String _selectedfrequency='Daily';
  List<String>frequencylist=["Daily","Weekly" ];
  List<int>remindlist=[2, 4, 8,12, 24];

  @override
  void initState() {
    super.initState();
    _db=AppDb();
    getMedicine();
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
        title:  const Text(('Edit Medicine')),
        backgroundColor: const Color(0xff1222AC),
        centerTitle: true,
        actions: [
        TextButton(
              onPressed: (){
                editMedicine();
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 8.0,top: 6.0),
                child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 16),),
              )
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 10.0,),
            Text("Medicine Name",style:GoogleFonts.sansita(textStyle:const TextStyle(
                fontSize: 15,
                color: Color(0xff1222AC),
                fontWeight: FontWeight.w500)
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomTextFormField(controller: _namecontroller,txtlabel: 'Medicine Name'),
            ),
            const SizedBox(height: 3.0,),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InputField(title: "Medicine Frequency", hint: '',controller: _frecontroller,
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
            ),
            const SizedBox(height: 20.0,),
            Text("Time",style:GoogleFonts.sansita(textStyle:const TextStyle(
                fontSize: 15,
                color: Color(0xff1222AC),
                fontWeight: FontWeight.w500)
            ),
            ),
            const SizedBox(height: 2.0,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomDatepickerFormField(controller: _timecontroller, txtlabel: "Start Time",
                  callback: (){
                    pickTime(context);
                  }),
            ),
            const SizedBox(height: 3.0,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InputField(title: "Remind me ", hint:"Every $_selectedremind hours",controller: _remcontroller,
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
            ),
            const SizedBox(height: 20.0,),
            Text("Start Date",style:GoogleFonts.sansita(textStyle:const TextStyle(
                fontSize: 15,
                color: Color(0xff1222AC),
                fontWeight: FontWeight.w500)
            ),
            ),
            const SizedBox(height: 2.0,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomDatepickerFormField(controller: _startDcontroller, txtlabel: 'Start Date',
                  callback:(){
                    pickStartDate(context);
                  }
              ),
            ),
            const SizedBox(height: 20.0,),

            Text("End Date",style:GoogleFonts.sansita(textStyle:const TextStyle(
                fontSize: 15,
                color: Color(0xff1222AC),
                fontWeight: FontWeight.w500)
            ),
            ),
            const SizedBox(height: 2.0,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomDatepickerFormField(controller: _endDcontroller, txtlabel: "End Date",
                  callback: (){
                    pickEndDate(context);
                  }
              ),
            ),
            const SizedBox(height: 20.0,),
            Text("Note",style:GoogleFonts.sansita(textStyle:const TextStyle(
                fontSize: 15,
                color: Color(0xff1222AC),
                fontWeight: FontWeight.w500)
            ),
            ),
            const SizedBox(height: 2.0,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomTextFormField(controller: _notecontroller,txtlabel: 'Note'),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> pickStartDate(BuildContext context)async{
    final newDate=await showDatePicker(
        context: context,
        initialDate:_startDate,
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
    final newDate=await showDatePicker(
        context: context,
        initialDate:_endDate,
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

  void editMedicine(){
    final entity=MedicineCompanion(
        id: drift.Value(widget.id),
        name: drift.Value(_namecontroller.text),
        note: drift.Value(_notecontroller.text),
        startDate:drift.Value(_startDate),
        endDate: drift.Value(_endDate),
        time: drift.Value(_timecontroller.text),
        remind:drift.Value(int.parse(_remcontroller.text)),
        frequency: drift.Value(_frecontroller.text)
    );
    _db.updateMedicine(entity).then((value) => ScaffoldMessenger.of(context)
        .showMaterialBanner(
        MaterialBanner(
          backgroundColor:Colors.blue[900] ,
          content: const Text('This Medicine updated  ',style:TextStyle(color: Colors.white),),
          actions: [TextButton(
              child:const Text('Close',style:TextStyle(color: Colors.white),) ,
              onPressed:() {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                Get.back();
              })],
        )
    )
    );
   _db.allMedicines;
  }



  Future <void> getMedicine ()async{
    _medicineData=await _db.getMedicine(widget.id);
    _namecontroller.text=_medicineData.name;
    _notecontroller.text=_medicineData.note;
    _frecontroller.text=_medicineData.frequency;
    _endDcontroller.text=_medicineData.endDate.toIso8601String();
    _startDcontroller.text=_medicineData.startDate.toIso8601String();
    _remcontroller.text=_medicineData.remind.toString();
    _timecontroller.text=_medicineData.time;
  }

}

