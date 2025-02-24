function dx = practicab(t, x, m1, m2, b1, k1, k2, f, z)
    dx = zeros(4,1);
    dx(1) = x(2);
    dx(2) = (-b1 * (x(2) - x(4)) + k1 * (-x(1) + x(3)) + f) / m1;
    dx(3) = x(4);
    dx(4) = (b1 * (x(2) - x(4)) + k1 * x(1) - (k1 + k2) * x(3) - f + k2 * z(t)) / m2;
end

% Parámetros del sistema
m1 = 290; 
b1 = 1000;
m2 = 59;
k1 = 16182;
f = 0;
k2 = 19000;

% Condiciones iniciales
x0 = [0; 0; 0; 0];

% Funciones de entrada
z1 = @(t) 0.05 * sin(0.5 * pi * t); 
z2 = @(t) 0.05 * sin(20 * pi * t);  

% Resolver ODEs (corrigiendo la llamada a z)
[t1, x1] = ode45(@(t,x) practicab(t, x, m1, m2, b1, k1, k2, f, @(t) z1(t)), [0 10], x0);
[t2, x2] = ode45(@(t,x) practicab(t, x, m1, m2, b1, k1, k2, f, @(t) z2(t)), [0 10], x0);

% Gráficas
figure;
subplot(2,1,1);
plot(t1, x1(:,1), 'DisplayName', 'x1');
hold on;
plot(t1, x1(:,3), 'DisplayName', 'x2');
xlabel('Tiempo (s)');
ylabel('Desplazamiento');
legend;
title('Sistema de suspensión - z1(t)');
grid on;

subplot(2,1,2);
plot(t2, x2(:,1), 'DisplayName', 'x1');
hold on;
plot(t2, x2(:,3), 'DisplayName', 'x2');
xlabel('Tiempo (s)');
ylabel('Desplazamiento');
legend;
title('Sistema de suspensión - z2(t)');
grid on;

