import 'package:flutter/material.dart';
import 'package:mplex/Data/test.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Model/algorithme.dart';

void main() {
  runApp(MPlex());
}

class MPlex extends StatelessWidget {
  MPlex({Key? key}) : super(key: key);
  final Algorithme algorithme = Algorithme();
  @override
  Widget build(BuildContext context) {
    algorithme.resolution(tableau: problemeTest.toTableau()!);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Algorithme de Simplex"),
        ),
      ),
    );
  }
}



























// class ChoixVariable extends StatefulWidget {
//   const ChoixVariable({Key? key}) : super(key: key);

//   @override
//   _ChoixVariableState createState() => _ChoixVariableState();
// }

// class _ChoixVariableState extends State<ChoixVariable> {
//   TextEditingController variblesDecisions = TextEditingController();
//   TextEditingController nombresContraintes = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: Container(
//           height: 60,
//           color: Colors.purple,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: TextButton(
//                     onPressed: () {
//                       if (variblesDecisions.text.isNotEmpty &&
//                           nombresContraintes.text.isNotEmpty) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Complet(
//                                     contraintes:
//                                         int.parse(nombresContraintes.text),
//                                     decisions: int.parse(
//                                       variblesDecisions.text,
//                                     ))));
//                       }
//                     },
//                     child: const Text("Suivant",
//                         style: TextStyle(color: Colors.white))),
//               )
//             ],
//           ),
//         ),
//         body: Center(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 100,
//                 child: TextField(
//                   controller: nombresContraintes,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(label: Text("Contraintes")),
//                 ),
//               ),
//               const SizedBox(
//                 width: 100,
//               ),
//               SizedBox(
//                 width: 100,
//                 child: TextField(
//                   controller: variblesDecisions,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(label: Text("Décision")),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class Complet extends StatefulWidget {
//   final int decisions;
//   final int contraintes;
//   const Complet({Key? key, required this.contraintes, required this.decisions})
//       : super(key: key);

//   @override
//   _CompletState createState() => _CompletState();
// }

// class _CompletState extends State<Complet> {
//   List<TextEditingController> controllerVDecisions = [];
//   List<List<TextEditingController>> controllerContrainte = [];

//   completeController({int? vDecisions, int? contraintes}) {
//     for (int i = 0; i < vDecisions!; i++) {
//       controllerVDecisions.add(TextEditingController());
//     }

//     for (int i = 0; i < contraintes!; i++) {
//       List<TextEditingController> _v = [];
//       for (int i = 0; i < vDecisions + 1; i++) {
//         _v.add(TextEditingController());
//       }
//       controllerContrainte.add(_v);
//     }
//   }

//   @override
//   void initState() {
//     completeController(
//         vDecisions: widget.decisions, contraintes: widget.contraintes);
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: Container(
//           height: 60,
//           color: Colors.purple,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   children: [
//                     TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Retour",
//                             style: TextStyle(color: Colors.white))),
//                   ],
//                 ),
//               )),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: TextButton(
//                     onPressed: () {
//                       // if (variblesDecisions.text.isNotEmpty &&
//                       //     nombresContraintes.text.isNotEmpty) {

//                       List<Contrainte> contraintes = [];
//                       Z z = Z(
//                           vDecisions: controllerVDecisions
//                               .map((e) => int.parse(e.text))
//                               .toList());
//                       for (List<TextEditingController> cContrainte
//                           in controllerContrainte) {
//                         contraintes.add(Contrainte(
//                             inegalite: Inegalite.INFERIEUR,
//                             vDecisions: cContrainte
//                                 .map((e) => int.parse(e.text))
//                                 .toList(),
//                             value: int.parse(cContrainte.last.text)));
//                       }

//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   Resolvation(z: z, contraintes: contraintes)));
//                     },
//                     child: const Text("Suivant",
//                         style: TextStyle(color: Colors.white))),
//               )
//             ],
//           ),
//         ),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(40.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: 200,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Donnez les variables de décisions"),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       ...List.generate(
//                           widget.decisions,
//                           (index) => TextField(
//                                 controller: controllerVDecisions[index],
//                                 decoration: InputDecoration(
//                                     suffixIcon:
//                                         Text("X" + (1 + index).toString())),
//                               )).toList()
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 30,
//                 ),
//                 SizedBox(
//                   width: 300,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Donnez les contraintes"),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       ...List.generate(
//                           widget.contraintes,
//                           (index1) => Row(
//                                 children: List.generate(
//                                     widget.decisions + 1,
//                                     (index) => Expanded(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: TextField(
//                                               controller:
//                                                   controllerContrainte[index1]
//                                                       [index],
//                                               decoration: InputDecoration(
//                                                   suffixIcon: Text("X" +
//                                                       (1 + index).toString())),
//                                             ),
//                                           ),
//                                         )).toList(),
//                               )).toList()
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

// class Resolvation extends StatefulWidget {
//   final Z z;
//   final List<Contrainte> contraintes;
//   const Resolvation({Key? key, required this.z, required this.contraintes})
//       : super(key: key);

//   @override
//   _ResolvationState createState() => _ResolvationState();
// }

// class _ResolvationState extends State<Resolvation> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//         height: 60,
//         color: Colors.purple,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Expanded(
//                 child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text("Retour",
//                           style: TextStyle(color: Colors.white))),
//                 ],
//               ),
//             )),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [Text("Max Z=" + widget.z.toString())],
//       ),
//     );
//   }
// }
