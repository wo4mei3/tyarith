typing(_,true,tybool).
typing(_,false,tybool).
typing(G,if(E1,E2,E3),T) :- typing(G,E1,tybool),typing(G,E2,T),typing(G,E3,T).

typing(_,zero,tynat).
typing(G,succ(E),tynat) :- typing(G,E,tynat).
typing(G,pred(E),tynat) :- typing(G,E,tynat).
typing(G,iszero(E),tybool) :- typing(G,E,tynat).

typing(G,var(X),T) :- first(bind(X,T),G).
typing(G,lambda(bind(X,T1),E),tyfun(T1,T2)) :- typing([bind(X,T1)|G],E,T2).
typing(G,app(E1,E2),T2) :- typing(G,E1,tyfun(T1,T2)),typing(G,E2,T1).

first(bind(X,T),[bind(X1,T1)|_]) :- X = X1, T = T1.
first(bind(X,T),[bind(X1,_)|Xs]) :- X \== X1, first(bind(X,T),Xs).