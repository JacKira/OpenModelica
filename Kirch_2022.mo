model Kirch_2022
  parameter Real a = 1;
  parameter Real q = 1;
  Real y[11];
  Real v[11];
  
initial equation
for i in 1:11 loop
    v[i] = 0;
    y[i] = 3 - 0.5 * i  ;
end for;
equation
  for i in 1:11 loop
    der(y[i]) = v[i];
    der(v[i]) = -(a - 2 * q * cos(2 * y[i])) * y[i];
  end for;
    
annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.0002));
end Kirch_2022;
