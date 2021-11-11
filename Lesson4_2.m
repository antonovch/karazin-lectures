
load datafiles/lesson4.mat
idx = height == 600 & period < 400;
data = data(:,idx);

phase = unwrap(angle(data),[],1);
eff = abs(data).^2;

order = 1;
phiCoeffs = polyfit_phase(data, wavelength, order);
phiCoeffs(end,:) = mod(phiCoeffs(end,:), 2*pi);

M = 8;
get_opt_dp = @(x) sum(cal_error(phiCoeffs, x, M));

dpmin = min(phiCoeffs(order,:));
dpmax = max(phiCoeffs(order,:));
delta_phi = fminbnd(get_opt_dp, dpmin, dpmax);


[err, patterns] = cal_error(phiCoeffs, delta_phi, M);

%%
[p, ave] = polyfit_phase(data, wavelength, 1);
figure; scatter(p(2,:)/pi,p(1,:)/pi, 48, 'y', "LineWidth", 1.5);
colormap(flipud(hot)); colorbar;
xlabel('\phi_0,[\pi]'); ylabel('\Delta\phi, [\pi]')

hold on
scatter(p(2,patterns)/pi,p(1,patterns)/pi, 48, 'bx', "LineWidth", 1.5);
plot([0 2], [1,1]*delta_phi/pi, 'r-', "LineWidth", 1.5);


function [err, patterns] = cal_error(phi, delta_phi, M)
    [err, patterns] = deal(ones(1, M));
    for idp = 1:M
        dist = sqrt((phi(end-1,:) - delta_phi).^2 + (phi(end,:) - (idp-1/2)*2*pi/M).^2);
        [err(idp), patterns(idp)] = min(dist);
    end
end
        

