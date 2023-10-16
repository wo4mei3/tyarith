typing(_,true,tybool).
typing(_,false,tybool).
typing(G,if(E1,E2,E3),T) :- typing(G,E1,tybool),typing(G,E2,T),typing(G,E3,T).

typing(_,zero,tynat).
typing(G,succ(E),tynat) :- typing(G,E,tynat).
typing(G,pred(E),tynat) :- typing(G,E,tynat).
typing(G,iszero(E),tybool) :- typing(G,E,tynat).

typing(G,var(X),T) :- lookupty(bindty(X,T),G).
typing(G,lambda(X,T1,E),tyfun(T1,T2)) :- typing([bindty(X,T1)|G],E,T2).
typing(G,app(E1,E2),T2) :- typing(G,E1,tyfun(T1,T2)),typing(G,E2,T1).

lookupty(bindty(X,T),[bindty(X1,T1)|_]) :- X = X1, T = T1.
lookupty(bindty(X,T),[bindty(X1,_)|Xs]) :- X \== X1, lookupty(bindty(X,T),Xs).

eval(_,true,true).
eval(_,false,false).
eval(Env,if(E1,E2,_),V) :- eval(Env,E1,true), eval(Env,E2,V).
eval(Env,if(E1,_,E3),V) :- eval(Env,E1,false), eval(Env,E3,V).

eval(_,zero,0).
eval(Env,succ(E),V) :- eval(Env,E,V1), V = succ(V1).
eval(Env,pred(E),0) :- eval(Env,E,0).
eval(Env,pred(E),V) :- eval(Env,E,succ(V)).
eval(Env,iszero(E),true) :- eval(Env,E,0).
eval(Env,iszero(E),false) :- eval(Env,E,succ(_)).

eval(Env,var(X),V) :- lookupval(bindval(X,V),Env).
eval(Env,lambda(X,T1,E),cls(Env,lambda(X,T1,E))).
eval(Env,app(E1,E2),V) :- eval(Env,E1,cls(Env1,lambda(X,_,E))), eval(Env,E2,V1), eval([bindval(X,V1)|Env1],E,V).


lookupval(bindval(X,V),[bindval(X1,V1)|_]) :- X = X1, V = V1.
lookupval(bindval(X,V),[bindval(X1,_)|Xs]) :- X \== X1, lookupty(bindval(X,V),Xs).

run(E,V,T) :- typing([],E,T), eval([],E,V).