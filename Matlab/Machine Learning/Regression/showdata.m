## (C) 2022-2023 Pablo Alvarado
## EL5857 Aprendizaje automático
## Tarea 2

## Example for creating and showing the sensor raw data

## Use for the experiments just 0,5% of the total available data.
[X,z] = gendata(0.005);

plot3(X(:,1),X(:,2),z(:),".");
xlabel("x")
ylabel("y")
zlabel("z")
set(gca, 'cameraviewanglemode', 'manual')

