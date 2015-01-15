% High order programming
% Genericity
% Genericity is when a function is passed as an input

declare
fun {Map F L}
   case L of nil then nil
   [] H|T then {F H}|{Map F T}
   end
end

{Browse {Map fun{$ X}X*X end [7 8 9]}}
{Browse {Map fun{$ Y}Y div 2 end [2 4 6]}}
% Passeed the lamba function fun{$ X}X*X end
% and pass the List [7 8 9]

% Instantiation
% Instantiation is when a function is returned as an input

declare
fun {MakeAdd A}
   fun {$ X} X+A end
end
Add5 = {MakeAdd 5}
{Browse {Add5 100}}

declare
fun {Division A}
   fun {$ X} X div A end
end

Divide6 = {Division 6}
{Browse {Divide6 30}}
{Browse {Divide6 60}}

% Function Composition
% We take two functions as input and return
% their composition

declare
fun {Compose F G}
   fun {$ X} {F {G X}} end
end
Fnew={Compose fun {$ X} X*X end fun {$X} X+1 end}

{Browse {{Compose Fnew Fnew}2}}

% Abstracting an accumulator

declare
fun {FoldL L F U}
   case L
   of nil then U
   [] H|T then {FoldL T F{F U H}}
   end
end
S={FoldL [5 6 7] fun{$ X Y}X+Y end 0}
{Browse S}

% Encapsulation
% We can hide a value inside a function

declare
fun {Zero} 0 end
fun {Inc H}
   N={H}+1 in fun {$}N end
end

Three={Inc {Inc Zero}}
{Browse {Three}}

% Delayed execution
% We can define an statement and pass it to a function
% wich decides whether or not to execute it

declare
proc {IfTrue Cond Stmt}
   if {Cond} then {Stmt} end
end
Stmt = proc {$} {Browse 111*111} end
{IfTrue fun {$} 1<2 end Stmt}