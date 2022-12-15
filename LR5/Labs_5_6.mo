package Fejzullin_Lab_5_6
  package Lab_5_Kinematica
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
      extends Fejzullin_Lab_5_6.Lab_5_Kinematica.Body2D;
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
      extends Fejzullin_Lab_5_6.Lab_5_Kinematica.Body2D;
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

    model RollCircleOnBottom
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
    end RollCircleOnBottom;

    model Zadanie13
      parameter Modelica.Units.SI.Length L1 = 2.3;
      parameter Modelica.Units.SI.Length L2 = 8.5;
      parameter Modelica.Units.SI.Length L3 = 10;
      parameter Modelica.Units.SI.Length L4 = 9.5;
      
      parameter Modelica.Units.SI.Angle phi0_2 = 2.965;
      parameter Modelica.Units.SI.Angle phi0_3 = 0.523;
      parameter Modelica.Units.SI.Angle phi0_1 = phi0_3 * 2;
      parameter Modelica.Units.SI.Angle phi0_4 = 2.9481;
      parameter Modelica.Units.SI.Angle new_phi = 1;
      parameter Modelica.Units.SI.Angle phip = 0;
      parameter Modelica.Units.SI.Length X0 = 5;
      parameter Modelica.Units.SI.Length Y0 = 0-5;
      parameter Modelica.Units.SI.Length R = 2.3;
      parameter Modelica.Units.SI.Length XK = X0 + L2 * cos(phi0_2) + L1 * cos(phi0_1) + R * sin(phip);
      parameter Modelica.Units.SI.Length YK = Y0 + L2 * sin(phi0_2) + L1 * sin(phi0_1) - R * cos(phip);
      Rod2D Palka1(L = L1, Color = {255, 0, 0}, Phi(start = phi0_1));
      //Red
      Rod2D Palka2(L = L2, Color = {255, 255, 0}, Phi(start = phi0_2));
      // Yellow
      Rod2D Palka3(L = L3, Color = {255, 170, 191}, Phi(start = phi0_3));
      //Pink
      Rod2D Palka4(L = L4, Color = {75, 0, 248}, Phi(start = phi0_4));
      //Blue
      Support2D Opora1(Xp = X0, Yp = Y0, Xt = -L1 / 2, Yt = 0);
      parameter Modelica.Units.SI.Length X02 = X0 + L1 * cos(phi0_1) + L2 * cos(phi0_2) + L3 * cos(phi0_3) + L4 * cos(phi0_4);
      parameter Modelica.Units.SI.Length Y02 = Y0 + L1 * sin(phi0_1) + L2 * sin(phi0_2) + L3 * sin(phi0_3) + L4 * sin(phi0_4);
      Support2D Opora2(Xp = X02, Yp = Y02, Xt = L4 / 2, Yt = 0);
      Joint2D Sharnir1(Xt1 = L1 / 2, Yt1 = 0, Xt2 = -L2 / 2, Yt2 = 0);
      Joint2D Sharnir2(Xt1 = L2 / 2, Yt1 = 0, Xt2 = -L3 / 2, Yt2 = 0);
      Joint2D Sharnir3(Xt1 = L3 / 2, Yt1 = 0, Xt2 = -L4 / 2, Yt2 = 0);
      Joint2D Sharnir4(Xt1 = L2 / 2, Yt1 = 0, Xt2 = 0, Yt2 = 0);
      Wheel2D Koleso(R = R, Color = {150, 0, 0});
      RollCircleOnBottom Kachenie(R = R, Xp = XK, Yp = YK, Phip = phip);
    equation
      connect(Palka1.Body_Out, Opora1.Body_In);
      connect(Palka4.Body_Out, Opora2.Body_In);
      
      connect(Palka1.Body_Out, Sharnir1.Body_In1);
      connect(Palka2.Body_Out, Sharnir1.Body_In2);
      
      connect(Palka3.Body_Out, Sharnir3.Body_In1);
      connect(Palka4.Body_Out, Sharnir3.Body_In2);
      
      connect(Palka2.Body_Out, Sharnir2.Body_In1);
      connect(Palka3.Body_Out, Sharnir2.Body_In2);
      
      
      connect(Palka2.Body_Out, Sharnir4.Body_In1);
      connect(Koleso.Body_Out, Sharnir4.Body_In2);
      
      connect(Koleso.Body_Out, Kachenie.Body_In);
      
    
      der(Palka1.Phi) = (Modelica.Constants.pi - Palka3.Phi)/2  ;
    
     
    
      //der(Palka3.Phi) = 1.3;
      annotation(
        experiment(StartTime = 0, StopTime = 4.6, Tolerance = 1e-06, Interval = 0.000146036));
    end Zadanie13;
  end Lab_5_Kinematica;
  
  package Lab_6_Dynamica
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
      extends Fejzullin_Lab_5_6.laba5_kinematic.Body2D;
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
      extends Fejzullin_Lab_5_6.laba5_kinematic.Body2D;
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
      // Additional for Dynamica Modeling
      Modelica.Units.SI.Force Rx;
      Modelica.Units.SI.Force Ry;
      ForceOutput FO;
      // End of Additional
      KinematicInput Body_In;
    equation
      Xp = Body_In.X + Xt * cos(Body_In.Phi) - Yt * sin(Body_In.Phi);
      Yp = Body_In.Y + Xt * sin(Body_In.Phi) + Yt * sin(Body_In.Phi);
// Additional for Dynamica Modeling
      FO.X = Xp;
      FO.Y = Yp;
      FO.Fx = Rx;
      FO.Fy = Ry;
      FO.M = 0;
      // End of Additional
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end Support2D;
  
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
      // Additional for Dynamica Modeling
      Modelica.Units.SI.Force Rx;
      Modelica.Units.SI.Force Ry;
      ForceOutput FO1;
      ForceOutput FO2;
      // End of Additional
    equation
      Xsh = Body_In1.X + Xt1 * cos(Body_In1.Phi) - Yt1 * sin(Body_In1.Phi);
      Ysh = Body_In1.Y + Xt1 * sin(Body_In1.Phi) + Yt1 * cos(Body_In1.Phi);
      Xsh = Body_In2.X + Xt2 * cos(Body_In2.Phi) - Yt2 * sin(Body_In2.Phi);
      Ysh = Body_In2.Y + Xt2 * sin(Body_In2.Phi) + Yt2 * cos(Body_In2.Phi);
// Additional for Dynamica Modeling
      FO1.X = Xsh;
      FO1.Y = Ysh;
      FO1.Fx = Rx;
      FO1.Fy = Ry;
      FO1.M = 0;
      FO2.X = Xsh;
      FO2.Y = Ysh;
      FO2.Fx = -Rx;
      FO2.Fy = -Ry;
      FO2.M = 0;
      // End of Additional
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end Joint2D;
  
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
  
    model RollCircleOnBottom
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
  // Additional for Dynamica Modeling
      Modelica.Units.SI.Force N;
      Modelica.Units.SI.Force Ftr;
      ForceOutput FO;
      // End of Additional
    equation
      Xk = Body_In.X + R * sin(Phip);
      Yk = Body_In.Y - R * cos(Phip);
      Xk = Xp + S * cos(Phip);
      Yk = Yp + S * sin(Phip);
      der(S) = -der(Body_In.Phi) * R;
// Additional for Dynamica Modeling
      FO.X = Xk;
      FO.Y = Yk;
      FO.Fx = (-N * sin(Phip)) - Ftr * cos(Phip);
      FO.Fy = N * cos(Phip) - Ftr * sin(Phip);
      FO.M = 0;
// End of Additional
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end RollCircleOnBottom;
  
    model Zadanie13
      parameter Modelica.Units.SI.Length L1 = 2.3;
      parameter Modelica.Units.SI.Length L2 = 8.5;
      parameter Modelica.Units.SI.Length L3 = 10;
      parameter Modelica.Units.SI.Length L4 = 9.5;
      parameter Real p = 4;
      parameter Modelica.Units.SI.Angle phi0_1 = 1.046;
      parameter Modelica.Units.SI.Angle phi0_2 = 2.965;
      parameter Modelica.Units.SI.Angle phi0_3 = 0.523;
      parameter Modelica.Units.SI.Angle phi0_4 = 2.9481;
      parameter Modelica.Units.SI.Angle phip = 0;
      parameter Modelica.Units.SI.Length X0 = 5;
      parameter Modelica.Units.SI.Length Y0 = 0-5;
      parameter Modelica.Units.SI.Length R = 2.3;
      parameter Modelica.Units.SI.Length XK = X0 + L2 * cos(phi0_2) + L1 * cos(phi0_1) + R * sin(phip);
      parameter Modelica.Units.SI.Length YK = Y0 + L2 * sin(phi0_2) + L1 * sin(phi0_1) - R * cos(phip);
      TwoPortRod2D Palka1(L = L1, Color = {255, 0, 0}, Phi(start = phi0_1), m = L1 * p);
      //Red
      ThreePortRod2D Palka2(L = L2, Color = {255, 255, 0}, Phi(start = phi0_2), m = L2 * p);
      // Yellow
      TwoPortRod2D Palka3(L = L3, Color = {255, 170, 191}, Phi(start = phi0_3), m = L3 * p);
      //Pink
      TwoPortRod2D Palka4(L = L4, Color = {75, 0, 248}, Phi(start = phi0_4), m = L4 * p);
      //Blue
      Support2D Opora1(Xp = X0, Yp = Y0, Xt = -L1 / 2, Yt = 0);
      parameter Modelica.Units.SI.Length X02 = X0 + L1 * cos(phi0_1) + L2 * cos(phi0_2) + L3 * cos(phi0_3) + L4 * cos(phi0_4);
      parameter Modelica.Units.SI.Length Y02 = Y0 + L1 * sin(phi0_1) + L2 * sin(phi0_2) + L3 * sin(phi0_3) + L4 * sin(phi0_4);
      Support2D Opora2(Xp = X02, Yp = Y02, Xt = L4 / 2, Yt = 0);
      Joint2D Sharnir1(Xt1 = L1 / 2, Yt1 = 0, Xt2 = -L2 / 2, Yt2 = 0);
      Joint2D Sharnir2(Xt1 = L2 / 2, Yt1 = 0, Xt2 = -L3 / 2, Yt2 = 0);
      Joint2D Sharnir3(Xt1 = L3 / 2, Yt1 = 0, Xt2 = -L4 / 2, Yt2 = 0);
      Joint2D Sharnir4(Xt1 = L2 / 2, Yt1 = 0, Xt2 = 0, Yt2 = 0);
      TwoPortWheel2D Koleso(R = R, Color = {150, 0, 0}, m = Modelica.Constants.pi * R * R * p * 2);
      RollCircleOnBottom Kachenie(R = R, Xp = XK, Yp = YK, Phip = phip);
    equation
      connect(Palka1.Body_Out, Opora1.Body_In);
      connect(Palka1.Body_Out, Sharnir1.Body_In1);
      connect(Palka2.Body_Out, Sharnir1.Body_In2);
      connect(Palka2.Body_Out, Sharnir2.Body_In1);
      connect(Palka3.Body_Out, Sharnir2.Body_In2);
      connect(Palka3.Body_Out, Sharnir3.Body_In1);
      connect(Palka4.Body_Out, Sharnir3.Body_In2);
      connect(Palka4.Body_Out, Opora2.Body_In);
      connect(Palka2.Body_Out, Sharnir4.Body_In1);
      connect(Koleso.Body_Out, Sharnir4.Body_In2);
      connect(Koleso.Body_Out, Kachenie.Body_In);
    
      connect(Palka1.F_A, Opora1.FO);
      connect(Palka1.F_B, Sharnir1.FO1);
      connect(Palka2.F_A, Sharnir1.FO2);
      connect(Palka2.F_B, Sharnir2.FO1);
      connect(Palka3.F_A, Sharnir2.FO2);
      connect(Palka3.F_B, Sharnir3.FO1);
      connect(Palka4.F_A, Sharnir3.FO2);
      connect(Palka4.F_B, Opora2.FO);
      
      connect(Palka2.F_C, Sharnir4.FO1);
      connect(Koleso.F_A, Sharnir4.FO2);
      connect(Koleso.F_B, Kachenie.FO);
    
      annotation(
        experiment(StartTime = 0, StopTime = 12, Tolerance = 1e-06, Interval = 0.000380964));
    end Zadanie13;

    // New Obljects for Dynamica Modeling

    connector ForceInput
      input Modelica.Units.SI.Length X;
      input Modelica.Units.SI.Length Y;
      input Modelica.Units.SI.Force Fx;
      input Modelica.Units.SI.Force Fy;
      input Modelica.Units.SI.MomentOfForce M;
    end ForceInput;

    connector ForceOutput
      output Modelica.Units.SI.Length X;
      output Modelica.Units.SI.Length Y;
      output Modelica.Units.SI.Force Fx;
      output Modelica.Units.SI.Force Fy;
      output Modelica.Units.SI.MomentOfForce M;
    end ForceOutput;

    model TwoPortBody2D
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      parameter Real Color[3] = {0, 0, 255};
      parameter Modelica.Units.SI.Acceleration g = 9.81;
      parameter Modelica.Units.SI.Mass m = 1;
      Modelica.Units.SI.Length X;
      Modelica.Units.SI.Length Y;
      Modelica.Units.SI.Angle Phi;
      Modelica.Units.SI.Velocity Vx;
      Modelica.Units.SI.Velocity Vy;
      Modelica.Units.SI.AngularVelocity Omega;
      Modelica.Units.SI.Length CA[2];
      Modelica.Units.SI.Length CB[2];
      KinematicOutput Body_Out;
      ForceInput F_A;
      ForceInput F_B;
    equation
      Body_Out.X = X;
      Body_Out.Y = Y;
      Body_Out.Phi = Phi;
      der(X) = Vx;
      der(Y) = Vy;
      der(Phi) = Omega;
      CA = {F_A.X - X, F_A.Y - Y};
      CB = {F_B.X - X, F_B.Y - Y};
      m * der(Vx) = F_A.Fx + F_B.Fx;
      m * der(Vy) = F_A.Fy + F_B.Fy - m * g;
      m * der(Omega) = CA[1] * F_A.Fy - CA[2] * F_A.Fx + F_A.M + CB[1] * F_B.Fy - CB[2] * F_B.Fx + F_B.M;
    end TwoPortBody2D;

    model TwoPortRod2D
      extends Fejzullin_Lab_5_6.Lab_6_Dynamica.TwoPortBody2D;
      parameter Modelica.Units.SI.Length L = 1;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape RodShape(shapeType = "box", length = L, width = 0.1, height = 0.1, lengthDirection = {cos(Phi), sin(Phi), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X - L / 2 * cos(Phi), Y - L / 2 * sin(Phi), 0}, R = orientation);
      parameter Modelica.Units.SI.MomentOfInertia J = m * L ^ 2 / 12;
    equation
    
    end TwoPortRod2D;

    model TwoPortWheel2D
      extends Fejzullin_Lab_5_6.Lab_6_Dynamica.TwoPortBody2D;
      parameter Modelica.Units.SI.Length R = 1;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape WheelShape(shapeType = "cylinder", length = 0.1, width = 2 * R, height = 2 * R, widthDirection = {cos(Phi), sin(Phi), 0}, lengthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X, Y, 0}, R = orientation, r_shape = {0, 0, 0});
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape BoxShape(shapeType = "box", length = 0.2, width = R, height = R, widthDirection = {cos(Phi), sin(Phi), 0}, lengthDirection = {0, 0, 1}, color = 0.7 * Color, specularCoefficient = 0.5, r = {X, Y, 0}, R = orientation, r_shape = {0, 0, 0});
      parameter Modelica.Units.SI.MomentOfInertia J = m * R ^ 2 / 2;
    equation
    
    end TwoPortWheel2D;

    model ThreePortBody2D
      parameter Modelica.Mechanics.MultiBody.Frames.Orientation orientation = Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {0, 0, 0}, {0, 0, 0});
      parameter Real Color[3] = {0, 0, 255};
      parameter Modelica.Units.SI.Acceleration g = 9.81;
      parameter Modelica.Units.SI.Mass m = 1;
      Modelica.Units.SI.Length X;
      Modelica.Units.SI.Length Y;
      Modelica.Units.SI.Angle Phi;
      Modelica.Units.SI.Velocity Vx;
      Modelica.Units.SI.Velocity Vy;
      Modelica.Units.SI.AngularVelocity Omega;
      Modelica.Units.SI.Length CA[2];
      Modelica.Units.SI.Length CB[2];
      Modelica.Units.SI.Length CC[2];
      KinematicOutput Body_Out;
      ForceInput F_A;
      ForceInput F_B;
      ForceInput F_C;
    equation
      Body_Out.X = X;
      Body_Out.Y = Y;
      Body_Out.Phi = Phi;
      der(X) = Vx;
      der(Y) = Vy;
      der(Phi) = Omega;
      CA = {F_A.X - X, F_A.Y - Y};
      CB = {F_B.X - X, F_B.Y - Y};
      CC = {F_C.X - X, F_C.Y - Y};
      m * der(Vx) = F_A.Fx + F_B.Fx + F_C.Fx;
      m * der(Vy) = F_A.Fy + F_B.Fy + F_C.Fy - m * g;
      m * der(Omega) = CA[1] * F_A.Fy - CA[2] * F_A.Fx + F_A.M + CB[1] * F_B.Fy - CB[2] * F_B.Fx + F_B.M + CC[1] * F_C.Fy - CC[2] * F_C.Fx + F_C.M;
    end ThreePortBody2D;

    model ThreePortWheel2D
      extends Fejzullin_Lab_5_6.Lab6_Dynamic.ThreePortBody2D;
      parameter Modelica.Units.SI.Length L = 1;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape RodShape(shapeType = "box", length = L, width = 0.1, height = 0.1, lengthDirection = {cos(Phi), sin(Phi), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X - L / 2 * cos(Phi), Y - L / 2 * sin(Phi), 0}, R = orientation);
      parameter Modelica.Units.SI.MomentOfInertia J = m * L ^ 2 / 12;
    equation
    
    end ThreePortWheel2D;

    model ThreePortRod2D
      extends Fejzullin_Lab_5_6.Lab_6_Dynamica.ThreePortBody2D;
      parameter Modelica.Units.SI.Length L = 1;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape RodShape(shapeType = "box", length = L, width = 0.1, height = 0.1, lengthDirection = {cos(Phi), sin(Phi), 0}, widthDirection = {0, 0, 1}, color = Color, specularCoefficient = 0.5, r = {X - L / 2 * cos(Phi), Y - L / 2 * sin(Phi), 0}, R = orientation);
      parameter Modelica.Units.SI.MomentOfInertia J = m * L ^ 2 / 12;
    equation
    
    end ThreePortRod2D;

    // End of New Objects
  end Lab_6_Dynamica;
  annotation(
    uses(Modelica(version = "4.0.0")));
end Fejzullin_Lab_5_6;
