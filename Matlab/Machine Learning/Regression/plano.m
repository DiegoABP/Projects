% Generar datos de muestra
x = randn(100,1);
y = randn(100,1);
z = 2*x - 3*y + 5 + 0.5*randn(100,1); % Ecuación del plano: z = a*x + b*y + c

% Agregar una columna de unos a x e y para incluir el término independiente en la regresión lineal
X = [ones(100,1) x y];

% Resolver el sistema de ecuaciones usando mínimos cuadrados
coeffs = inv(X'*X)*X'*z;

% Imprimir los coeficientes encontrados
fprintf('Coeficientes: a=%.2f, b=%.2f, c=%.2f\n',coeffs(2),coeffs(3),coeffs(1));

% Graficar los datos y el plano encontrado
figure;
scatter3(x,y,z,'filled');
hold on;
[Xp,Yp] = meshgrid(min(x):0.1:max(x),min(y):0.1:max(y));
Zp = coeffs(2)*Xp + coeffs(3)*Yp + coeffs(1);
surf(Xp,Yp,Zp);
xlabel('x');
ylabel('y');
zlabel('z');
