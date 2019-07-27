function plot_newton_poly(n, X, F)
%
% Sketch the graph of Pn(x) and the interpolation points {(xi, f(xi))} for
% 1 <= i <= n+1, and displays both on the same plot.
%
% Inputs   n  The number of points
%          X  The nodes [x1;...;x(n+1)]
%          F  The function values F = [f(x1);...;f(x(n+1))]
%
 a = newton_dd(X, F, n);
 c = -5:0.1:5;
 Y = zeros(101, 1);
 for i = 1:101
    y = Horner_Newton(c(i), a, X, n);
    Y(i) = y;
 end
 scatter(X(1,:),F(1,:))
 hold on
 plot(c, Y)

 
 
