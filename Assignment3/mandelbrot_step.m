function [z,kz] = mandelbrot_step(z,kz,z0,d)
% MANDELBROT_STEP  Take a single step of the Mandelbrot iteration.
% [z,kz] = mandelbrot_step(z,kz,z0,d)

%   Copyright 2014 Cleve Moler
%   Copyright 2014 The MathWorks, Inc.
% changed what z will be by making it so that the constant zO changes its
% sign every other calculation. This changes the look of the fractal itself
   z = z.^2 + z0 * (-1)^d;
   j = (abs(z) < 2);
   kz(j) = d;
