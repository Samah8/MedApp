import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class InputField extends StatelessWidget {
  final String title;
  final intial ;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final  Function(dynamic) ?onclick;
  const InputField ({Key? key, required this.title, required this.hint,this.intial,this.controller, this.widget,  this.onclick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Container(
            height: 52,
            margin:const EdgeInsets.only(top: 8.0),
            padding:const EdgeInsets.only(left: 8.0) ,
            decoration:BoxDecoration(
                border:Border.all(
                    color: Colors.grey,
                    width: 1.0
                ),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(
                    child:TextFormField(
                      readOnly: true,
                      initialValue:intial ,
                      autofocus: false,
                      cursorColor:Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: hint,

                      ),

                      onChanged:onclick,

                    )
                ),
                widget==null?Container():Container(child: widget)
              ],
            ),
          ),
        ],
      ),
    );
  }
}