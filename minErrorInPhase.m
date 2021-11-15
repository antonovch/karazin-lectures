function [patterns, phi_coeffs] = minErrorInPhase(data, wavelength, N, order)

%% Step 1: get phase + unwrap, plus transmission
phase = unwrap(angle(data),[],1);

%% Step 2: get central phase and sort devices, ratining the indicies
wl_central = wavelength == mean(wavelength);
phase  = phase - phase(wl_central,:) + mod(phase(wl_central,:),2*pi);
[ph_central, I] = sort(phase(wl_central,:));

%% Step 3: get phi coefficients 
phiCoeffs = polyfit_phase(data, wavelength, 2);

%% Step 4: make a loop over differeent starting points up to 2*pi/M, define M

patterns = [];
criterion_best = inf;
count = 1; 
while ph_central(count) < 2*pi/N
    tmp = zeros(1,N);
    tmp(1) = I(count);
    ph0 = ph_central(count) + linspace(0,2*pi,N+1);
    ph0 = ph0(1:N); % ideal phases
    % or ph0 = ph(count) : 2*pi./M : 2*pi;
    err = zeros(1,N);
    % looking for the next element with the same delta_phi and delta2_phi,
    % but with the next offset
    for jj = 2:length(ph0)
        if order == 2
            coeffs = [phiCoeffs(1:2,I(count)); ph0(jj)];
        elseif order == 1
            coeffs = [0; phiCoeffs(1,I(count)); ph0(jj)];
        else
            error('wrong order')
        end
        % transform differences into derivatives
        if order == 1
            coeffs = coeffs./[1; wavelength(1) - wavelength(end); 1];
        else
            coeffs = coeffs./[2*(wavelength(1) - mean(wavelength))^2; wavelength(1) - mean(wavelength); 1];
        end 
        % get a curve of target values
        tgt = polyval(coeffs, wavelength-mean(wavelength));
        % find element, whose phase is the closest to this ideal curve
        [err(jj), tmp(jj)] = min(sum(abs(phase-tgt(:)),1));
    end
    criterion_current = sum(err);
    if criterion_best > criterion_current
        patterns = tmp;
        criterion_best = criterion_current;
    end
    count = count + 1;
end

phi_coeffs = phiCoeffs(:,patterns);
