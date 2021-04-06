import cpp

from FunctionCall f
where f.getTarget().getName()="strlen"
select f
