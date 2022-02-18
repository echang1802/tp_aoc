
# Cantidad de periodos
param n := 18;

# Conjunto de periodos
set T := { 1 .. n };

# Conjunto de costos
set C := { read "data/production_costs.dat" as "<1s>" };

# Demanda de cada periodo
param mu[T] := read "data/expected_demand.dat" as "<1n> 2n";

# Costos de produccion
param costs[C] := read "data/production_costs.dat" as "<1s> 2n";

# Variables de produccion
var x[T] >= 0;

# Variables de produccion tercerizada
var y[T] >= 0;

# Funcion objetivo
minimize fobj: sum <t> in T: (costs["own"] * x[t] + costs["outsourced"] * y[t]);

# Produccion maxima
subto max_prod: forall <t> in T:
    x[t] <= 50;

# Produccion maxima tercerizada
subto max_prod_ter: forall <t> in T:
    y[t] <= 200;

# Restriccion de demanda
subto demand: forall <t> in T:
    sum <i> in T with i <= t: (x[i] + y[i] - mu[i]) >= 0;
