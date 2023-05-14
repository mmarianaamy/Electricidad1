clear;
clc;

syms xs ys

% Pedir al usuario introducir el valor de las cargas
q = input('Introduce el valor de la carga (en microculombios): ') * 10^-6;

% Pedir al usuario introducir las longitudes de los arreglos
L1 = input('Introduce la longitud del arreglo 1: ');
L2 = input('Introduce la longitud del arreglo 2: ');

% Calcular la densidad de carga lineal uniforme para cada arreglo
lambdaL1 = q / L1;
lambdaL2 = -q / L2;

xL1 = -2;
xL2 = 2;

% Definir las constantes de Coulomb 
k = 9e9; % N m^2 / C^2

% Definir el rango de posiciones donde se calculará el campo eléctrico
[x,y] = meshgrid(-5:0.5:5);

% Inicializar las componentes del campo eléctrico
[Ex,Ey] = meshgrid(-5:0.6:5);

% Calcular el campo eléctrico en cada punto del rango
funx(xs, ys) = ys / (xs * sqrt(xs^2 + ys^2));
funy(xs, ys) = -1 / sqrt(xs^2 + ys^2);
for i = 1:length(x)
    for j = 1:length(x)
        try
            Ex(i, j) = k*lambdaL1*(-funx((x(i, j) - xL1), y(i, j) - L1/2) + funx((x(i, j) - xL1), y(i, j) + L1/2));
            Ex(i, j) = Ex(i, j) + k*lambdaL2*(-funx((x(i, j) - xL2), y(i, j) - L2/2) + funx((x(i, j) - xL2), y(i, j) + L2/2));
        catch
            Ex(i, j) = 0;
        end
        try
            Ey(i, j) = k*lambdaL1*(-funy((x(i, j) - xL1), y(i, j) - L1/2) + funy((x(i, j) - xL1), y(i, j) + L1/2));
            Ey(i, j) = Ey(i, j) + k*lambdaL2*(-funy((x(i, j) - xL2), y(i, j) - L2/2) + funy((x(i, j) - xL2), y(i, j) + L2/2));
        catch
            Ey(i, j) = 0;
        end
    end
end
streamslice(x, y, Ex, Ey, 2)
hold on

%Agregar el alambre 
y3=-L1/2;
rectangle('Position',[-2 y3 0.2 L1],'Curvature',0.5,'FaceColor',"g")
hold on

y4=-L2/2;
rectangle('Position',[2 y4 0.2 L2],'Curvature',0.5,'FaceColor',[0 0.4470 0.7410])
hold on