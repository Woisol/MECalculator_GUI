// !提示命名必须是小写加_，而且必须有_………………
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatefulWidget {
  const TitleBar({super.key});
  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    // !注意上下两个super.initState的顺序不同……
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
        child: AppBar(
            // !就算返回AppBar也无法赋给scaffold的appBar属性……The argument type 'TitleBar' can't be assigned to the parameter type 'PreferredSizeWidget?'.
            title: const Text('ME Calculator'),
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 30,
            // flexibleSpace: DragToMoveArea(
            //     child: Expanded(child: Center(child: Text('abc')))),
            backgroundColor: Colors.grey[200],
            actions: <Widget>[
          // Material(borderRadius: const BorderRadius.all(Radius.zero),child:
          IconButton(
            // !解决了radius后还是用回IconButton，因为另外的OutlineButton即使设置了padding依然过长，IconButton的样式就挺合适
            iconSize: 20,
            icon: const Icon(Icons.remove),
            alignment: Alignment.center,
            splashRadius: 1,
            // !必须>0……
            tooltip: '最小化',

            // ~~尝试OutlinedButton，甚至无法使用style咳咳你下面用着了……
            // child: Icon(Icons.remove, size: 20,color: Colors.black,),

            // style: ButtonStyle(
            //   splashFactory: NoSplash.splashFactory,
            //   // shape: MaterialStateProperty.all(CircleBorder()),
            //   // shape: Rect.fromCenter(center: 0, width: 0, height: 0)
            // ),

            // style: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(0)
            // ),
            // color: WindowCaptionButton.close(),

            style: OutlinedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                padding: const EdgeInsets.all(5),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
            onPressed: () {
              windowManager.minimize();
            },
          ),
          // ),
          IconButton(
            iconSize: 20,
            icon: const Icon(Icons.square_outlined),
            alignment: Alignment.center,
            splashRadius: 1,
            // !必须>0……
            tooltip: '最大化',
            style: OutlinedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                padding: const EdgeInsets.all(5),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
            onPressed: () {
              windowManager.maximize();
            },
          ),
          IconButton(
            iconSize: 20,
            icon: const Icon(Icons.close),
            alignment: Alignment.center,
            hoverColor: Colors.red[400],
            splashRadius: 1,
            // !必须>0……
            tooltip: '关闭',
            style: OutlinedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                padding: const EdgeInsets.all(5),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
            onPressed: () {
              windowManager.close();
            },
          ),
        ]));
  }
}
