% Factorial function
% 0! = 1
% n! = n * (n-1)! when n>0

declare
fun {Fact1 N}
   if (N==0) then 1
   else N*{Fact1 N-1} end
end

{Browse {Fact1 3}}

% Principle of communicating vases
% n! = i! * a
%    = i * (i-1)! * a
%    = (i-1)! * (i*a)
% We have: i'=1-1 and a'=i*a

declare
fun {Fact2 I A}
   if I==0 then A
   else {Fact2 I-1 I*A} end
end

{Browse {Fact2 3 1}}

% Sum exeercise
declare
fun {MainSum N}
   local Sum in
      fun {Sum N Acc}
	 if N==0 then Acc
	 else {Sum N-1  Acc+N*N} end
      end
      {Sum N 0}
   end
end

{Browse {MainSum 6}}


