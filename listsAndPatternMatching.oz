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

   % Patterb engineering
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