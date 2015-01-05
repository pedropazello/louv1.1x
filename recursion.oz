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

% Sum exercise
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

% Mirror exercise
declare
fun {MainMirror Int}
   local Mirror in
      fun {Mirror Int Acc}
	 if Int==0 then Acc div 10
	 else
	    {Mirror (Int div 10) (Acc+(Int mod 10))*10}
	 end
      end
      {Mirror Int 0}
   end
end

{Browse {MainMirror 12345}}

% Prime exercise

declare
fun {Prime N}
   local Division in
      fun {Division N Acc}
	 if Acc==N then true
	 elseif N mod Acc==0 then false
	 else
	    {Division N Acc+1}
	 end 
      end
      {Division N 2}
   end
end

{Browse {Prime 997}}

% fib exercise

declare
fun {Fib N}
   local FibAux in
      fun {FibAux N Acc1 Acc2}
	 if N==1 then Acc1
	 else
	    {FibAux N-1 Acc1+Acc2 Acc1}
	 end
      end
      {FibAux N 0 1}
   end
end

{Browse {Fib 13}}

