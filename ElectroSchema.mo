model ElectroSchema
  Modelica.Electrical.Analog.Basic.Resistor R_i annotation(
    Placement(visible = true, transformation(origin = {-160, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R_1 annotation(
    Placement(visible = true, transformation(origin = {-159, 13}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor Ind_1 annotation(
    Placement(visible = true, transformation(origin = {-52, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R_2_1 annotation(
    Placement(visible = true, transformation(origin = {-50, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor Cap annotation(
    Placement(visible = true, transformation(origin = {-3, 45}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent annotation(
    Placement(visible = true, transformation(origin = {-192, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-192, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(R_i.n, R_2_1.p) annotation(
    Line(points = {{-150, 84}, {-84, 84}, {-84, 64}, {-60, 64}}, color = {0, 0, 255}));
  connect(R_i.n, Ind_1.p) annotation(
    Line(points = {{-150, 84}, {-84, 84}, {-84, 92}, {-62, 92}}, color = {0, 0, 255}));
  connect(Ind_1.n, Cap.p) annotation(
    Line(points = {{-42, 92}, {-2, 92}, {-2, 58}}, color = {0, 0, 255}));
  connect(R_2_1.n, Cap.p) annotation(
    Line(points = {{-40, 64}, {-2, 64}, {-2, 58}}, color = {0, 0, 255}));
  connect(Cap.n, R_1.p) annotation(
    Line(points = {{-2, 32}, {-4, 32}, {-4, 14}, {-150, 14}}, color = {0, 0, 255}));
  connect(sineCurrent.n, R_i.p) annotation(
    Line(points = {{-192, 52}, {-170, 52}, {-170, 84}}, color = {0, 0, 255}));
  connect(R_1.n, sineCurrent.p) annotation(
    Line(points = {{-168, 14}, {-192, 14}, {-192, 32}}, color = {0, 0, 255}));
  connect(ground.p, sineCurrent.p) annotation(
    Line(points = {{-192, -4}, {-192, 32}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-220, 120}, {20, -20}})),
    version = "",
    uses(Modelica(version = "4.0.0")));
end ElectroSchema;
