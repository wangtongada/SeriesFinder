# SeriesFinder
The Series Finder model has two components. First, run learn_lambda.m to learn the pattern-general coefficients lambda, and then
run find.m to grow series from given seeds.

## Learn_lambda.m
Learn_lambda.m finds the optimal lambda. It initializes the model with a randomly generated starting point lambda_init, and uses 
coordinate ascent to gradually improve the objective until it converges. Since this could lead to a local optima, we initialize 
the search with different randomly generated starting points
- trainSeries: a list of series, where trainSeries(t,:) contains the index of crimes in series t
- NtrainSeries: the number of training series
- stepTable: a table that contains results at different lambdas. For example, stepTable(j,r) stores the results when multiply the j-th feature by scales(r)
- Maxlen: the maximum number of crime that can be discovered in a series
- maxIter:maximum number of steps
- Nchain: the number of times the searching is run from with a randomly generated starting point
- scales: the scales that are used to be multiplied with each feature

## find.m
find.m grows series of crimes from seeds provided by users. Every time, the model computes the pattern-crime similarity between the current pattern and all candidate crimes, and choose the one that has the highest similarity, adds it to the pattern and update the pattern-specific coefficients eta accordingly. The series keeps growing until the cohesion drops below certain cuttoff or the size of the series is bigger than the maximum length allowed
- Ncrimes: the number of all crimes from which we want to discover series. 
- Nseries: the number of series we want to discover
- cutoff: the cutoff for cohesion of a series where if the cohesion is below the cutoff, the series stops growing
- Maxlen:the maximum number of crime that can be discovered in a series
