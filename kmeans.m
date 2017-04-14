
% Combine dimensions
X = [x,y,z];

% pick K size
K = 200;

[G,C] = kmeans(X, K, 'distance','sqEuclidean', 'start','sample'); % k-means

% plot in color
clr = lines(K);
figure, hold on
scatter3(X(:,1), X(:,2), X(:,3), 36, clr(G,:), 'Marker','.')
scatter3(C(:,1), C(:,2), C(:,3), 100, clr, 'Marker','o', 'LineWidth',3)
hold off
view(3), axis vis3d, box on, rotate3d on
xlabel('x'), ylabel('y'), zlabel('z')