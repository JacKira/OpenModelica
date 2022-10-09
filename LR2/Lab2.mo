// LAB2-1
//model Lab2
//  Real x(start = -1);
//  Real v(start = -2);
//  Real F;
//  Real flag(start = 1.5);
//  parameter Real K = 1;
//  parameter Real K2 = 2;
//  parameter Real K3 = 3;
//  parameter Real K4 = 4;
//  parameter Real a = 1;
//  parameter Real b = 0.5;

//equation
//  der(x) = v;
//  der(v) = (-F) - K2 * x + K3 * sin(K4 * time);
//  if flag < 2 then
//    if x < (-b * a) then
//      F = -K;
//    else
//      F = 0;
//      flag = 2.5;
//    end if;
//  elseif flag < 3 then
//    if x < (-a) then
//      F = -K;
//      flag = 1.5;
//    elseif x < a then
//      F = 0;
//    else
//      F = K;
//      flag = 3.5;
//    end if;
//  else
//    if x > b * a then
//      F = K;
//    else
//      F = 0;
//      flag = 2.5;
//    end if;
//  end if;
//annotation(
//    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002));
//end Lab2;




//// LAB2-2
//model Lab2
//  Real x(start = -1);
//  Real v(start = -2);
//  Real F;
//  Real flag(start = 1.5);
//  parameter Real K = 1;
//  parameter Real K2 = 2;
//  parameter Real K3 = 3;
//  parameter Real K4 = 4;
//  parameter Real a = 1;
//  parameter Real b = 0.5;

//equation
//  der(x) = v;
//  der(v) = (-F) - K2 * x + K3 * sin(K4 * time);
//  if flag < 2 then
//    if x < b then
//      F = -K;
//    elseif x > a then
//      F = K;
//      flag = 2.5;
//    else
//      F = 2 * K * (x - b) / (a - b) - K;
//      flag = 2.5;
//    end if;
//  else
//    if x > (-b) then
//      F = K;
//    elseif x < (-a) then
//      F = -K;
//      flag = 1.5;
//    else
//      F = 2 * K * (x + a) / ((-b) + a) - K;
//      flag = 1.5;
//    end if;
//  end if;

//annotation(
//    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002));
//end Lab2;


//// LAB2-3
model Lab2
  Real x(start = -5);
  Real v(start = -5);
  Real F;
  parameter Real K = 5;
  parameter Real K2 = 2;
  parameter Real K3 = 3;
  parameter Real K4 = 4;
  parameter Real a = 1;
  parameter Real b = 3;
  parameter Real d = 2;

equation
  der(x) = v;
  der(v) = (-F) - K2 * x + K3 * sin(K4 * time);
  if x < -d then
    F = -K;
  elseif x < -a then
    F = (-b + K)*(x + d)/(-a + d) - K;
  elseif x < a then
    F = 0;
  elseif x < d then
    F = (b - K)*(x - d)/(a - d) + K;
  else
    F = K;
  end if;
annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.002));
end Lab2;
