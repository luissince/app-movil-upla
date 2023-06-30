import 'package:upla/model/encuesta_pregunta_detalle.dart';

class EncuestaPregunta {
  String est_id;
  List<EncuestaPreguntaDetalle> detalle;

  EncuestaPregunta(
    this.est_id,
    this.detalle,
  );

  Map<String, dynamic> toJson() => {
        'est_id': est_id,
        'detalle': detalle.map((e) => e.toJson()).toList(),
      };
}
