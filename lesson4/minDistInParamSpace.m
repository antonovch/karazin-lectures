function [patterns, phi_coeffs] = minDistInParamSpace(data, wavelength, N, order)

    phiCoeffs = polyfit_phase(data, wavelength, order);
    phiCoeffs(end,:) = mod(phiCoeffs(end,:), 2*pi);

    get_opt_dp = @(x) sum(cal_error(phiCoeffs, x, N));

    delta_phi_start = mean(phiCoeffs(end-1,:));
    delta_phi = fminsearch(get_opt_dp, [delta_phi_start, pi/N]);

    [~, patterns] = cal_error(phiCoeffs, delta_phi, N);

    phi_coeffs = polyfit_phase(data(:,patterns), wavelength, order);

function [err, patterns] = cal_error(phi, x, M)
    [err, patterns] = deal(ones(1, M));
    for idp = 1:M
        dist = sqrt((phi(end-1,:) - x(1)).^2 + (phi(end,:) - (idp-1)*2*pi/M - x(2)).^2);
        [err(idp), patterns(idp)] = min(dist);
    end
end

end
        

