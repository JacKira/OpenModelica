model Lab2
  parameter Real K = 1;
  parameter Real K2 = 1;
  parameter Real K3 = 1;
  parameter Real K4 = 1;
  Real x(start = 1);
  Real v(start = 2);
  parameter Real F = K;
equation
 
  der(x) = v;
  der(v) = (-F) - K2 * x + K3 * sin(K4 * time);
//  if x > 0 then
//    F = K;
//  end if;
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
end Lab2;
