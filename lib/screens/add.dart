import 'package:flutter/cupertino.dart';
import 'package:todolist/components/list.dart';

class AddScreen extends StatefulWidget {
  final ToDo toDo;

  const AddScreen({Key key, this.toDo}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  FocusNode _titleFocusNode = FocusNode();
  TextEditingController _titleController;

  FocusNode _descriptionFocusNode = FocusNode();
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    if (widget.toDo != null) {
      _titleController = TextEditingController(text: widget.toDo.title);
      _descriptionController =
          TextEditingController(text: widget.toDo.description);
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              CupertinoTextField(
                focusNode: _titleFocusNode,
                placeholder: 'Title',
                maxLines: 1,
                autofocus: true,
                controller: _titleController,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
              ),
              SizedBox(
                height: 8.0,
              ),
              CupertinoTextField(
                focusNode: _descriptionFocusNode,
                placeholder: 'Description',
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                controller: _descriptionController,
              ),
            ],
          ),
        ),
      ),
      navigationBar: CupertinoNavigationBar(
        middle: Text('New Note'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('SAVE'),
          onPressed: () {
            Navigator.pop(
                context,
                ToDo(_titleController.value.text,
                    _descriptionController.value.text));
          },
        ),
      ),
    );
  }
}
