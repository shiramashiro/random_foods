import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_foods/components/form_input.dart';
import 'package:random_foods/components/image_selector.dart';
import 'package:random_foods/components/text_icon_button.dart';
import 'package:random_foods/models/food.dart';
import 'package:random_foods/service/database/db_operation.dart';
import 'package:random_foods/utils/picture_operation.dart';

class AddFoodsPage extends StatefulWidget {
  const AddFoodsPage({Key? key}) : super(key: key);

  @override
  State<AddFoodsPage> createState() => _AddFoodsPageState();
}

class _AddFoodsPageState extends State<AddFoodsPage> {
  final TextEditingController _name = TextEditingController();
  final PictureOperation _po = PictureOperation();
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新增食物'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Form(
          child: Column(
            children: [
              FormInput(
                controller: _name,
                validator: (e) {},
                label: '名称',
                hint: '请输入食物名称',
                icon: Icons.add,
              ),
              ImageSelector(
                onImagePicked: (e) {
                  setState(() {
                    imageFile = e;
                  });
                },
              ),
              TextIconButton(
                text: '保存',
                icon: Icons.add,
                onTap: () async {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
