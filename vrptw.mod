param nWH;
set Warehouses := 1..nWH;
set Nodes := Warehouses union {0};
param Demand{Warehouses} >=0;

param nTrains;
set Trains := 1..nTrains;

param Capacity{Trains} >=0;
param Distance{Nodes,Nodes} >=0;
param Lower{Nodes} >=0;
param Upper{Nodes} >=0;
param ServingTime{Nodes} >=0;
param M := sum{n in Nodes, nn in Nodes} Distance[n, nn];

var TakeRoute{Trains, Nodes, Nodes} binary;
var StartService{Trains, Nodes} >=0;

s.t. ServeAllOnlyOnce2{w in Warehouses} :
    sum{t in Trains, nn in Nodes: w!=nn} TakeRoute[t, nn, w] == 1; 

s.t. LeaveDepot{t in Trains} :
    sum{ww in Warehouses} TakeRoute[t,0,ww] == 1;

s.t. ArriveAtDepot{t in Trains} : 
    sum{w in Warehouses} TakeRoute[t,w,0] == 1;

s.t. EnsureFlow{n in Nodes, t in Trains}: 
    sum{nn in Nodes:n!=nn} TakeRoute[t, n,nn] - sum{nn in Nodes:nn !=n} TakeRoute[t, nn, n] == 0;

s.t. CapacityConstraint{t in Trains} :
    sum{w in Warehouses, n in Nodes: w!=n} TakeRoute[t, w, n] * Demand[w] <= Capacity[t];

s.t. CalcElapsedTimeWhenRouteTaken{t in Trains, w in Warehouses, ww in Warehouses: w!=ww} :
    StartService[t,w] + ServingTime[w] + Distance[w, ww] - StartService[t,ww] <= (1 - TakeRoute[t,w,ww]) * M ;

s.t. TimeWindows{t in Trains, n in Nodes} :
      Lower[n] <= StartService[t,n] <= Upper[n]; 

minimize Time:
    sum{t in Trains, n in Nodes, nn in Nodes: nn != n} Distance[n, nn] * TakeRoute[t, n, nn];

solve;

printf 'Szallitasi ido: %d perc \n', Time;

for{t in Trains}
{
    printf '%d. Tehervonat \n', t;
    printf '----------- \n';

    printf 'Utvonalak: \n';
    for{i in 0..card(Warehouses)}
    {
        for{j in 0..card(Warehouses): TakeRoute[t, i, j]} {
            printf  '%d -> %d \n', i, j ;
        }
    }
   printf 'Kiszolgalva\n\n';
}

end;