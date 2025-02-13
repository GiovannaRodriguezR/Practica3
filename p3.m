% Parámetros del sistema
m1 = 290;   % kg
b1 = 1000;  % Ns/m
m2 = 59;    % kg
k1 = 16182; % N/m
k2 = 19000; % N/m
f = 0;      % N

% Definir la ecuación diferencial
function dxdt = suspension_system(t, x, m1, m2, b1, k1, k2, f, z)
    dxdt = zeros(4,1);
    dxdt(1) = x(3);
    dxdt(2) = x(4);
    dxdt(3) = (1/m1) * (-b1 * (x(3) - x(4)) - k1 * (x(1) - x(2)) + f);
    dxdt(4) = (1/m2) * (b1 * (x(3) - x(4)) + k1 * (x(1) - x(2)) - (k1 + k2) * x(2) + f + k2 * z(t));
end

% Función de entrada z(t)
z1 = @(t) 0.05 * sin(0.5 * pi * t); % Primera simulación
z2 = @(t) 0.05 * sin(2 * pi * t);   % Segunda simulación

% Condiciones iniciales
x0 = [0; 0; 0; 0];

% Tiempo de simulación
tspan = [0 20];

% Resolver usando ODE45 para z1(t)
[t1, x1] = ode45(@(t,x) suspension_system(t, x, m1, m2, b1, k1, k2, f, z1), tspan, x0);

% Resolver usando ODE45 para z2(t)
[t2, x2] = ode45(@(t,x) suspension_system(t, x, m1, m2, b1, k1, k2, f, z2), tspan, x0);

% Graficar resultados
figure;
plot(t1, x1(:,1), 'b', 'LineWidth', 1.5);
hold on;
plot(t1, x1(:,2), 'r', 'LineWidth', 1.5);
plot(t2, x2(:,1), '--b', 'LineWidth', 1.5);
plot(t2, x2(:,2), '--r', 'LineWidth', 1.5);
xlabel('Tiempo (s)');
ylabel('Desplazamiento (m)');
ylim([-0.3 0.5]);
legend('x1 - Carrocería con z1(t)', 'x2 - Rueda con z1(t)', 'x1 - Carrocería con z2(t)', 'x2 - Rueda con z2(t)');
title('Respuesta del sistema de suspensión');
