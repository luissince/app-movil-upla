class Deuda {
  int key;
  String descripcion;
  String fecVenc;
  String tm;
  double importe;
  double mora;
  double subtotal;
  String obs;

  Deuda(
    this.key,
    this.descripcion,
    this.fecVenc,
    this.tm,
    this.importe,
    this.mora,
    this.subtotal,
    this.obs,
  );

  factory Deuda.fromJson(Map<String, dynamic> json) {
    return Deuda(
      0,
      json["descripcion"],
      json["fecVenc"],
      json["tm"],
      json["importe"],
      json["mora"],
      json["subtotal"],
      json["obs"],
    );
  }
}
