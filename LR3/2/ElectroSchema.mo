model ElectroSchema
  New_Designed_Resistor RRR(R = 20) annotation(
    Placement(visible = true, transformation(origin = {-152, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R_1(R = 10) annotation(
    Placement(visible = true, transformation(origin = {-159, 13}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R_2_1(R = 15) annotation(
    Placement(visible = true, transformation(origin = {-18, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor Cap(C = 10) annotation(
    Placement(visible = true, transformation(origin = {-3, 45}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent(I = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-192, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-34, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor Cap_b(C = 10) annotation(
    Placement(visible = true, transformation(origin = {-50, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor L(L = 50)  annotation(
    Placement(visible = true, transformation(origin = {-54, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R2_2(R = 9)  annotation(
    Placement(visible = true, transformation(origin = {-18, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Cap.n, R_1.p) annotation(
    Line(points = {{-2, 32}, {-4, 32}, {-4, 14}, {-150, 14}}, color = {0, 0, 255}));
  connect(R_1.n, sineCurrent.p) annotation(
    Line(points = {{-168, 14}, {-192, 14}, {-192, 32}}, color = {0, 0, 255}));
  connect(ground.p, sineCurrent.p) annotation(
    Line(points = {{-34, 4}, {-34, 14}, {-192, 14}, {-192, 32}}, color = {0, 0, 255}));
  connect(R_2_1.n, Cap.p) annotation(
    Line(points = {{-8, 62}, {-7, 62}, {-7, 58}, {-2, 58}}, color = {0, 0, 255}));
  connect(sineCurrent.n, RRR.p) annotation(
    Line(points = {{-192, 52}, {-162, 52}, {-162, 92}}, color = {0, 0, 255}));
  connect(RRR.n, Cap_b.p) annotation(
    Line(points = {{-142, 92}, {-60, 92}, {-60, 94}}, color = {0, 0, 255}));
  connect(RRR.n, L.p) annotation(
    Line(points = {{-142, 92}, {-64, 92}, {-64, 60}}, color = {0, 0, 255}));
  connect(L.n, R_2_1.p) annotation(
    Line(points = {{-44, 60}, {-28, 60}, {-28, 62}}, color = {0, 0, 255}));
  connect(Cap_b.n, R2_2.p) annotation(
    Line(points = {{-40, 94}, {-28, 94}, {-28, 92}}, color = {0, 0, 255}));
  connect(R2_2.n, Cap.p) annotation(
    Line(points = {{-8, 92}, {-2, 92}, {-2, 58}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-220, 120}, {20, -20}})),
    version = "",
    uses(Modelica(version = "4.0.0")),
    experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.0002));
end ElectroSchema;
