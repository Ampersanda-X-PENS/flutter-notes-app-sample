import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/components/list.dart';
import 'package:todolist/screens/add.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDo> todos = [
    ToDo('Sample Title', 'Lorem ipsaum dolor sit amet anisdipicing elit.')
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            padding: EdgeInsetsDirectional.only(end: 0.0),
            largeTitle: Text('Notes'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                ToDo todo = await Navigator.push(
                    context, CupertinoPageRoute(builder: (_) => AddScreen()));

                if (todo != null) todos.add(todo);
              },
              child: Icon(CupertinoIcons.add),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(todos
                .asMap()
                .map((int index, ToDo todo) => MapEntry(
                    index,
                    Column(children: <Widget>[
                      Material(
                          type: MaterialType.transparency,
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 0),
                              title: Text(todo.title),
                              subtitle: Text(
                                todo.description,
                                maxLines: 1,
                              ),
                              trailing: Icon(CupertinoIcons.right_chevron),
                              onLongPress: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (_) {
                                      return CupertinoActionSheet(
                                        actions: <Widget>[
                                          CupertinoActionSheetAction(
                                            child: Text('Edit'),
                                            onPressed: () async {
                                              Navigator.pop(context);

                                              ToDo newTodo =
                                                  await Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (_) =>
                                                              AddScreen(
                                                                  toDo: todo)));

                                              if (newTodo != null)
                                                todos[index] = newTodo;
                                            },
                                          ),
                                          CupertinoActionSheetAction(
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: CupertinoColors
                                                      .destructiveRed),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              todos.removeAt(index);
                                            },
                                          )
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          child: Text('Cancel'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      );
                                    });
                              },
                              onTap: () async {
                                ToDo newTodo = await Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => AddScreen(toDo: todo)));

                                if (newTodo != null) todos[index] = newTodo;
                              })),
                      Container(
                          height: 1.0,
                          width: double.infinity,
                          color: CupertinoColors.lightBackgroundGray)
                    ])))
                .values
                .toList()),
          )
        ],
      ),
    );
  }
}
