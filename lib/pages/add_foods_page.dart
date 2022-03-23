import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_foods/components/form_input.dart';
import 'package:random_foods/components/image_selector.dart';
import 'package:random_foods/components/text_icon_button.dart';
import 'package:random_foods/models/food.dart';
import 'package:random_foods/service/foods_service.dart';
import 'package:random_foods/utils/datetime_manager.dart';

class AddFoodsPage extends StatefulWidget {
  const AddFoodsPage({Key? key}) : super(key: key);

  @override
  State<AddFoodsPage> createState() => _AddFoodsPageState();
}

class _AddFoodsPageState extends State<AddFoodsPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _star = TextEditingController();
  final GlobalKey _form = GlobalKey();
  final FoodsService _service = FoodsService();
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
          key: _form,
          child: Column(
            children: [
              FormInput(
                controller: _name,
                validator: (e) {},
                label: '名称',
                hint: '输入食物名称',
                icon: Icons.add,
              ),
              FormInput(
                controller: _price,
                validator: (e) {},
                label: '价格',
                hint: '输入食物的价格',
                icon: Icons.add,
              ),
              FormInput(
                controller: _star,
                validator: (e) {},
                label: '分数',
                hint: '输入对食物的评分',
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
                marginTop: 30,
                onTap: () {
                  if ((_form.currentState as FormState).validate()) {}
                  _service.valid(
                    file: imageFile,
                    foodName: _name.text,
                    success: () {
                      _service.storage(
                        file: imageFile!,
                        onImageStorage: (image) {
                          return Food(
                            name: _name.text,
                            image: image,
                            times: 0,
                            entryDate: DateTimeManager().getDateTime(),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
