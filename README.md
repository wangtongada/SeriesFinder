# SeriesFinder
The Series Finder model has two components. First, run learn_lambda.m to learn the pattern-general coefficients lambda, and then
run find.m to grow series from given seeds.

## Learn_lambda.m
Learn_lambda.m finds the optimal lambda. It initializes the model with a randomly generated starting point lambda_init, and uses 
coordinate ascent to gradually improve the objective until it converges. Since this could lead to a local optima, we initialize 
the search with different randomly generated starting points
- trainSeries: a list of series, where trainSeries(t,:) contains the index of crimes in series t
- gtable: a table that contains the result at each step
