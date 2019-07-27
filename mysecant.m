function [X,r,neval] = mysecant(a,b,fname,tol,nmax)
%
% Finds the root r of the equation f(x)=0, using the secant method.
% Input
% a & b endpoints of the interval that brackets the root r
% fname handle of the function f(x) whose zero is being computed
% tol tolerance used to terminate the iterations whenever the
% distance between two successive iterates is less than tol
% Output
% X the successive iterates generated by the method
% r approximate value of the root.
% neval number of function evaluations.
% Call [X,r,neval] = mysecant(1.5,3.0,@myf,10^(-5),50)
% Here myf is the MATLAB name of the function f(x)
% Check if the interval [a,b] brackets the root
xa = a; fxa = fname(xa); xb = b; fxb = fname(xb);
if fxa*fxb > 0
disp('original interval does not bracket the root'), return
end
% Define the tolerance and the maximum number of iterations
if nargin == 3, tol = 0; nmax = 50;
elseif nargin == 4, nmax = 50; end
delta=tol+eps*max(abs(xa),abs(xb));
% initialize the number of evaluation, X and the relative error R
N = 2; X = [xa; xb]; R = 1;
% set p=0 if print out of X, R and f is not wanted
p = 1;
if p==1
disp(' x rel. error f(x) ')
disp('=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=')
disp(sprintf('%18.16f %4.3e %4.3e',xa,R,abs(fxa)))
disp(sprintf('%18.16f %4.3e %4.3e',xb,R,abs(fxb)))
end
% define the distance between two successive iterates
deltax=abs(xb-xa);
%%%
while (deltax>delta) && (N<nmax)
% find the x-intersect of the secant line
ratio = fxa/((fxb-fxa)/(xb-xa)); xi = xa-ratio;
% reset xa, xb, fxa, fxb
xa=xb; fxa=fxb; xb=xi; fxb=fname(xb);
% update neval, X and deltax
N = N+1; X=[X; xi]; deltax=abs(xb-xa);
% compute the relative error
if xb ~= 0 
    R = abs( (xb-xa)/xb ); 
else R = 1; 
end
if p==1
    disp(sprintf('%18.16f %4.3e %4.3e',xb,R,abs(fxb))) 
end
end
%%%
% determine whether there was convergence or not
if deltax <= delta, status = 1;
else status = -1;
disp(' ==- max. number iterations reached and no conv. -== ')
end
% take the last iterate as an approximation of the root
r = xb;
% define the total number of iterations
neval = N;