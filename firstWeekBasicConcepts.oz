% Basic programing concepts
% "In functional programming, variables are single
% assignment: a variable can be bound to only
% one value. Any attempt to bind to another value
% is an error".

% error because X as bind with 5 value
local X=5 in
   X=6
   {Browse X}
end

% A Mathematical function is a fixed thing. It
% does not change once defined. Since variables are
% used to define functions, they have the same property

% Advatages:
% Reduces the chance of error.
% "A program that is correct today will still be correct tomorrow"


local X=1 in
   local X=2 in
      local X=3 in
	 {Browse X} % (1) prints 3
      end
   end
   {Browse X} % (2) prints 1
end

local P Q X=1 Y=2 Z=3 in
   fun {P X}
      X*Y+Z
      % 4*2+3 = 11
      % inside a function X as another scope
   end
   fun {Q Z}
      X*Y+Z
      % 1*2+4 = 6
   end
   {Browse {P 4} == 11}
   {Browse {Q 4} == 6}
end

% Functions

declare
fun {Sqr X}
   X*X   
end

{Browse {Sqr 10}}
{Browse {Sqr 11}}
{Browse {Sqr 10.1}}


declare
fun {SumDigits N}
   (N mod 10) + (N div 10) mod 10 +
   (N div 100) mod 10
end

{Browse {SumDigits 999}}
{Browse {SumDigits 888}}

% CalledOnlyOnce
declare
fun {SlowAdd X Y}
   {Delay 1000}
   X + Y
end

% Old
% {Browse {SlowAdd 1000 1} + {SlowAdd 1000 1} +
% {SlowAdd 1000 1}}

% New
local X in
   X = 3 * {SlowAdd 1000 1}
   {Browse X}
end

% One Function  call another function

declare
fun {SumDigits6 N}
   {SumDigits (N div 1000)} +
   {SumDigits (N mod 1000)}
end

{Browse {SumDigits6 314159}}

% Recursion

declare
fun {SumDigitsR N}
   if N==0 then 0
   else
      (N mod 10) +
      {SumDigitsR  (N div 10)}
   end   
end

{Browse {SumDigitsR 314159}}
{Browse {SumDigitsR 3141592653589}}

   