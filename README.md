# Vasúti teherszállítás

## Feladatleírás
Ez a probléma egy vasúti teherszállítást modellez. 
A modell Oumayma Grine  **egyetemi  jelentésén** alapul. [[1]](#1)
<br>
Áruházláncoknak szállítunk különböző mennyiségben termékeket melyeket 
különböző kapacitással bíró tehervonataink juttatnak el a raktárukba.
A raktárak csak bizonyos időablakokban tudják fogadni a vonatokat és a megérkezés utáni szolgáltatási időket is figyelembe kell venni!
Az, hogy egy pontból egy másikba mennyi idő szállítani adott.

A kérdés az, hogy hogyan ütemezzük a raktárak sorrendjét, úgy hogy mindegyiket kiszolgáljuk időben, a szállítással töltött idő minimalizálásával?

## Tényezők, paraméterek
- Adott számú tehervonattal rendelkezik a vasúti társaságunk, eltérő kapacitással
- Adott a depónk pozíciója
- Adott számú áruházláncok raktáraiba kell eljuttatnunk termékeket, minden áruház más-más követelést támaszt
- Adott az csomópontok (raktárak) közötti távolság percben
- A raktárakat bizonyos időablakokban kell kiszolgálnunk
- A raktárak kiszolgálása időt vesz igénybe
- Fontos, hogy a tehervonataink a depóba érkezzenek vissza

## Döntési változók
- Adott tehervonat megtesz egy utat egy pontból a másikba `var TakeRoute{Trains, Nodes, Nodes} binary;`
- Tehervonat elkezdi a raktár kiszolgálását egy adott percben  `var StartService{Trains, Nodes} >=0;`

## Kimenet
```
Szallitasi ido: 715 perc 
1. Tehervonat 
----------- 
Utvonalak: 
0 -> 2 
2 -> 0 
Kiszolgalva

2. Tehervonat 
----------- 
Utvonalak: 
0 -> 3 
3 -> 5 
5 -> 0 
Kiszolgalva

3. Tehervonat 
----------- 
Utvonalak: 
0 -> 1 
1 -> 4 
4 -> 6 
6 -> 0 
Kiszolgalva
```

## Referenciák
<a id="1">[1]</a>
Grine, O. (n.d.). Vehicle routing problem with time Windows - aui.ma. Retrieved November 8, 2022, from http://www.aui.ma/sse-capstone-repository/pdf/spring-2017/OumaymaGrineVehicleRoutingProblemFinalReport.pdf 
