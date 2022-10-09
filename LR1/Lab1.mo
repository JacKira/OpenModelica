// LAB1-1
//model Kirch_2022
//  Real x[11];
//  Real y[11];
//initial equation
//  for i in 1:11 loop
//      y[i] = 20 / i;
//      x[i] = 0.00000001 *  10^i;
//  end for;
//equation
//  for i in 1:11 loop
//    der(x[i]) = x[i] * (3 - 4 * y[i]);
//    der(y[i]) = -1 * y[i] * (5 - 6 * x[i]);
//  end for;
//  annotation(
//    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
//end Kirch_2022;



//LAB1-2
model Kirch_2022
  Real x[11];
  Real y[11];
  Real z[11];
initial equation
  for i in 1:11 loop
      y[i] = 20 / i;
      x[i] = -20 / i;
      z[i] = y[i] /  x[i]^(i+2);
  end for;
equation
  for i in 1:11 loop
    der(x[i]) = x[i]^2 + 2 * x[i] * y[i];
    der(y[i]) = y[i]^2 + 2 * x[i] * y[i];
    der(z[i]) = z[i] / 3;
  end for;
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end Kirch_2022;
