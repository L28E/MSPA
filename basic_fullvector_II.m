addpath("./tools")

% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
%rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

%dx = 0.5;        % grid size (horizontal)
%dy = 0.5;



lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute


rw=linspace(0.325,1,10);
neffs=zeros(1,10);

for n=1:length(rw)

    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                                rh,rw(n),side,dx,dy); 

    % TE modes:

    [Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

    fprintf(1,'rw = %.6f\n',rw(n));

    figure(n);
    subplot(1,2,1);
    contourmode(x,y,Hx);
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    %for v = edges, line(v{:}); end

    subplot(1,2,2);
    contourmode(x,y,Hy);
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    %for v = edges, line(v{:}); end
    
    neffs(n)=neff;
end

figure()
plot(rw,neffs)
title("Ridge Half Width vs. Neff")
xlabel("Ridge Half Width")
ylabel("Neff")

