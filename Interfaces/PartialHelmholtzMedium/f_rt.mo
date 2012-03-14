within HelmholtzMedia.Interfaces.PartialHelmholtzMedium;
function f_rt "residual part of dimensionless Helmholtz energy"

  input Real delta;
  input Real tau;
  output Real f_residual_tau "residual part of dimensionless Helmholtz energy";

protected
  Integer nPoly = size(helmholtzCoefficients.residualPoly,1);
  Integer nBwr = size(helmholtzCoefficients.residualBwr,1);
  Integer nGauss = size(helmholtzCoefficients.residualGauss,1);

  Real[nPoly,4] p = helmholtzCoefficients.residualPoly;
  Real[nBwr,4] b = helmholtzCoefficients.residualBwr;
  Real[nGauss,12] g = helmholtzCoefficients.residualGauss;

algorithm
  f_residual_tau :=
      sum(p[i,1]*p[i,2]*tau^(p[i,2] - 1)*delta^p[i,3] for i in 1:nPoly)
    + sum(b[i,1]*b[i,2]*tau^(b[i,2] - 1)*delta^b[i,3]*exp(-delta^b[i,4]) for i in 1:nBwr)
    + sum(g[i,1]*tau^g[i,2]*delta^g[i,3]*exp(g[i,6]*(delta - g[i,9])^2 + g[i,7]*(tau - g[i,8])^2)*(g[i,2]/tau + 2*g[i,7]*(tau - g[i,8])) for i in 1:nGauss);

end f_rt;