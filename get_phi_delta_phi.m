function [phi0,delta_phi,ave] = get_phi_delta_phi(data, wavelength)

    phase = unwrap(angle(data),[],1); % angle() is same as atan(imag(data)./real(data))
    amp = abs(data); % same as sqrt(real(data).^2 + imag(data).^2)
    [~, mid] = min(abs(wavelength - mean(wavelength)));
    phi0 = mod(phase(mid,:),2*pi);
    delta_phi = diff(phase([end 1],:));
    ave = mean(amp.^2);

end