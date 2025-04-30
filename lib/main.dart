import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const AnimationOverview(), // Puedes cambiar esto al widget que quieras mostrar primero
    );
  }
}

class AnimationOverview extends StatelessWidget {
  const AnimationOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jan Sosa 1317'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            Text('AnimatedList:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 200, child: Widget012()),
            Divider(),
            Text('AnimatedModalBarrier:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 200, child: Widget013()),
            Divider(),
            Text('AnimatedOpacity:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 150, child: Widget014()),
            Divider(),
            Text('AnimatedPadding:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 250, child: Widget015()),
            Divider(),
            Text('AnimatedPhysicalModel:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 200, child: Widget016()),
            Divider(),
            Text('AnimatedPositioned:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 400, child: Widget017()),
            Divider(),
            Text('AnimatedSize:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 200, child: Widget019()),
            Divider(),
            Text('AnimatedSwitcher:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 150, child: Widget020()),
            Divider(),
            Text('AnimatedWidget:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 250, child: MyStatefulWidget()),
          ],
        ),
      ),
    );
  }
}

//! AnimatedList

class Widget012 extends StatefulWidget {
  const Widget012({Key? key}) : super(key: key);

  @override
  Widget012State createState() => Widget012State();
}

class Widget012State extends State<Widget012> {
  final _items = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void _addItem() {
    _items.insert(0, "Item ${_items.length + 1}");
    _key.currentState!.insertItem(
      0,
      duration: const Duration(seconds: 1),
    );
  }

  void _removeItem(int index) {
    _key.currentState!.removeItem(
      index,
      (_, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const Card(
            margin: EdgeInsets.all(10),
            color: Colors.red,
            child: ListTile(
              title: Text(
                "Deleted",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );
    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        IconButton(
          onPressed: _addItem,
          icon: const Icon(Icons.add),
        ),
        Expanded(
          child: AnimatedList(
            key: _key,
            initialItemCount: 0,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index, animation) {
              return SizeTransition(
                key: UniqueKey(),
                sizeFactor: animation,
                child: Card(
                  margin: const EdgeInsets.all(10),
                  color: Colors.orangeAccent,
                  child: ListTile(
                    title: Text(
                      _items[index],
                      style: const TextStyle(fontSize: 24),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _removeItem(index);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

//! AnimatedModalBarrier

class Widget013 extends StatefulWidget {
  const Widget013({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Widget013State();
}

class _Widget013State extends State<Widget013>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late Widget _animatedModalBarrier;

  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    ColorTween _colorTween = ColorTween(
      begin: Colors.orangeAccent.withOpacity(0.5),
      end: Colors.blueGrey.withOpacity(0.5),
    );

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _colorAnimation = _colorTween.animate(_animationController);

    _animatedModalBarrier = AnimatedModalBarrier(
      color: _colorAnimation,
      dismissible: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100.0,
              width: 250.0,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    child: const Text('Press'),
                    onPressed: () {
                      setState(() {
                        _isPressed = true;
                      });
                      _animationController.reset();
                      _animationController.forward();
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          _isPressed = false;
                        });
                      });
                    },
                  ),
                  if (_isPressed) _animatedModalBarrier,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//! AnimatedOpacity

class Widget014 extends StatefulWidget {
  const Widget014({Key? key}) : super(key: key);

  @override
  State<Widget014> createState() => Widget014State();
}

class Widget014State extends State<Widget014> {
  double opacityLevel = 1.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: opacityLevel,
            duration: const Duration(seconds: 2),
            child: const FlutterLogo(
              size: 50,
            ),
          ),
          ElevatedButton(
            child: const Text('Fade Logo'),
            onPressed: () {
              setState(
                () => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0,
              );
            },
          ),
        ],
      ),
    );
  }
}

//!AnimatedPadding

class Widget015 extends StatefulWidget {
  const Widget015({Key? key}) : super(key: key);

  @override
  State<Widget015> createState() => _Widget015State();
}

class _Widget015State extends State<Widget015> {
  double padValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
          ),
          child: const Text('Change padding'),
          onPressed: () {
            setState(() {
              padValue = padValue == 0.0 ? 100.0 : 0.0;
            });
          },
        ),
        Text('Padding = $padValue'),
        AnimatedPadding(
          padding: EdgeInsets.all(padValue),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            color: Colors.orangeAccent,
          ),
        ),
      ],
    );
  }
}

//! AnimatedPhysicalModel

class Widget016 extends StatefulWidget {
  const Widget016({Key? key}) : super(key: key);

  @override
  Widget016State createState() => Widget016State();
}

class Widget016State extends State<Widget016> {
  bool _isFlat = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedPhysicalModel(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            elevation: _isFlat ? 0 : 6.0,
            shape: BoxShape.rectangle,
            shadowColor: Colors.black,
            color: Colors.white,
            child: const SizedBox(
              height: 120.0,
              width: 120.0,
              child: Icon(Icons.android_outlined),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Text('Click'),
            onPressed: () {
              setState(() {
                _isFlat = !_isFlat;
              });
            },
          ),
        ],
      ),
    );
  }
}

//!AnimatedPositioned

class Widget017 extends StatefulWidget {
  const Widget017({Key? key}) : super(key: key);

  @override
  State<Widget017> createState() => _Widget017State();
}

class _Widget017State extends State<Widget017> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 350,
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            width: selected ? 200.0 : 50.0,
            height: selected ? 50.0 : 200.0,
            top: selected ? 50.0 : 150.0,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//! AnimatedSize

class Widget019 extends StatefulWidget {
  const Widget019({Key? key}) : super(key: key);

  @override
  State<Widget019> createState() => _Widget019State();
}

class _Widget019State extends State<Widget019> {
  double _size = 300;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _size = _size == 300 ? 100 : 300;
        });
      },
      child: Container(
        color: Colors.white,
        child: AnimatedSize(
          curve: Curves.easeIn,
          duration: const Duration(seconds: 1),
          child: FlutterLogo(size: _size),
        ),
      ),
    );
  }
}

//! AnimatedSwitcher

class Widget020 extends StatefulWidget {
  const Widget020({Key? key}) : super(key: key);

  @override
  State<Widget020> createState() => _Widget020State();
}

class _Widget020State extends State<Widget020> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Text(
              '$_count',
              style: const TextStyle(fontSize: 40),
              key: ValueKey(_count),
            ),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
          ),
          ElevatedButton(
            child: const Text('Add'),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

//! AnimatedWidget

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TheWidget(controller: _controller);
  }
}

class TheWidget extends AnimatedWidget {
  const TheWidget({
    Key? key,
    required AnimationController controller,
  }) : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _progress.value * 2.0 * math.pi,
      child: Container(width: 200.0, height: 200.0, color: Colors.green),
    );
  }
}
