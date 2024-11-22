function [c0] = spectral_unmixing_1D(p0_ROI, Fluence, Epi)
% 
% function [c0] = spectral_unmixing_1D(p0_ROI, Fluence, Epi)
% 
% The objective of this function is to run a simple 1D linear regression.
% The linear regression ussed the PA equation described in Luke 2015 and is
% represented by the following equation, 
% 
%   p0(r,lambda) = Gunessian * Fluence(r,lambda) * Epi(lambda) * c0(r). 
% 
% The function requires the wavelength specific PA pixels and the fluence of
% the image. This fluence can either be a single scalar value or vector of
% multiple values. 
% 
% INPUTS:
%   p0_ROI - vector of PA pixel intensities (units: Pa - J/cm^3)
%   Fluence - vector of fluence values (units: J/cm^2)
%   Epi - extinction coeff (units: cm^-1/M)
%       columns - desired species 
%       rows - Measured/simulated wavelengths
% 
% OUTPUTS:
%   c0 - vector of concentration maps for number of species specified (units: M)

% keyboard
% ========= Check Input values ==================
p0_size = size(p0_ROI); 
phi_size = size(Fluence); 
epi_size = size(Epi); 

numLams = length(p0_ROI); 

if epi_size(1) ~= numLams 
    error('Number of rows in Epi must be equal to number of wavelengths'); 
elseif p0_size(2) ~= 1 
    error('p0 must be a row vector'); 
end 

for c = 1:numLams 
    p0(c,1) = p0_ROI(c)/Fluence(c); 
end

c0 = Epi\p0;

