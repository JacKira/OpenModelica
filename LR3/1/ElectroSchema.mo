model ElectroSchema
  New_Designed_Resistor RRR (R = 777) annotation(
        Placement(visible = true, transformation(origin = {-152, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R_1(R = 0.01)  annotation(
    Placement(visible = true, transformation(origin = {-159, 13}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R_2_1(R = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {-50, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor Cap(C = 1)  annotation(
    Placement(visible = true, transformation(origin = {-3, 45}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent(I = 3)  annotation(
    Placement(visible = true, transformation(origin = {-192, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-34, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor Cap_b(C = 10)  annotation(
    Placement(visible = true, transformation(origin = {-50, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Cap.n, R_1.p) annotation(
    Line(points = {{-2, 32}, {-4, 32}, {-4, 14}, {-150, 14}}, color = {0, 0, 255}));
  connect(R_1.n, sineCurrent.p) annotation(
    Line(points = {{-168, 14}, {-192, 14}, {-192, 32}}, color = {0, 0, 255}));
  connect(ground.p, sineCurrent.p) annotation(
    Line(points = {{-34, 4}, {-34, 14}, {-192, 14}, {-192, 32}}, color = {0, 0, 255}));
  connect(Cap_b.n, Cap.p) annotation(
    Line(points = {{-40, 94}, {-2, 94}, {-2, 58}}, color = {0, 0, 255}));
  connect(R_2_1.n, Cap.p) annotation(
    Line(points = {{-40, 64}, {-2, 64}, {-2, 58}}, color = {0, 0, 255}));
  connect(sineCurrent.n, RRR.p) annotation(
    Line(points = {{-192, 52}, {-162, 52}, {-162, 92}}, color = {0, 0, 255}));
  connect(RRR.n, Cap_b.p) annotation(
    Line(points = {{-142, 92}, {-60, 92}, {-60, 94}}, color = {0, 0, 255}));
  connect(RRR.n, R_2_1.p) annotation(
    Line(points = {{-142, 92}, {-60, 92}, {-60, 64}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-220, 120}, {20, -20}})),
    version = "",
    uses(Modelica(version = "4.0.0")),
  experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.0002));
end ElectroSchema;
