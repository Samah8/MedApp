
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:med/db/app_db.dart';
import 'package:med/db/medicine_entity.dart';
import 'package:med/ui/add_medicine.dart';
import 'package:med/ui/edit_medicine.dart';
import 'package:med/widgets/local_notify_manager.dart';
import 'package:provider/provider.dart';

import '../notifier/med_change_notifier.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen(  {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NotificationService localNotifyManager= NotificationService();
  Medicine medicine=Medicine();


  @override
  void initState() {
    super.initState();
    localNotifyManager.initialize();
  }

  @override
  void dispose(){
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Medicines"),
            backgroundColor: const Color(0xff1222AC),
            centerTitle: true,
          ),
          body: FutureBuilder<List<MedicineData>>(
                future: Provider.of<AppDb>(context).getMedicines(),
                builder: (context,snapshot){
                  final List<MedicineData>? medicines=snapshot.data;

                  if(snapshot.connectionState!=ConnectionState.done){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                    if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.hasError.toString()),
                      );
                  }
                    if(medicine!=null) {

                        return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ListView.builder(
                              itemCount: medicines?.length,
                              itemBuilder: (context, index) {
                                final medicine = medicines![index];
                                DateTime date = DateFormat.jm().parse(medicine.time.toString());
                                var myTime = DateFormat("HH:mm").format(date);
                                 localNotifyManager.sheduledNotification(
                                    int.parse(myTime.toString().split(':')[0]),
                                    int.parse(myTime.toString().split(":")[1]),
                                    medicine
                                );
                                print("Time: $myTime");
                                return  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      color: Colors.white,
                                      child: ExpansionTile(
                                        iconColor:  const Color(0xff1222AC),

                                        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                        title: Text(
                                          medicine.name,
                                          maxLines: 2,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Color(0xff1222AC),),
                                        ),
                                        subtitle: Text(medicine.time,style: TextStyle(color:  Color(0xff1222AC)),),
                                        children: [
                                          buildButtons(context, medicine),
                                        ],
                                      ),

                                  ),
                                );
                              },
                            )
                        );
                      }

                  return const Text('No Medicine Found .');
                },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff1222AC),
            onPressed: ()async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddMedicine()),
              );
            },
           child: const Icon(Icons.add),
          ),
        ),
    );
  }
  Widget buildButtons(BuildContext context, MedicineData medicine) => Row(
    children: [
      Expanded(
        child: TextButton.icon(
          label: const Text('Edit'),
          icon: const Icon(Icons.edit),
          onPressed: () {
           Get.to(EditMedicine(id: medicine.id));
          }
            ),
          ),
      Expanded(
        child: TextButton.icon(
          label: const Text('Delete'),
          icon: const Icon(Icons.delete),
          onPressed: () {
            Provider.of<AppDb>(context,listen:false).deleteMedicine(medicine.id).then((value) => ScaffoldMessenger.of(context)
                .showMaterialBanner(
                MaterialBanner(
                  backgroundColor:Colors.red[700] ,
                  content: const Text('This Medicine deleted ',style:TextStyle(color: Colors.white),),
                  actions: [TextButton(
                      child:const Text('Close',style:TextStyle(color: Colors.white),) ,
                      onPressed:(){
                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                        Get.back();
                      }
                  )
                  ],
                )
            )
            );
            Provider.of<AppDb>(context,listen: false).allMedicines;
         }
        ),
      )
    ],
  );


}
