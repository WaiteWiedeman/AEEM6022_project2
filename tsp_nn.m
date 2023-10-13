function [totalhulldistance, shortestPathLength] = tsp_nn(locations, distances)
distances(distances==0) = inf;
N_cities = size(locations,1);
shortestPathLength = inf;
tStart = tic;
for i = 1:N_cities
    
    startCity = i;

    path = startCity;
    
    distanceTraveled = 0;
    distancesNew = distances;
    
    currentCity = startCity; 
    
    for j = 1:N_cities-1
        
        [minDist,nextCity] = min(distancesNew(:,currentCity));
        if (length(nextCity) > 1)
            nextCity = nextCity(1);
        end
        
        path(end+1,1) = nextCity;
        distanceTraveled = distanceTraveled +...
                    distances(currentCity,nextCity);
        
        distancesNew(currentCity,:) = realmax;
        
        currentCity = nextCity;
        
    end
    
    path(end+1,1) = startCity;
    distanceTraveled = distanceTraveled +...
        distances(currentCity,startCity);
    
    if (distanceTraveled < shortestPathLength)
        shortestPathLength = distanceTraveled;
        shortestPath = path; 
    end 
    
end
tEnd = toc(tStart);
disp(shortestPathLength)
% plot the shortest path
xd=[];yd=[];
for i = 1:(N_cities+1)
    xd(i)=locations(shortestPath(i),1);
    yd(i)=locations(shortestPath(i),2);
end
figure;
load('usborder.mat','x','y','xx','yy');
plot(x,y,'Color','red'); hold on;
plot(locations(:,1),locations(:,2),'o')

line(xd,yd);
title(['Path length = ',num2str(shortestPathLength),' Convergence time = ',num2str(tEnd)]);
hold off;

[k,av] = convhull(locations);
figure;
plot(x,y,'Color','red'); hold on;
plot(locations(:,1),locations(:,2),'o')
plot(locations(k,1),locations(k,2))

totalhulldistance = 0;
for z = 1:length(k)-1
    hulldist = distances(k(z),k(z+1));
    totalhulldistance = totalhulldistance + hulldist;
end

disp(totalhulldistance)
