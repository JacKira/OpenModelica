package Andreev_labs_2022
  model laba1
    // переменные
    Real x1[10];
    Real x2[10];
    // параметры
    parameter Real a = 1;
    parameter Real b = 1;
    parameter Real c = 1;
    parameter Real d = 1;
    parameter Integer n = 10;
  initial equation
    for i in 1:n loop
      x1[i] = i / 2;
      x2[i] = x1[i] / 2;
    end for;
  equation
    for i in 1:n loop
      der(x1[i]) = x1[i] * (a - b * x2[i]);
      der(x2[i]) = -x2[i] * (c - d * x1[i]);
    end for;
    annotation(
      experiment(StartTime = 0, StopTime = 15, Tolerance = 1e-06, Interval = 0.00015));
  end laba1;

  model laba2_1
    Real x(start = -1);
    Real v(start = -1);
    Real F;
    Real flag(start = 1.5);
    parameter Real k2 = 1;
    parameter Real k3 = 2;
    parameter Real k4 = 3;
    parameter Real a = 1;
    parameter Real b = 0.5;
    parameter Real K = 5;
  equation
    der(x) = v;
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    if flag < 2 then
      if x < (-b * a) then
        F = -K;
      else
        F = 0;
        flag = 2.5;
      end if;
    elseif flag < 3 then
      if x < (-a) then
        F = -K;
        flag = 1.5;
      elseif x < a then
        F = 0;
      else
        F = K;
        flag = 3.5;
      end if;
    else
      if x > b * a then
        F = K;
      else
        F = 0;
        flag = 2.5;
      end if;
    end if;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
  end laba2_1;

  model laba2_2
    Real x(start = -1);
    Real v(start = -1);
    Real F;
    Real flag(start = 1.5);
    parameter Real k2 = 1;
    parameter Real k3 = 2;
    parameter Real k4 = 3;
    parameter Real a = 1;
    parameter Real b = 0.5;
    parameter Real K = 5;
  equation
    der(x) = v;
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    if flag < 2 then
      if x < b then
        F = -K;
      elseif x > a then
        F = K;
        flag = 2.5;
      else
        F = 2 * K * (x - b) / (a - b) - K;
        flag = 2.5;
      end if;
    else
      if x > (-b) then
        F = K;
      elseif x < (-a) then
        F = -K;
        flag = 1.5;
      else
        F = 2 * K * (x + a) / ((-b) + a) - K;
        flag = 1.5;
      end if;
    end if;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
  end laba2_2;

  model laba2_3
    Real x(start = -4);
    Real v(start = -4);
    Real F;
    parameter Real k2 = 1;
    parameter Real k3 = 2;
    parameter Real k4 = 3;
    parameter Real a = 1;
    parameter Real d = 2;
    parameter Real K = 5;
    parameter Real b = 3;
  equation
    der(x) = v;
    der(v) = (-F) - k2 * x + k3 * sin(k4 * time);
    if x < (-d) then
      F = -K;
    elseif x < (-a) then
      F = ((-b) + K) * (x + d) / ((-a) + d) - K;
    elseif x < a then
      F = 0;
    elseif x < d then
      F = (b - K) * (x - d) / (a - d) + K;
    else
      F = K;
    end if;
    annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02));
  end laba2_3;

  model lr3_1
    Modelica.Electrical.Analog.Basic.Resistor R1(R = 2000) annotation(
      Placement(visible = true, transformation(origin = {20, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor R2(R = 3000) annotation(
      Placement(visible = true, transformation(origin = {-20, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Capacitor C2(C = 0.0000001) annotation(
      Placement(visible = true, transformation(origin = {70, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Basic.Capacitor C1(C = 0.0000001) annotation(
      Placement(visible = true, transformation(origin = {20, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SineVoltage E(V = 220, f = 50) annotation(
      Placement(visible = true, transformation(origin = {-70, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {40, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Andreev_labs_2022.My_resistor My_resistor(R = 888, alpha = 100000) annotation(
      Placement(visible = true, transformation(origin = {-36, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(C1.n, C2.n) annotation(
      Line(points = {{30, 52}, {50, 52}, {50, 32}, {70, 32}, {70, 12}}, color = {0, 0, 255}));
    connect(R1.n, C2.n) annotation(
      Line(points = {{30, 12}, {50, 12}, {50, 32}, {70, 32}, {70, 12}}, color = {0, 0, 255}));
    connect(C2.p, R2.n) annotation(
      Line(points = {{70, -8}, {70, -28}, {-10, -28}}, color = {0, 0, 255}));
    connect(R2.p, E.n) annotation(
      Line(points = {{-30, -28}, {-70, -28}, {-70, -8}}, color = {0, 0, 255}));
    connect(ground.p, R2.n) annotation(
      Line(points = {{40, -46}, {40, -28}, {-10, -28}}, color = {0, 0, 255}));
    connect(E.p, My_resistor.p) annotation(
      Line(points = {{-70, 12}, {-70, 30}, {-46, 30}}, color = {0, 0, 255}));
    connect(My_resistor.n, C1.p) annotation(
      Line(points = {{-26, 30}, {0, 30}, {0, 52}, {10, 52}}, color = {0, 0, 255}));
    connect(My_resistor.n, R1.p) annotation(
      Line(points = {{-26, 30}, {0, 30}, {0, 12}, {10, 12}}, color = {0, 0, 255}));
    annotation(
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
  end lr3_1;

  model My_resistor
    parameter Modelica.Units.SI.Resistance R(start = 1) "Resistance at temperature T_ref";
    parameter Modelica.Units.SI.Temperature T_ref = 300.15 "Reference temperature";
    parameter Modelica.Units.SI.LinearTemperatureCoefficient alpha = 100 "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
    parameter Modelica.Units.SI.Current i_0 = 1;
    parameter Modelica.Units.SI.Current i_max = 0.002;
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
    Modelica.Units.SI.Resistance R_actual "Actual resistance = R*(1 + alpha*(T_heatPort - T_ref))";
  equation
    assert(1 + alpha * (T_heatPort - T_ref) >= Modelica.Constants.eps, "Temperature outside scope of model!");
    if i > i_max then
      R_actual = R * (1 + alpha * (i_max / i_0 * (i_max / i_0) * (i_max / i_0)));
    elseif i < (-i_max) then
      R_actual = R * (1 - alpha * (i_max / i_0 * (i_max / i_0) * (i_max / i_0)));
    else
      R_actual = R * (1 + alpha * (i / i_0 * (i / i_0) * (i / i_0)));
    end if;
    v = R_actual * i;
    LossPower = v * i;
    annotation(
      Documentation(info = "<html>
  <p>The linear resistor connects the branch voltage <em>v</em> with the branch current <em>i</em> by <em>i*R = v</em>. The Resistance <em>R</em> is allowed to be positive, zero, or negative.</p>
  </html>", revisions = "<html>
  <ul>
  <li><em> August 07, 2009   </em>
         by Anton Haumer<br> temperature dependency of resistance added<br>
         </li>
  <li><em> March 11, 2009   </em>
         by Christoph Clauss<br> conditional heat port added<br>
         </li>
  <li><em> 1998   </em>
         by Christoph Clauss<br> initially implemented<br>
         </li>
  </ul>
  </html>"),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-70, 30}, {70, -30}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-90, 0}, {-70, 0}}, color = {0, 0, 255}), Line(points = {{70, 0}, {90, 0}}, color = {0, 0, 255}), Text(extent = {{-150, -40}, {150, -80}}, textString = "R=%R"), Line(visible = useHeatPort, points = {{0, -100}, {0, -30}}, color = {127, 0, 0}, pattern = LinePattern.Dot), Text(extent = {{-150, 90}, {150, 50}}, textString = "%name", textColor = {0, 0, 255})}),
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
  end My_resistor;

  model lr3_2
    Modelica.Electrical.Analog.Sources.SineVoltage E(V = 220, f = 50) annotation(
      Placement(visible = true, transformation(origin = {-70, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Resistor R2(R = 3000) annotation(
      Placement(visible = true, transformation(origin = {44, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {40, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Capacitor C1(C = 0.0000001) annotation(
      Placement(visible = true, transformation(origin = {10, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor R1(R = 2000) annotation(
      Placement(visible = true, transformation(origin = {46, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor R3(R = 3000) annotation(
      Placement(visible = true, transformation(origin = {-18, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor L(L = 500) annotation(
      Placement(visible = true, transformation(origin = {10, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Andreev_labs_2022.My_resistor R(alpha = 10000) annotation(
      Placement(visible = true, transformation(origin = {-46, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(C1.n, R2.p) annotation(
      Line(points = {{20, 54}, {34, 54}}, color = {0, 0, 255}));
    connect(L.n, R1.p) annotation(
      Line(points = {{20, 8}, {36, 8}}, color = {0, 0, 255}));
    connect(R2.n, R3.n) annotation(
      Line(points = {{54, 54}, {60, 54}, {60, 28}, {80, 28}, {80, -34}, {-8, -34}}, color = {0, 0, 255}));
    connect(R1.n, R3.n) annotation(
      Line(points = {{56, 8}, {60, 8}, {60, 28}, {80, 28}, {80, -34}, {-8, -34}}, color = {0, 0, 255}));
    connect(R3.p, E.n) annotation(
      Line(points = {{-28, -34}, {-70, -34}, {-70, -14}}, color = {0, 0, 255}));
    connect(ground.p, R3.n) annotation(
      Line(points = {{40, -46}, {40, -34}, {-8, -34}}, color = {0, 0, 255}));
    connect(E.p, R.p) annotation(
      Line(points = {{-70, 6}, {-70, 30}, {-56, 30}}, color = {0, 0, 255}));
    connect(R.n, C1.p) annotation(
      Line(points = {{-36, 30}, {-20, 30}, {-20, 54}, {0, 54}}, color = {0, 0, 255}));
    connect(R.n, L.p) annotation(
      Line(points = {{-36, 30}, {-20, 30}, {-20, 8}, {0, 8}}, color = {0, 0, 255}));
    annotation(
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
  end lr3_2;

  model laba1_2
    // переменные
    Real x1[10];
    Real x2[10];
    Real x3[10];
    // параметры
    parameter Integer n = 10;
  initial equation
    for i in 1:n loop
      x1[i] = i / 2;
      x2[i] = x1[i] / 2;
      x3[i] = x2[i] / 2;
    end for;
  equation
    for i in 1:n loop
      der(x1[i]) = 0.5 * (x1[i] + x2[i]) + x2[i] * x2[i];
      der(x2[i]) = 0.5 * ((-x1[i]) + 3 * x2[i]);
      der(x3[i]) = -0.5 * x3[i];
    end for;
  end laba1_2;

  package laba4
    model Podverzhennye
      //Integer X(start = 15000);
      //Integer Y(start = 1);
      //Integer W(start = 0);
      Real P;
      parameter Real D = 0.00134 / 365;
      parameter Real B = 0.00097 / 365;
      parameter Integer V = 20;
      Input inX;
      Input inY;
      Input inW;
      Output outX;
    equation
      P = 0.5;
//inY.val / (inX.val + inY.val + inW.val);
      der(inX.val) = (-P * inX.val * inY.val) - D * inX.val - V + B * inX.val;
      outX.val = inX.val;
//der(inX.val);
    end Podverzhennye;

    model Zarachennye_ne_gospital
      //Integer X(start = 15000);
      //Integer Y(start = 1);
      //Integer W(start = 0);
      Real P;
      parameter Real D = 0.00134 / 365;
      parameter Real D_i = 0.01;
      parameter Real R = 0.2;
      parameter Real H = 10;
      Input inX;
      Input inY;
      Input inW;
      Output outY;
    equation
      P = 0.5;
//inY.val / (inX.val + inY.val + inW.val);
      der(inY.val) = P * inX.val * inY.val - D * inY.val - D_i * inY.val - R * inY.val - H;
      outY.val = der(inY.val);
    end Zarachennye_ne_gospital;

    model Immunitetnye
      //Integer Y(start = 1);
      //Integer W(start = 0);
      Real P;
      parameter Real D = 0.00134 / 365;
      parameter Real R = 0.2;
      parameter Integer V = 20;
      Input inX;
      Input inY;
      Input inW;
      Output outW;
    equation
      P = 0.5;
//inY.val / (inX.val + inY.val + inW.val);
      der(inW.val) = R * inY.val + V - D * inW.val;
      outW.val = inW.val;
    end Immunitetnye;

    connector Output
      output Real val;
    end Output;

    connector Input
      input Real val;
    end Input;

    model Pandemy
      //Podverzhennye X;
      //Zarachennye_ne_gospital Y;
      //Immunitetnye W;
      //equation
      //connect(X.outX, X.inX);
      //connect(X.outX, Y.inX);
      //connect(X.outX, W.inX);
      //connect(Y.outY, Y.inY);
      //connect(Y.outY, X.inY);
      //connect(Y.outY, W.inY);
      //connect(W.outW, W.inW);
      //connect(W.outW, X.inW);
      //connect(W.outW, Y.inW);
      Real X;
      Real Y;
      Real W;
      Real P;
      constant Real D = 0.00134 / 365;
      constant Real B = 0.00097 / 365;
      constant Integer V = 20;
      constant Real D_i = 0.01;
      constant Real R = 0.2;
      constant Real H = 10;
    initial equation
      W = 117;
      Y = 1;
      X = 168660;
    equation
      P = Y / (X + Y + W);
      der(X) = (-P * (X + Y)) - D * X - V + B * X;
      der(Y) = P * (X + Y) - D * Y - D_i * Y - R * Y - H;
      der(W) = R * Y + V - D * W;
      annotation(
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
    end Pandemy;
  end laba4;

  package laba5_kinematic
    model Body2D
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      parameter Real Color[3] = {0, 0, 255};
      Modelica.Units.SI.Length X;
      Modelica.Units.SI.Length Y;
      Modelica.Units.SI.Angle Phi;
      KinematicOutput Body_Out;
    equation
      Body_Out.X = X;
      Body_Out.Y = Y;
      Body_Out.Phi = Phi;
    end Body2D;

    connector KinematicInput
      input Modelica.Units.SI.Length X;
      input Modelica.Units.SI.Length Y;
      input Modelica.Units.SI.Angle Phi;
    end KinematicInput;

    connector KinematicOutput
      output Modelica.Units.SI.Length X;
      output Modelica.Units.SI.Length Y;
      output Modelica.Units.SI.Angle Phi;
    end KinematicOutput;

    model Rod2D
      extends Andreev_labs_2022.laba5_kinematic.Body2D;
      parameter Modelica.Units.SI.Length L = 1;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape RodShape(shapeType = "box", length = L, width = 0.1, height = 0.1, lengthDirection = {cos(Phi), sin(Phi), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X - L / 2 * cos(Phi), Y - L / 2 * sin(Phi), 0}, R = orientation);
    equation

      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end Rod2D;

    model FreeRod
      parameter Modelica.Units.SI.Length L = 2;
      Rod2D Palka(L = L, Color = {0, 255, 80});
    equation
      Palka.X = L / 2 * sin(time);
      Palka.Y = L / 2 * cos(time);
      Palka.Phi = time;
      annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
    end FreeRod;

    model Wheel2D
      extends Andreev_labs_2022.laba5_kinematic.Body2D;
      parameter Modelica.Units.SI.Length R = 1;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape WheelShape(shapeType = "cylinder", length = 0.1, width = 2 * R, height = 2 * R, widthDirection = {cos(Phi), sin(Phi), 0}, lengthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X, Y, 0}, R = orientation, r_shape = {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape BoxShape(shapeType = "box", length = 0.2, width = R, height = R, widthDirection = {cos(Phi), sin(Phi), 0}, lengthDirection = {0, 0, 1}, color = 0.7 * Color, specularCoefficient = 0.5, r = {X, Y, 0}, R = orientation, r_shape = {0, 0, 0});
    equation

      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
    end Wheel2D;

    model FreeWheel
      parameter Modelica.Units.SI.Length R = 2;
      Wheel2D Wheel(R = R, Color = {0, 255, 0});
    equation
      Wheel.X = R / 2 * sin(time);
      Wheel.Y = R / 2 * cos(time);
      Wheel.Phi = time;
      annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
    end FreeWheel;

    model Support2D
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Length Xt = 0;
      parameter Modelica.Units.SI.Length Yt = 0;
      parameter Real Color[3] = {0, 0, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape SupportShape(shapeType = "cylinder", length = 0.5, width = 0.2, height = 0.2, widthDirection = {1, 0, 0}, lengthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {Xp, Yp, -0.2}, R = orientation, r_shape = {0, 0, 0});
      KinematicInput Body_In;
    equation
      Xp = Body_In.X + Xt * cos(Body_In.Phi) - Yt * sin(Body_In.Phi);
      Yp = Body_In.Y + Xt * sin(Body_In.Phi) + Yt * sin(Body_In.Phi);
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end Support2D;

    model PinnedWheel
      parameter Modelica.Units.SI.Length R = 2;
      Wheel2D Koleso(R = R, Color = {0, 255, 0});
      Support2D Opora(Xp = 0, Yp = 0, Xt = -R * 3 / 4, Yt = 0);
    equation
      connect(Koleso.Body_Out, Opora.Body_In);
      Koleso.Phi = time;
      annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
    end PinnedWheel;

    model Joint2D
      Modelica.Units.SI.Length Xsh;
      Modelica.Units.SI.Length Ysh;
      parameter Modelica.Units.SI.Length Xt1 = 0;
      parameter Modelica.Units.SI.Length Yt1 = 0;
      parameter Modelica.Units.SI.Length Xt2 = 0;
      parameter Modelica.Units.SI.Length Yt2 = 0;
      parameter Real Color[3] = {0, 0, 200};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape SupportShape(shapeType = "cylinder", length = 0.5, width = 0.2, height = 0.2, widthDirection = {1, 0, 0}, lengthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {Xsh, Ysh, -0.2}, R = orientation, r_shape = {0, 0, 0});
      KinematicInput Body_In1;
      KinematicInput Body_In2;
    equation
      Xsh = Body_In1.X + Xt1 * cos(Body_In1.Phi) - Yt1 * sin(Body_In1.Phi);
      Ysh = Body_In1.Y + Xt1 * sin(Body_In1.Phi) + Yt1 * cos(Body_In1.Phi);
      Xsh = Body_In2.X + Xt2 * cos(Body_In2.Phi) - Yt2 * sin(Body_In2.Phi);
      Ysh = Body_In2.Y + Xt2 * sin(Body_In2.Phi) + Yt2 * cos(Body_In2.Phi);
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end Joint2D;

    model DvePalkiNaOpore
      parameter Modelica.Units.SI.Length L1 = 2;
      parameter Modelica.Units.SI.Length L2 = 4;
      Rod2D Palka1(L = L1, Color = {0, 255, 80});
      Rod2D Palka2(L = L2, Color = {255, 255, 0});
      Support2D Opora(Xp = 0, Yp = 0, Xt = -L1 / 2, Yt = 0);
      Joint2D Sharnir(Xt1 = L1 / 2, Yt1 = 0, Xt2 = -L1 / 2, Yt2 = 0);
    equation
      connect(Palka1.Body_Out, Opora.Body_In);
      connect(Palka1.Body_Out, Sharnir.Body_In1);
      connect(Palka2.Body_Out, Sharnir.Body_In2);
      Palka1.Phi = time;
      Palka2.Phi = cos(time);
      annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
    end DvePalkiNaOpore;

    model TriPalki
      parameter Modelica.Units.SI.Length L1 = 2;
      parameter Modelica.Units.SI.Length L2 = 4;
      parameter Modelica.Units.SI.Length L3 = 6;
      parameter Modelica.Units.SI.Angle phi0_1 = 1;
      parameter Modelica.Units.SI.Angle phi0_2 = 0;
      parameter Modelica.Units.SI.Angle phi0_3 = -2;
      parameter Modelica.Units.SI.Length Xo2 = L1 * cos(phi0_1) + L2 * cos(phi0_2) + L3 * cos(phi0_3);
      parameter Modelica.Units.SI.Length Yo2 = L1 * sin(phi0_1) + L2 * sin(phi0_2) + L3 * sin(phi0_3);
      Rod2D Palka1(Phi(start = phi0_1), L = L1, Color = {0, 255, 80});
      Rod2D Palka2(Phi(start = phi0_2), L = L2, Color = {255, 255, 0});
      Rod2D Palka3(Phi(start = phi0_3), L = L3, Color = {255, 0, 255});
      Support2D Opora1(Xp = 0, Yp = 0, Xt = -L1 / 2, Yt = 0);
      Support2D Opora2(Xp = Xo2, Yp = Yo2, Xt = L3 / 2, Yt = 0);
      Joint2D Sharnir1(Xt1 = L1 / 2, Yt1 = 0, Xt2 = -L2 / 2, Yt2 = 0);
      Joint2D Sharnir2(Xt1 = L2 / 2, Yt1 = 0, Xt2 = -L3 / 2, Yt2 = 0);
    equation
      connect(Palka1.Body_Out, Opora1.Body_In);
      connect(Palka1.Body_Out, Sharnir1.Body_In1);
      connect(Palka2.Body_Out, Sharnir1.Body_In2);
      connect(Palka2.Body_Out, Sharnir2.Body_In1);
      connect(Palka3.Body_Out, Sharnir2.Body_In2);
      connect(Palka3.Body_Out, Opora2.Body_In);
      der(Palka1.Phi) = 1;
      annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
    end TriPalki;

    model Slider2D
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Angle Phip = 0;
      parameter Modelica.Units.SI.Length Xt = 0;
      parameter Modelica.Units.SI.Length Yt = 0;
      Modelica.Units.SI.Length Xpol;
      Modelica.Units.SI.Length Ypol;
      Modelica.Units.SI.Length S;
      parameter Real Color[3] = {0, 255, 255};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      parameter Modelica.Units.SI.Length l = 0.3;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape SliderShape(shapeType = "box", length = l, width = 0.2, height = 0.2, lengthDirection = {cos(Phip), sin(Phip), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {Xpol - l / 2 * cos(Phip), Ypol - l / 2 * sin(Phip), 0}, R = orientation);
      KinematicInput Body_In;
    equation
      Xpol = Body_In.X + Xt * cos(Body_In.Phi) - Yt * sin(Body_In.Phi);
      Ypol = Body_In.Y + Xt * sin(Body_In.Phi) + Yt * sin(Body_In.Phi);
      Xpol = Xp + S * cos(Phip);
      Ypol = Yp + S * sin(Phip);
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end Slider2D;

    model DvePalkiPlusPolzun
      parameter Modelica.Units.SI.Length L1 = 2;
      parameter Modelica.Units.SI.Length L2 = 4;
      Rod2D Palka1(L = L1, Color = {0, 255, 80});
      Rod2D Palka2(L = L2, Color = {255, 255, 0});
      Support2D Opora(Xp = 0, Yp = 0, Xt = -L1 / 2, Yt = 0);
      Joint2D Sharnir(Xt1 = L1 / 2, Yt1 = 0, Xt2 = -L2 / 2, Yt2 = 0);
      Slider2D Polzun(Xp = 0, Yp = 1.3, Phip = 0, Xt = L2 / 2, Yt = 0);
    equation
      connect(Palka1.Body_Out, Opora.Body_In);
      connect(Palka1.Body_Out, Sharnir.Body_In1);
      connect(Palka2.Body_Out, Sharnir.Body_In2);
      connect(Palka2.Body_Out, Polzun.Body_In);
      Palka1.Phi = time;
      annotation(
        experiment(StartTime = 0, StopTime = 6.3, Tolerance = 1e-06, Interval = 0.000200006));
    end DvePalkiPlusPolzun;

    model RollCircleOnLine
      parameter Modelica.Units.SI.Length Xp = 0;
      parameter Modelica.Units.SI.Length Yp = 0;
      parameter Modelica.Units.SI.Angle Phip = 0;
      parameter Modelica.Units.SI.Length R = 1;
      Modelica.Units.SI.Length Xk;
      Modelica.Units.SI.Length Yk;
      Modelica.Units.SI.Length S;
      parameter Real Color[3] = {0, 0, 0};
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      parameter Modelica.Units.SI.Length l = 3.5 * R;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape FlatShape(shapeType = "box", length = l, width = 0.2, height = 0.2, lengthDirection = {cos(Phip), sin(Phip), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {Xp - l / 2 * cos(Phip) + 0.1 * sin(Phip), Yp - l / 2 * sin(Phip) - 0.1 * cos(Phip), 0}, R = orientation);
      KinematicInput Body_In;
    equation
      Xk = Body_In.X + R * sin(Phip);
      Yk = Body_In.Y - R * cos(Phip);
      Xk = Xp + S * cos(Phip);
      Yk = Yp + S * sin(Phip);
      der(S) = -der(Body_In.Phi) * R;
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end RollCircleOnLine;

    model PalkiPlusLoleso
      parameter Modelica.Units.SI.Length L1 = 2;
      parameter Modelica.Units.SI.Length L2 = 4;
      parameter Modelica.Units.SI.Angle phi0_1 = 1.57;
      parameter Modelica.Units.SI.Angle phi0_2 = 0.3;
      parameter Modelica.Units.SI.Angle phip = 0.7;
      parameter Modelica.Units.SI.Length R = 1;
      parameter Modelica.Units.SI.Length XK = L1 * cos(phi0_1) + L2 * cos(phi0_2) + R * sin(phip);
      parameter Modelica.Units.SI.Length YK = L1 * sin(phi0_1) + L2 * sin(phi0_2) - R * cos(phip);
      Rod2D Palka1(L = L1, Color = {0, 255, 80}, Phi(start = phi0_1));
      Rod2D Palka2(L = L2, Color = {255, 255, 0}, Phi(start = phi0_2));
      Support2D Opora(Xp = 0, Yp = 0, Xt = -L1 / 2, Yt = 0);
      Joint2D Sharnir1(Xt1 = L1 / 2, Yt1 = 0, Xt2 = -L2 / 2, Yt2 = 0);
      Joint2D Sharnir2(Xt1 = L2 / 2, Yt1 = 0, Xt2 = 0, Yt2 = 0);
      Wheel2D Koleso(R = R, Color = {150, 0, 0});
      RollCircleOnLine Kachenie(R = R, Xp = XK, Yp = YK, Phip = phip);
    equation
      connect(Palka1.Body_Out, Opora.Body_In);
      connect(Palka1.Body_Out, Sharnir1.Body_In1);
      connect(Palka2.Body_Out, Sharnir1.Body_In2);
      connect(Palka2.Body_Out, Sharnir2.Body_In1);
      connect(Koleso.Body_Out, Sharnir2.Body_In2);
      connect(Koleso.Body_Out, Kachenie.Body_In);
      der(Palka1.Phi) = 1;
      annotation(
        experiment(StartTime = 0, StopTime = 6.3, Tolerance = 1e-06, Interval = 0.000200006));
    end PalkiPlusLoleso;

    model Zadanie11
      parameter Modelica.Units.SI.Length L1 = 1;
      parameter Modelica.Units.SI.Length L2 = 3;
      parameter Modelica.Units.SI.Length L4 = 3;
      parameter Modelica.Units.SI.Angle phi0_1 = 1.1;
      parameter Modelica.Units.SI.Angle phi0_2 = 0.2;
      parameter Modelica.Units.SI.Angle phi0_3 = 1.05;
      // pi/3
      parameter Modelica.Units.SI.Angle phi0_4 = 2.1;
      parameter Modelica.Units.SI.Angle phip = 0;
      parameter Modelica.Units.SI.Angle phiC = 1.57;
      parameter Modelica.Units.SI.Length X0 = 0;
      parameter Modelica.Units.SI.Length Y0 = 0;
      parameter Modelica.Units.SI.Length R = 1;
      parameter Modelica.Units.SI.Length XK = X0 + L1 * cos(phi0_1) + L2 * cos(phi0_2) + 2 * R * sin(phip);
      parameter Modelica.Units.SI.Length YK = Y0 + L1 * sin(phi0_1) + L2 * sin(phi0_2) - 2 * R * cos(phip);
      parameter Modelica.Units.SI.Length XC = X0 + L1 * cos(phi0_1) + L4 * cos(phi0_4);
      Rod2D Palka1(L = L1, Color = {0, 255, 80}, Phi(start = phi0_1));
      Rod2D Palka2(L = L2, Color = {255, 255, 0}, Phi(start = phi0_2));
      Support2D Opora(Xp = X0, Yp = X0, Xt = -L1 / 2, Yt = 0);
      Joint2D Sharnir1(Xt1 = L1 / 2, Yt1 = 0, Xt2 = -L2 / 2, Yt2 = 0);
      Joint2D Sharnir2(Xt1 = L2 / 2, Yt1 = 0, Xt2 = R * cos(phi0_3), Yt2 = R * sin(phi0_3));
      Wheel2D Koleso(R = R, Color = {150, 0, 0});
      RollCircleOnLine Kachenie(R = R, Xp = XK, Yp = YK, Phip = phip);
      Rod2D Palka4(L = L4, Color = {255, 0, 255}, Phi(start = phi0_4));
      Joint2D Sharnir3(Xt1 = -L2 / 2, Yt1 = 0, Xt2 = -L4 / 2, Yt2 = 0);
      Slider2D Polzun(Xp = XC, Yp = 0, Phip = phiC, Xt = L4 / 2, Yt = 0);
    equation
      connect(Palka1.Body_Out, Opora.Body_In);
      connect(Palka1.Body_Out, Sharnir1.Body_In1);
      connect(Palka2.Body_Out, Sharnir1.Body_In2);
      connect(Palka2.Body_Out, Sharnir2.Body_In1);
      connect(Koleso.Body_Out, Sharnir2.Body_In2);
      connect(Koleso.Body_Out, Kachenie.Body_In);
      connect(Palka2.Body_Out, Sharnir3.Body_In1);
      connect(Palka4.Body_Out, Sharnir3.Body_In2);
      connect(Palka4.Body_Out, Polzun.Body_In);
      der(Palka1.Phi) = 1;
      annotation(
        experiment(StartTime = 0, StopTime = 6.3, Tolerance = 1e-06, Interval = 0.000200006));
    end Zadanie11;
  end laba5_kinematic;
  annotation(
    uses(Modelica(version = "4.0.0")));
end Andreev_labs_2022;
