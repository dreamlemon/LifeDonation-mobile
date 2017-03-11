import 'package:flutter/material.dart';

import 'package:project_hack_forgood/resources/resources.dart';
import 'package:project_hack_forgood/ui/widgets.dart';

// MODELS
class SectionDetail {
  SectionDetail({ this.body });
  final Widget body;
}

class Section {
  const Section({ this.title, this.backgroundAsset, this.leftColor, this.rightColor, this.details });
  final String title;
  final String backgroundAsset;
  final Color leftColor;
  final Color rightColor;
  final List<SectionDetail> details;

  @override
  bool operator==(Object other) {
    if (other is! Section)
      return false;
    final Section otherSection = other;
    return title == otherSection.title;
  }

  @override
  int get hashCode => title.hashCode;
}

class ExpansionItemDetail {

  ExpansionItemDetail({ this.title, this.description });

  final String title;
  final String description;

  bool isExpanded = false;
}

// DATA
final SectionDetail _home = new SectionDetail(
      body: new Column(
          children: <Widget>[
        new DecoratedBox(
        decoration: new BoxDecoration(
            backgroundColor: Colors.white12,),
             child: new Row(
                children: <Widget>[
                  new Container(
                    child: new Text("PORCENTAJE DE DONACIONES REALIZADAS",
                      style: new TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.center
                    ),
                    margin: new EdgeInsets.all(20.0)
                  )
                ]
            )),
        new Divider(color: Colors.transparent, height: 5.0),
        new DecoratedBox(
            decoration: new BoxDecoration(
              backgroundColor: Colors.white12,),
            child: new Row(
              children: <Widget>[
                new BloodView(image: 'assets/abM.png', porcent: '60%'),
                new BloodView(image: 'assets/abN.png', porcent: '60%'),
                new BloodView(image: 'assets/aM.png', porcent: '60%'),
                new BloodView(image: 'assets/ON.png', porcent: '60%')
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround
            )),
        new DecoratedBox(
            decoration: new BoxDecoration(
              backgroundColor: Colors.white12,),
            child: new Row(
                children: <Widget>[
                  new BloodView(image: 'assets/aN.png', porcent: '60%'),
                  new BloodView(image: 'assets/bM.png', porcent: '60%'),
                  new BloodView(image: 'assets/bN.png', porcent: '60%'),
                  new BloodView(image: 'assets/OM.png', porcent: '60%')
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround
            ))
          ])
);

List<ExpansionItemDetail> itemsData = [
  new ExpansionItemDetail(title: "¿Por qué debemos donar sangre?",
      description: "Hay tres motivos muy importantes para  donar: La sangre no se puede fabricar.  Sólo se puede obtener de donantes como usted. La sangre es imprescindible para operaciones y urgencias. La sangre caduca, y no se puede almacenar por un tiempo indefinido."),
  new ExpansionItemDetail(title: "¿Cómo me debo preparar para donar sangre?",
      description: "Duerma bien la noche anterior a la donación, acuda tras haber ingerido una comida pobre en  grasas, – nunca en ayunas-  y evite fumar desde al menos una hora antes de la donación.Si tienen tendencia a tener niveles bajos de hierro, puede prepararse tomando alimentos ricos, como carnes rojas, hígado, pescado y huevos. También las legumbres y frutos secos son ricos en este nutriente."),
  new ExpansionItemDetail(title: "¿En qué consiste el proceso de donación?",
      description: "El proceso donación tiene varias fases: Lectura de información sobre la donación y aspectos legales de la misma. Cumplimentación del formulario de entrevista médica y autorización para la donación. (Consentimiento informado).Examen médico y entrevista. Prueba para la detección de anemia. Donación propiamente dicha. Recuperación y refrigerio. Las preguntas que le realizará el médico o enfermera  que realiza la entrevista, así como la exploración física a la que se verá sometido (Tensión arterial, pulso, hemoglobina) tienen como objetivo descartar algún problema por el que la donación que va a realizar pueda ser perjudicial para usted mismo o para las personas que vayan a recibir los productos obtenidos de su donación. En el caso de que se detecte alguno de estos problemas, el médico la enfermera, puede no autorizarle en este momento a realizar la donación."),
  new ExpansionItemDetail(title: "¿Requisitos para donar sangre",
      description: "Gozar de buen estado de salud. Tener entre 18 y 65 años de edad. Teniendo en cuenta que desde los 16 años se puede donar sangre con la autorización de los padres o tutores, y que la edad limite superior está dada por el estado físico individual, por lo que si Ud es mayor de 65 años y tiene deseos de ser donante, puede concurrir a su médico de cabecera y solicitarle un certificado de autorización para realizar una donación de sangre. Pesar más de 50 kilos. Tener valores de presión arterial dentro de los límites que se consideran adecuados. No presentar fiebre o haber padecido alguna enfermedad en los últimos 7 días. Es recomendable haber descansado por lo menos 6 horas la noche anterior a la donación. Es conveniente tomar el desayuno habitual , el almuerzo o la cena completos dependiendo de la hora en que done sangre.")
];

final SectionDetail info = new SectionDetail(
    body: new ExpansionPanelView(items: itemsData)
);

String tipoSangre = "O-";

final SectionDetail _profile = new SectionDetail(
  body:new Column(
      children: <Widget>[new DecoratedBox(
            decoration: new BoxDecoration(
                backgroundColor: Colors.white12,),
                child: new Container(
                    child:new Row(
                      children: <Widget>[
                        new Text('Puntos por donación: ',
                            style: new TextStyle(color: Colors.white, fontSize: 16.0)
                        ),
                        new Image.asset(
                            'assets/pointIcon.png',
                            width: 30.0
                        ),

                        new Image.asset(
                            'assets/pointIcon.png',
                            width: 30.0
                        ),
                        new Image.asset(
                            'assets/pointIcon.png',
                            width: 30.0
                        ),
                        new Image.asset(
                            'assets/pointIcon.png',
                            width: 30.0
                        ),
                        new Image.asset(
                            'assets/pointIcon.png',
                            width: 30.0
                        ),

                      ]
                    ),
                  margin: new EdgeInsets.all(20.0)
                ),
            ),
      new Divider(color: Colors.transparent, height: 5.0),
      new DecoratedBox(
          decoration: new BoxDecoration(
              backgroundColor: Colors.white12,),
          child: new Container(
              child:new Row(
                  children: <Widget>[
                    new Text('Eres '+tipoSangre+ '. '+typeOfBlood(tipoSangre),
                        style: new TextStyle(color: Colors.white, fontSize: 16.0)
                    ),

                  ]
              ),
              margin: new EdgeInsets.all(20.0)
          ),
      ),
      ]
  )
);

String typeOfBlood(String tipoSangre) {
  String texto = "";
  switch (tipoSangre){
    case ("AB+"):
      texto = "Puedes donar a AB+ y eres \nreceptor universal. Tu grupo abarca \nel 3% de la población.";
      break;
    case ("AB-"):
      texto = "Puedes donar a AB± eres \nreceptor de A-, B-, AB- y O-. Tu grupo \nabarca el 1% de la población.";
      break;
    case ("A+"):
      texto = "Puedes donar a A+ y AB+ y \neres receptor de A± y O±. Tu grupo \nabarca el 37% de la población.";
      break;
    case ("A-"):
      texto = "Puedes donar a A± y AB± y \neres receptor de A- y O-. Tu grupo \nabarca el 7% de la población.";
      break;
    case ("B+"):
      texto = "Puedes donar a B+ y AB+ y \neres receptor de B± y O±. Tu grupo \nabarca el 9% de la población.";
      break;
    case ("B-"):
      texto = "Puedes donar a B± y AB± y \neres receptor de B- y O-. Tu grupo \nabarca el 1% de la población.";
      break;
    case ("O+"):
      texto = "Puedes donar a A+, B+, AB+ \ny O+ y eres receptor de O±. Tu grupo \nabarca el 36% de la población.";
      break;
    case ("O-"):
      texto = "Felicidades, eres donante \nuniversal y receptor de O-. Tu grupo \nabarca el 6% de la población.";
      break;
  }
  return texto;

}


final List<Section> allSections = <Section>[
  new Section(
    title: 'HOME',
      leftColor: CColors.mediumPurple,
      rightColor: CColors.mariner,
    backgroundAsset: 'assets/homeImage.jpeg',
    details: <SectionDetail>[
      _home
    ]
  ),
  new Section(
    title: 'ACERCA DE',
      leftColor: CColors.tomato,
      rightColor: CColors.mediumPurple,
    backgroundAsset: 'assets/infoImage.jpeg',
    details: <SectionDetail>[
      info
    ]
  ),
  new Section(
    title: 'ALERTAS',
      leftColor: CColors.mySin,
      rightColor: CColors.tomato,
    backgroundAsset: 'assets/donateImage.jpeg',
    details: <SectionDetail>[

    ]
  ),
  new Section(
    title: 'PERFIL',
    leftColor: Colors.white,
    rightColor: CColors.tomato,
    backgroundAsset: 'assets/profileImage.jpeg',
    details: <SectionDetail>[
      _profile

    ]
  ),
];
