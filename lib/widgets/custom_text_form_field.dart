
import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({
    Key? key,
    required TextEditingController controller,
    required String txtlabel,
  })
      :_controller=controller,_txtlabel=txtlabel, super(key: key);

  final TextEditingController _controller;
 final String _txtlabel;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: _controller,
      keyboardType:TextInputType.name,
      decoration:  InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        label: Text(_txtlabel)
      ),
      validator: (value){
        if(value==null || value.isEmpty){
          return '$_txtlabel Cannot be empty';
        }
        return null;
      },
    );
  }
}

class CustomDatepickerFormField extends StatelessWidget {
   final TextEditingController _controller;
   final String _txtlabel;
  final  VoidCallback _callback;
  const CustomDatepickerFormField({
    Key? key,
    required TextEditingController controller,
    required String txtlabel,
    required VoidCallback callback,
  })
      :_controller=controller ,_txtlabel=txtlabel , _callback=callback ,super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _controller,
      keyboardType:TextInputType.name,
      decoration:  InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          label: Text(_txtlabel)
      ),
      validator: (value){
        if(value==null || value.isEmpty){
          return '$_txtlabel Cannot be empty';
        }
        return null;
      },
      onTap: _callback,
    );
  }
}
