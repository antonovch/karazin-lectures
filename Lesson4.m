%% Step 0: load data
load datafiles/lesson4.mat
idx = height == 600 & period < 400;
data = data(:,idx);

%% Step 1: get phase + unwrap, plus transmission
phase = unwrap(angle(data),[],1);
eff = abs(data).^2;

%% Step 2: get central phase and sort devices, ratining the indicies
wl_central = wavelength == mean(wavelength);
phase  = phase - phase(wl_central,:) + mod(phase(wl_central,:),2*pi);
[ph_central, I] = sort(phase(wl_central,:));

%% Step 3: get phi coefficients 
phiCoeffs = polyfit_phase(data, wavelength, 2);

%% Step 4: make a loop over differeent starting points up to 2*pi/M, define M

M = 8;
subset_best = [];
criterion_best = inf;
count = 1; 
while ph_central(count) < 2*pi/M
    tmp = zeros(1,M);
    tmp(1) = I(count);
    ph0 = ph_central(count) + linspace(0,2*pi,M+1);
    ph0 = ph0(1:M); % ideal phases
    % or ph0 = ph(count) : 2*pi./M : 2*pi;
    err = zeros(1,M);
    % looking for the next element with the same delta_phi and delta2_phi,
    % but with the next offset
    for jj = 2:length(ph0)
        coeffs = [phiCoeffs(1:2,I(count)); ph0(jj)];
%         coeffs = [0; phiCoeffs(1,I(count)); ph0(jj)];
        % transform differences into derivatives
        if all(coeffs(1,:) == 0)
            coeffs = coeffs./[1; wavelength(1) - wavelength(end); 1];
        else
            coeffs = coeffs./[2*(wavelength(1) - mean(wavelength))^2; wavelength(1) - mean(wavelength); 1];
        end 
        % get a curve of target values
        tgt = polyval(coeffs, wavelength-mean(wavelength));
        % find element, whose phase is the closest to this ideal curve
        [err(jj), tmp(jj)] = min(sum(abs(phase-tgt(:)),1));
    end
    ave_eff = mean(eff(:,tmp),1);
%     criterion_current = (1-mean(ave_eff)) * sum(err);
    criterion_current = sum(err);
    if criterion_best > criterion_current
        subset_best = tmp;
        criterion_best = criterion_current;
    end
    count = count + 1;
end

% return subset_best and phiCoeffs(:,subset_best)

%%
[p, ave] = polyfit_phase(data, wavelength, 1);
figure; scatter(p(2,:)/pi,p(1,:)/pi, 48, 'y', "LineWidth", 1.5);
colormap(flipud(hot)); colorbar;
xlabel('\phi_0,[\pi]'); ylabel('\Delta\phi, [\pi]')

hold on
scatter(p(2,subset_best)/pi,p(1,subset_best)/pi, 48, 'bx', "LineWidth", 1.5);
ph0 = phase(wl_central,subset_best(1)) + linspace(0,2*pi,M+1);
ph0 = ph0(1:M);
scatter(ph0/pi,p(1,subset_best(1))*ones(1,M)/pi, 48, 'g+', "LineWidth", 1.5);