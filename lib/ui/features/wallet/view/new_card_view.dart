import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keepit/data/model/card_entity.dart';
import 'package:keepit/ui/features/wallet/view_model/wallet_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({
    this.name,
    this.value,
    this.description,
    this.id,
    super.key,
  });
  final int? id;
  final String? name;
  final String? value;
  final String? description;

  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _valueController;
  late final TextEditingController _descriptionController;
  late FocusNode nameFocusNode;
  late FocusNode valueFocusNode;
  late FocusNode descriptionFocusNode;
  bool isValueFieldValid = true;
  bool isNameFieldValid = true;

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    valueFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    _nameController = TextEditingController(text: widget.name);
    _valueController = TextEditingController(text: widget.value);
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    valueFocusNode.dispose();
    descriptionFocusNode.dispose();
    _nameController.dispose();
    _valueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void validateValueField() {
    final bool isValid = _valueController.text.length >= 5;
    if (isValueFieldValid != isValid) {
      setState(() {
        isValueFieldValid = isValid;
      });
    }
  }

  void validateNameField() {
    final bool isValid = _nameController.text.isNotEmpty;
    if (isNameFieldValid != isValid) {
      setState(() {
        isNameFieldValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color valueBorderColor = isValueFieldValid ? Colors.blue : Colors.red;
    final Color nameBorderColor = isNameFieldValid ? Colors.blue : Colors.red;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.goNamed('wallet');
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('New Card'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 95.w,
            height: 30.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: _nameController,
                  focusNode: nameFocusNode,
                  onChanged: (value) {
                    setState(() {
                      _nameController.text = value;
                    });
                    validateNameField();
                  },
                  onEditingComplete: () => nameFocusNode.nextFocus(),
                  decoration: InputDecoration(
                    labelText: 'Card Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: nameBorderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: nameBorderColor),
                    ),
                  ),
                ),
                TextField(
                  controller: _valueController,
                  focusNode: valueFocusNode,
                  onChanged: (value) {
                    setState(() {
                      _valueController.text = value;
                    });
                    validateValueField();
                  },
                  onEditingComplete: () => valueFocusNode.nextFocus(),
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: valueBorderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: valueBorderColor),
                    ),
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  focusNode: descriptionFocusNode,
                  onChanged: (value) {
                    setState(() {
                      _descriptionController.text = value;
                    });
                  },
                  // onEditingComplete: () => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                ListTile(
                  // TODO set ListTailTheme for custom style
                  leading: Icon(Icons.info),
                  title: Text(
                    'Do not give any sensitive data in the description (such as password).',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ),

          OutlinedButton(
            onPressed: () {
              final isValueValid = _valueController.text.length >= 5;
              final isNameValid = _nameController.text.isNotEmpty;

              setState(() {
                isNameFieldValid = isNameValid;
                isValueFieldValid = isValueValid;
              });

              if (isNameValid && isValueValid) {
                widget.id != null
                    ? context.read<WalletViewModel>().editCard(
                        CardEntity(
                          id: widget.id,
                          name: _nameController.text,
                          value: _valueController.text,
                          description: _descriptionController.text,
                        ).toDomain(),
                      )
                    : context.read<WalletViewModel>().addCard(
                        _nameController.text,
                        _valueController.text,
                        _descriptionController.text,
                      );
                FocusScope.of(context).unfocus();
                context.goNamed('wallet');
              } else {
                print('Invalid card');
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
