%Input Variables:
    % epsr, epsi: real and imaginary parts of  the relative dielectric
    % constants of the medium.
    %f: frequency in Hz

%Output Products:
    % alpha: attenuation coefficient (Np/m)
    % beta: phase coefficient (rad/m)
    % mag_eta: magnitude of intrinsic impedance (Ohm)
    % phase_eta: phase angle of intrinsic impedance (degrees)
%Book Reference: Section 2-4
%MATLAB Code: SingleMedium_PropagConst.m

%Example call: [alpha beta mag_eta phase_eta] = wave_parameters(epsr, epsi, f )


function [alpha beta mag_eta phase_eta] = wave_parameters(epsr, epsi, f )

lmda0   = 3e8 ./f;   % wavelength in free space
alpha   = 2*pi./lmda0 .*( 0.5* epsr* (sqrt(1 + (epsi/epsr).^2) - 1)).^0.5;

beta    = 2*pi./lmda0 .*( 0.5 *epsr* (sqrt(1 + (epsi/epsr).^2) + 1)).^0.5;

eta     = 377 ./sqrt(epsr) .*(1- 1i*epsi./epsr).^(-1/2);
mag_eta = abs(eta);
phase_eta = 180/pi .*atan2(imag(eta), real(eta));

end

