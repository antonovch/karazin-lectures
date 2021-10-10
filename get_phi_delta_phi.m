function [phi0,delta_phi,ave] = get_phi_delta_phi(data, wavelength)

    phase = mod(angle(data),2*pi); % same as atan(imag(data)./real(data))
    phase = unwrap(phase,[],1);
    amp = abs(data); % same as sqrt(real(data).^2 + imag(data).^2)
    [~, mid] = min(abs(wavelength - mean(wavelength)));
    phi0 = phase(mid,:);
    delta_phi = diff(phase([end 1],:));
    ave = mean(amp.^2);

end