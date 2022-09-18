model Kirch_2022
  parameter Real a = 1;
  parameter Real q = 1 / 3.14;
  Real x[11];
  Real y[11];
initial equation
  for i in 1:11 loop
      y[i] = 0;
      x[i] = -10 + 1 * i;
  end for;
equation
  for i in 1:11 loop
    der(x[i]) = y[i];
    der(y[i]) = sin(a * x[i]) * sin(q * x[i]);
  end for;
  annotation(
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.0012));
end Kirch_2022;
