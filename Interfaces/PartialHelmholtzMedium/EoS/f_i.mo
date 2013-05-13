within HelmholtzMedia.Interfaces.PartialHelmholtzMedium.EoS;
function f_i "ideal part of dimensionless Helmholtz energy"

  input Real delta;
  input Real tau;
  output Real f_ideal "ideal part of dimensionless Helmholtz energy";

protected
  final constant Integer nLog=size(helmholtzCoefficients.idealLog, 1);
  final constant Integer nPower=size(helmholtzCoefficients.idealPower, 1);
  final constant Integer nEinstein=size(helmholtzCoefficients.idealEinstein, 1);
  final constant Integer nCosh=size(helmholtzCoefficients.idealCosh, 1);
  final constant Integer nSinh=size(helmholtzCoefficients.idealSinh, 1);

  final constant Real[nLog, 2] l=helmholtzCoefficients.idealLog;
  final constant Real[nPower, 2] p=helmholtzCoefficients.idealPower;
  final constant Real[nEinstein, 2] e=helmholtzCoefficients.idealEinstein;
  final constant Real[nCosh, 2] c=helmholtzCoefficients.idealCosh;
  final constant Real[nSinh, 2] s=helmholtzCoefficients.idealSinh;

algorithm
  if (delta>0) and (tau>0) then
    f_ideal :=
      log(delta)
      + sum(l[i,1]*log(tau^l[i,2]) for i in 1:nLog)
      + sum(p[i,1]*tau^p[i,2] for i in 1:nPower)
      + sum(e[i,1]*log(1 - exp(e[i,2]*tau)) for i in 1:nEinstein)
      - sum(c[i,1]*log(abs(cosh(c[i,2]*tau))) for i in 1:nCosh)
      + sum(s[i,1]*log(abs(sinh(s[i,2]*tau))) for i in 1:nSinh);
  else
    f_ideal := -Modelica.Constants.inf;
  end if;
end f_i;
