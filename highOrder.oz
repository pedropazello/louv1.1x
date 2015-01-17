%  ==========================
% || High order programming ||
%  ==========================
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

% =======================
% || Atoms and records ||
% =======================

% An atom is a symbolic value
% A sequence of lowercase letters and digits that starts
% with a letter
% Also, a sequence of any characters delimited by single
% quotes
% Example of list containing five atoms:

declare
L=[john paul george ring '1337 5|*34|<']
{Browse L.1} % john
{Browse L.2.1} % paul
{Browse {Length L}} % 5

% Records
% - A record groups a set of values into a single
% compound value
% A record has a fixed number of values that can be
% acessed directly
% - Each record has a label and a set of pairs of field
% names and fields
% The label ios an atom, the field names are atoms or
% integers and the fields can be any value
% the field names and fields are separated by a colon ':'
% The postion of a field in the record is not important;
% the records point(x:10 y:20) and point(y:20 x:10) are
% identical
% All field names must be different; the syntax
% box(in:deadcat in:livecat) is illegal while
% box(in:cat alive:X) is legal
% - Example record with five fields:

declare
R=rectangle(bottom:10
	    left:20
	    top:100
	    right:200
	    color:red)

% Record fields are accessed through the dot operation
{Browse (R.top-R.bottom)*(R.right-R.left)}
{Browse R.top} % 100

% The label and fields can be extracted directly
{Browse {Label R}} % rectangle
{Browse {Width R}} % 5
{Browse {Arity R}} % [bottom left top right color]

{Browse R==rectangle(bottom:10 left:20 top:100 right:200 color:red)} % true

local Res in
   local Arg1 Arg2 in
      Arg1 = 7
      Arg2 = 6
      Res = Arg1 * Arg2
   end
   {Browse Res}
end

local Res in
   local Arg1 Arg2 in
      Arg1 = 7
      Res = Arg1 * Arg2
      Arg2 = 6
   end
   {Browse Res}
end

