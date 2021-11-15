function [I, phi_coeffs] = equalDispersionSubset(data, wavelength, method, N)
%equalDispersionSubset selects devices with most similar phase dispersion
% and different phase offsets out of the dataset `data`.
% Input arguments:
%   • data - matrix of complex transmitted amplitudes values of size [number
%   of wavlengths x number of patterns];
%   • method - name of the algorithm to use (see below);
%   • N - number of patterns in the subset to find. Optional. Default: 8.
% Optput arguments:
%   • I - vector of length N storing the numerical indicies of the patterns  
%   (second dimension of data) in the optimal subset;
%   • phi_coeffs - matrix of size [order+1 x N], where `order` is the order 
%   of the fit (either 1 or 2), keeping the finite differences of second 
%   (for order == 2), first and zeroth order coefficients (Matlab's sorting) 
%   of the corresponding pattern in the subset given by I.
%
% The following algorithms are available (as indicated by their `method`
% values):
%   • 'minDistFixed1Ord' - calls minDistInParamSpaceFixedOffset...
%   • 'minDist1Ord' - calls minDistInParamSpace...
%   • 'minErrorPhase' - ...
%   • ... TO DO DOCUMENTATION ... 

    if nargin < 3, N = 8; end
    
    switch method
        case 'minDistFixed1Ord'
            [I, phi_coeffs] = minDistInParamSpaceFixedOffset(data, wavelength, N, 1);
        case 'minDist1Ord'
            [I, phi_coeffs] = minDistInParamSpace(data, wavelength, N, 1);
        case 'minErrorPhase'
            [I, phi_coeffs] = minErrorInPhase(data, wavelength, N, 2);
        case 4
            % TO DO CODE ...
    end

end