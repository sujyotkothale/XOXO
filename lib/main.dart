import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 179, 141, 245)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tik Tak Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
int Player1Score=0;
int Player2Score=0;
Icon Player1Icon = Icon(Icons.close,color: Colors.red,size: 30);
Icon Player2Icon = Icon(Icons.circle_outlined,color: Colors.green,size: 50);
 List<List<dynamic>> gamematrix = List.generate(3, (i) => List.generate(3, (j) => null));
 List<List<dynamic>> gamematrixint = List.generate(3, (i) => List.generate(3, (j) => null));

 
 @override
  void initState() {
   
    super.initState();
  }
   int player = 1;
   @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }
  int _counter = 0;
 

  
  Future<void> updateScreen(int x,int j)async {
    if(gamematrix[x][j] == null){
      if(player == 1){
        gamematrix[x][j] = Icon(Icons.close,color: Colors.red,size: 74,);
        gamematrixint[x][j] = player;
        Checkwin(x, j, player);
      }
      if(player == 2){
        gamematrix[x][j] = Icon(Icons.circle_outlined,color: Colors.green,size: 74,);
        gamematrixint[x][j] = player;
        Checkwin(x, j, player);
      }
      if (player == 1) {
        player = 2;
        Player1Icon = Icon(Icons.close,color: Colors.red,size: 30);
        Player2Icon = Icon(Icons.circle_outlined,color: Colors.green,size: 50);
      }
      else if (player == 2) {
        player = 1;
        Player1Icon = Icon(Icons.close,color: Colors.red,size: 50);
        Player2Icon = Icon(Icons.circle_outlined,color: Colors.green,size: 30);
      }
  
      setState(() { });
    }
  }
  void Checkwin(int x,int j,int player){
    var current = gamematrixint[x][j];
    bool won = false;
    if(gamematrixint[x][j] == gamematrixint[x][(j+4)%3] && gamematrixint[x][j] == gamematrixint[x][(j+5)%3]){
      won = true;
      print("cond 1");
      print(gamematrixint);
    }
     if(gamematrixint[x][j] == gamematrixint[(x+4)%3][j] && gamematrixint[x][j] == gamematrixint[(x+5)%3][j]){
      won = true;
      print("cond 2");
      print(gamematrixint);
    }
    if(gamematrixint[1][1] == current && gamematrixint[2][2] == current && gamematrixint[0][0] == current){
      won = true;
    }
    if(gamematrixint[1][1] == current && gamematrixint[2][0] == current && gamematrixint[0][2] == current){
      won = true;
    }

    if(won){
      if(player == 1){
        Player1Score +=1; 
      }if(player == 2){
        Player2Score += 1;
      }
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text("Congratulations"),
        content: Row(children: [gamematrix[x][j],Text(" Won")],),
        actions: [TextButton(onPressed: (){
          for(int m=0;m<3;m++){
            for(int n=0;n<3;n++){
              gamematrix[m][n] = null;
              gamematrixint[m][n] = null;
            }
          }
          setState(() { });
           SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
    });
        }, child: Text("Back"))],);
      },
    );
    }
    else{
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              Player1Icon
              ,
              Text(Player1Score.toString(),style: TextStyle(fontSize: 25)),
              SizedBox(width: 30,),
              Player2Icon,
              Text(Player2Score.toString(),style: TextStyle(fontSize: 25),)
            ],crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,),
            SizedBox(height: 50,),
            Row(children: [
             SizedBox(height: 130,width: queryData.size.width/3,child: ElevatedButton(onPressed: (){
              updateScreen(0, 0);
             },style:  ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(230, 245, 244,1)), child: gamematrix[0][0])),
             SizedBox(height: 130,width: queryData.size.width/3,child: ElevatedButton(onPressed: (){updateScreen(0, 1);},style:  ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(230, 245, 244,1)), child: gamematrix[0][1])),
              SizedBox(height: 130,width: queryData.size.width/3,child: ElevatedButton(onPressed: (){updateScreen(0, 2);},style:  ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(230, 245, 244,1)), child: gamematrix[0][2])),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,),

             Row(children: [
             SizedBox(height: 130,width: queryData.size.width/3,child: ElevatedButton(onPressed: (){updateScreen(1, 0);},style:  ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(230, 245, 244,1)), child: gamematrix[1][0])),
             SizedBox(height: 130,width: queryData.size.width/3,child: ElevatedButton(onPressed: (){updateScreen(1, 1);},style:  ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(230, 245, 244,1)), child: gamematrix[1][1])),
              SizedBox(height: 130,width: queryData.size.width/3,child: ElevatedButton(onPressed: (){updateScreen(1, 2);},style:  ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(230, 245, 244,1)), child: gamematrix[1][2])),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,),

             Row(children: [
             SizedBox(height: 130,width: queryData.size.width/3,child: ElevatedButton(onPressed: (){updateScreen(2, 0);},style:  ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(230, 245, 244,1)), child: gamematrix[2][0])),
             SizedBox(height: 130,width: queryData.size.width/3,child: ElevatedButton(onPressed: (){updateScreen(2, 1);},style:  ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(230, 245, 244,1)), child:gamematrix[2][1])),
              SizedBox(height: 130,width: queryData.size.width/3,child: ElevatedButton(onPressed: (){updateScreen(2, 2);},style:  ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(230, 245, 244,1)), child: gamematrix[2][2])),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,),
          ],
        ),
      ),
      
      floatingActionButton:Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           FloatingActionButton(
             backgroundColor: Color.fromRGBO(105, 217, 255, 1),
        onPressed:(){
           Player1Score = 0;
           Player2Score = 0;
          setState(() { });
        },
        tooltip: 'Reset Score',
        child: const Icon(Icons.replay_circle_filled),
      ),
      SizedBox(width: 20,),
       FloatingActionButton(
        backgroundColor: Color.fromRGBO(86, 177, 207, 1),
        onPressed:(){
           for(int m=0;m<3;m++){
            for(int n=0;n<3;n++){
              gamematrix[m][n] = null;
              gamematrixint[m][n] = null;
            }
          }
          setState(() { });
        },
        tooltip: 'Reset Board',
        child: Icon(Icons.replay_circle_filled,)
      ),
        ],
      )
    );
  }
}
