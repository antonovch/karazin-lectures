function [p, ave] = polyfit_phase(data, wavelength, ord)

    phase = unwrap(angle(data),[],1);
    ave = mean(abs(data).^2);
    dwl = wavelength(1) - wavelength(end);
    p = zeros(ord+1, size(data,2));
    wl0 = mean(wavelength);
    for i = 1:size(data,2)
        p(:,i) = polyfit(wavelength - wl0, phase(:,i), ord);
        % converting from polynomial coeffs to derivatives
        if ord == 1
            p(1,i) = p(1,i)*dwl;
        elseif ord == 2
            p(1,i) = p(1,i)*2*(dwl/2)^2;
            p(2,i) = p(2,i)*(dwl/2);
        else
            error('ord argument values must be 1 or 2')
        end
    end
    p(end,:) = mod(p(end,:),2*pi);
end