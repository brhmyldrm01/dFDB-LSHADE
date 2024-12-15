function [ fitness ] = testFunction( x, p )

global count;
[~, counter] = size(x);
count = count + counter;
[dimension, pop] = size(x);
fitness = zeros(1, pop);
for i = 1 : pop
   fitness(i) = (1 / problem(p, x(:,i)));  
end

end
