% This code is designed to plot the real and Imaginary part of the WRE for
% even and odd cat states engineered by QFP-GBS

close all
clear all

%% Inputs
alphaList = (0.5:0.005:3);
SpecificAlpha = (0.5:0.25:3);
b =  num2str(SpecificAlpha);
c = cellstr(b);
 dx = [-0.01 0 0.05 0 0 0 0 0 0 0 0];
dxHorz = [0 0 0 0 0 0 0.06 0.06 -0.5 -0.5 -0.5];
dyVert = [0.01 0.01 0.01 0.01 0.01 0.01 -0.005 0 0.02 0.02 0.02 ];
dy = [-0.2 -0.06  -0.06  0.06  0.06  0.06  0.06  0.04  0.04  0.04  -0.06];
rot = [0 0 0 0 0 -25 -10 -35 -35 -35 0];
SpecificAlphaIndx = zeros(1,11);
for ii = 1:length(SpecificAlpha)
    SpecificAlphaIndx(ii) = find(alphaList==SpecificAlpha(ii));
end

%% Retrieve Data

%Target Cat States
CatReMuEven = load('/Users/andrewpizzimenti/Dropbox/nonGaussianity Measures Project/Codes/Paper Data/Data Files/May6_Data/Cat State Data Files/MAT Files/CatReMuEven.mat');
TargetReMuEven = CatReMuEven.CatReEven;
CatImMuEven = load('/Users/andrewpizzimenti/Dropbox/nonGaussianity Measures Project/Codes/Paper Data/Data Files/May6_Data/Cat State Data Files/MAT Files/CatImMuEven.mat');
TargetImMuEven = CatImMuEven.CatImEven;

% Grabing WRE for specific alpha values
SpecificTargetRe = zeros(11,1);
SpecificTargetIm = zeros(11,1);
for ii = 1:length(SpecificAlphaIndx)
    SpecificTargetRe(ii) = TargetReMuEven(SpecificAlphaIndx(ii));
    SpecificTargetIm(ii) = TargetImMuEven(SpecificAlphaIndx(ii));
end

%Circuit Cat States 
CircuitCatReMuEven =load('/Users/andrewpizzimenti/Dropbox/nonGaussianity Measures Project/Codes/Paper Data/Data Files/CircuitCatReMuEven.mat');
CircuitReMuEven = CircuitCatReMuEven.Expression1;
CircuitCatImMuEven =load('/Users/andrewpizzimenti/Dropbox/nonGaussianity Measures Project/Codes/Paper Data/Data Files/CircuitCatImMuEven.mat');
CircuitImMuEven = CircuitCatImMuEven.Expression1;

% Diffrence in WRE
DiffRe = (SpecificTargetRe-CircuitReMuEven);
DiffIm = (SpecificTargetIm+CircuitImMuEven);

%Fidelities
Fid = load('/Users/andrewpizzimenti/Dropbox/nonGaussianity Measures Project/Codes/Paper Data/Data Files/FidOfCat.mat');
F = Fid.Expression1;

%% Plot

figure(1)
hold on
grid on
scatter(SpecificTargetRe,SpecificTargetIm,125, 'filled', 'd', 'MarkerFaceColor', '#4264E3');
scatter(CircuitReMuEven,-1.*CircuitImMuEven,125,'filled', 'MarkerFaceColor','#F58230');
for ii = 1:11
    plot([SpecificTargetRe(ii), CircuitReMuEven(ii)],[SpecificTargetIm(ii), -1.*CircuitImMuEven(ii)], 'Color','k')
end
[~, objh] = legend({'Target','Circuit'}, 'Location', 'Southeast', 'Fontsize', 25); % Instead of "h_legend" use "[~, objh]"
objhl = findobj(objh, 'type', 'patch');
set(objhl, 'Markersize', 20);
xlim([-0.001 1.2])
xticks([0 0.4 0.8 1.2])
yticks([0 0.4 0.8 1.2])
xlabel('Re\mu[W]');
ylabel('Im\mu[W]');
% for ii = 1:length(dx)
%     ht=text(SpecificTargetRe(ii)+dx(ii),SpecificTargetIm(ii)-dy(ii),num2str(SpecificAlpha(ii)), 'FontSize', 20 );
%     set(ht,'Rotation',rot(ii))
% end


figure(2)
hold on;
grid on;
plot(SpecificAlpha,DiffRe, 'LineWidth', 5, 'Color', '#4264E3');
plot(SpecificAlpha,DiffIm, 'LineWidth', 5, 'Color', '#F58230');
scatter(SpecificAlpha,DiffRe, 150,'filled','MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
% for ii = 1:11
%     plot([SpecificAlpha(ii), SpecificAlpha(ii) ],[DiffRe(ii), DiffRe(ii)+dyVert(ii)], 'Color','k', 'LineStyle','--')
% end
[~, objh] = legend({'\DeltaRe\mu[W]','\DeltaIm\mu[W]', 'Fidelity'}, 'Location', 'Northwest', 'Fontsize', 25); % Instead of "h_legend" use "[~, objh]"
objhl = findobj(objh, 'type', 'patch');
set(objhl, 'Markersize', 15);
objhl = findobj(objh, 'type', 'line');
set(objhl, 'Markersize', 100);
% legend('\DeltaRe\mu[W]', '\DeltaIm\mu[W]', 'Fidelity', 'Location', 'Northwest', 'FontSize', 35);
% ax=gca;
% ax.FontSize = 25;
xticks([1 2 3])
ylim([-0.1 0.3])
yticks([-0.1 0 0.1 0.2 0.3 ])
xlabel('\alpha')
ylabel('\Delta \mu[W]');
for ii = 1:11
    ht = text(SpecificAlpha(ii)+dxHorz(ii),DiffRe(ii)+dyVert(ii),num2str(F(ii)), 'FontSize', 25 );
    if ii <= 6
        set(ht,'Rotation',50)
    end
end
