declare
L=[1 2 3]

{Browse L}

declare
M={Append L L}
{Browse M}

declare
N=nil
{Browse N}

{Browse {Append L N}}

% intuitive append

declare
fun {AppendList L1 L2}
   {Append L1 L2}
end

{Browse {AppendList [1 2 3] [3 2 1]}}

% Calculating with lists

% Piece by piece
declare X1 X2 in
X1=6|X2

{Browse X1}

declare X3 in
X2=7|X3
X3=nil

{Browse X1}
% original list 6|7|nil
% syntactic sugar list [6 7]

{Browse [6 7]==6|7|nil} % true

% Built-in functions for lists
{Browse X1} % [6 7]
{Browse X1.1} % Head 6
{Browse X1.2} % Tail [7]
{Browse X1.2.1} % 7

% Recursive function on a list
% Sum of elements
declare
fun {Sum L}
   if L==nil then 0
   else L.1+{Sum L.2} end
end

{Browse {Sum X1}}

% Tail-recursive Sum
declare
fun {Sum2 L A}
   if L==nil then A
   else {Sum2 L.2 L.1+A} end
end

{Browse {Sum2 X1 0}}

% Nth element of a list
declare
fun {Nth L N}
   if N==1 then L.1
   else {Nth L.2 N-1} end
end

{Browse {Nth X1 2}}

% Fact

declare
fun {Fact N}
   local MainFact in
      fun {MainFact Last I LS}
	 if N+1==I then LS
	 else {MainFact Last*I I+1 {Append LS [Last*I]}} end
      end
      {MainFact 1 2 [1]}
   end
end

{Browse {Fact 5}}

% Pattern matching

local Sum Sum2 Sum3 in
   fun {Sum L}
      case L
      of H|T then H+{Sum T}
      [] nil then 0
      end
   end
   {Browse {Sum [5 6 7]}}

   fun {Sum2 L A}
      case L
      of H|T then {Sum2 T H+A}
      [] nil then A
      end
   end
   {Browse {Sum2 [5 6 7] 0}}

   % Pattern engineering
   fun {Sum3 L A}
      case L
      of H1|H2|T then {Sum3 T H1+H2+A}
      [] H|T then {Sum3 T H+A}
      [] nil then A
      end
   end
   {Browse {Sum3 [5 6 7] 0}}
end

declare
proc {TestPattern L}
   case L
   of M then {Browse 1}
   [] H|T then {Browse 2}
   [] nil then {Browse 3}
   end
end

{TestPattern [a b]}

% Specification of Append
% Function append(l1, l2) returns l3
% If l1=[a1,a2,...,an] and l2=[b1,b2,.....,bk]
% then l3=[a1,a2,...,an,b1,b2,....,bk]

declare
fun {Append L1 L2}
   case L1
   of nil then L2
   [] H|T then H|{Append T L2}
   end
end

{Browse {Append [1 2 5] [8 7 6]}}

declare
proc {Append L1 L2 L3}
   case L1 of nil then L3=L2
   else case L1 of H|T then
	   local T3 in
	      L3=H|T3
	      {Append T L2 T3}
	   end
	end
   end
end

local R in{Append [1 2 5] [8 7 6] R}
   {Browse R}
end

% book examples

declare
fun {Length Ls}
   case Ls
   of nil then 0
   [] _|Lr then 1+{Length Lr}
   end
end

{Browse {Length [a b c]}}

declare
fun {Append Ls Ms}
   case Ls
   of nil then Ms
   [] X|Lr then X|{Append Lr Ms}
   end
end

{Browse {Append [1 2 3] [4 5 6]}}

declare
fun {Nth Xs N}
   if N==1 then Xs.1
   elseif N > 1 then {Nth Xs.2 N-1}
   end
end

{Browse {Nth [1 2] 2}}

declare
fun {SumList Xs}
   case Xs
   of nil then 0
   [] X|Xr then X+{SumList Xr}
   end
end

{Browse {SumList [1 2 3]}}


declare
fun {Prefix L1 L2}
   if L1 == nil then true
   else if L2 == nil then false 
	else if L1.1 == L2.1 then {Prefix L1.2 L2.2}
	     else false
	     end
	end
   end
end

% {Browse {Prefix [1 2 3] [1 2 3 4 5]}}

declare
fun {FindString L1 L2}
   if L1 == nil then true
   else
      if L2 == nil then false
      else
	 if {Prefix L1 L2} then true
	 else
	    {FindString L1 L2.2}
	end
      end
   end
end

{Browse {FindString [1 2 3] [4 5 1 2 2 3 4 4]}}

% prefix
% if L1 == nil, it means L1 is end and all numbers are equals
% if L2 == nil, it means L1 is greater than L2 and is diferent
% if L1 head is equals L2 head, it means the numbers are equals
% than prefix with tails are called, and the head of tails
% is evalueted
% if two heads are diferent, so the numbers are diferents then return false

% findString
% findString uses prefix to return if the prefix has here, if the
% the prefix not match, just read the tail of find string and
% look for the prefix again

% flatten

declare
fun {FlattenList L}
   local FlattenMain in
      fun {FlattenMain L L2}
	 if L == nil then L2
	 else
	    if {IsList L.1} then {FlattenMain L.2 {Append L2 L.1}}
	    else {FlattenMain L.2 {Append L.2 L2|L.1}}
	    end
	 end
      end
      if {IsList L.1} then {FlattenMain L.2 L.1}
      else {FlattenMain L.2 [L.1]}
      end
   end
end

{Browse {FlattenList [1[2][2][3[4]]]}}
