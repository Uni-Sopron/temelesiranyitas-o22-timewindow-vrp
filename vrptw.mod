param nWH;
set Warehouses := 1..nWH;
set Nodes := Warehouses union {0};
param demand{Warehouses} >=0;

param nTrains;
set Trains := 1..nTrains;

param capacity{Trains} >=0;
param M := 99999;
param distance{Nodes,Nodes} >=0;
param lower{Nodes} >=0;
param upper{Nodes} >=0;
param serving_time{Nodes} >=0;
var takeRoute{Trains, Nodes, Nodes} binary;
var start_service{Trains, Nodes} >=0;


s.t. ServeAllOnlyOnce{w in Warehouses} :
    sum{t in Trains, nn in Nodes: w!=nn} takeRoute[t, w, nn] == 1; 

s.t. LeaveDepot{t in Trains} :
    sum{ww in Warehouses} takeRoute[t,0,ww] <= 1;

s.t. ArriveAtDepot{t in Trains} : 
    sum{w in Warehouses} takeRoute[t,w,0] <= 1;

s.t. EnsureFlow{n in Nodes, t in Trains}: 
    sum{nn in Nodes:n!=nn} takeRoute[t, n,nn] - sum{nn in Nodes:nn !=n} takeRoute[t, nn, n] == 0;

s.t. CapacityConstraint{t in Trains} :
    sum{w in Warehouses, n in Nodes: w!=n} takeRoute[t, w, n] * demand[w] <= capacity[t];

s.t. CalcElapsedTimeWHenRouteTaken{t in Trains, w in Warehouses, ww in Warehouses: w!=ww} :
    start_service[t,w] + serving_time[w] + distance[w, ww] - start_service[t,ww] <= (1 - takeRoute[t,w,ww]) * M ;

s.t. TimeWindows{t in Trains, n in Nodes} :
      lower[n] <= start_service[t,n] <= upper[n]; 

minimize Distance:
    sum{t in Trains, n in Nodes, nn in Nodes: nn != n} distance[n, nn] * takeRoute[t, n, nn];

solve;

printf 'Szallitasi ido: %d perc \n' , Distance ;

end;