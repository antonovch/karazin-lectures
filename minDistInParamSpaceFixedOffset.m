function [patterns, phi_coeffs] = minDistInParamSpaceFixedOffset(data, wavelength, N, order)

    phiCoeffs = polyfit_phase(data, wavelength, order);
    phiCoeffs(end,:) = mod(phiCoeffs(end,:), 2*pi);

    get_opt_dp = @(x) sum(cal_error(phiCoeffs, x, N));

    dpmin = min(phiCoeffs(end-1,:));
    dpmax = max(phiCoeffs(end-1,:));
    delta_phi = fminbnd(get_opt_dp, dpmin, dpmax);


    [~, patterns] = cal_error(phiCoeffs, delta_phi, N);

    phi_coeffs = polyfit_phase(data(:,patterns), wavelength, order);


function [err, patterns] = cal_error(phi, delta_phi, M)
    [err, patterns] = deal(ones(1, M));
    for idp = 1:M
        dist = sqrt((phi(end-1,:) - delta_phi).^2 + (phi(end,:) - (idp-1/2)*2*pi/M).^2);
        [err(idp), patterns(idp)] = min(dist);
    end
end
        
end
