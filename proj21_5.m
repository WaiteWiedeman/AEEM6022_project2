clc; clear; close all;
figure;
load('usborder.mat','x','y','xx','yy');
plot(x,y,'Color','red'); hold on;
cities = 50;

pop_size = 100;
num_iter = 1e4;
show_prog = 1;
show_res = 1;
varargout = cell(2,1);

locations = zeros(cities,2);
n = 1;
while (n <= cities)
    xp = rand*1.5;
    yp = rand;
    if inpolygon(xp,yp,xx,yy)
        locations(n,1) = xp;
        locations(n,2) = yp;
        n = n+1;
    end
end
plot(locations(:,1),locations(:,2),'bo');
distances = zeros(cities);
for count1=1:cities
    for count2=1:count1
        x1 = locations(count1,1);
        y1 = locations(count1,2);
        x2 = locations(count2,1);
        y2 = locations(count2,2);
        distances(count1,count2)=sqrt((x1-x2)^2+(y1-y2)^2);
        distances(count2,count1)=distances(count1,count2);
    end
end

fval = runga(locations, distances);

[varargout{:}] = tsp_ga(locations,distances,pop_size,num_iter,show_prog,show_res);

distance = TwoOpt_TSP(locations,distances);