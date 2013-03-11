:- include('network.pl').

% Goal: infect "feodosia"
goalp(nagatayuji).

% A simple predicate for testing
s(X) :- node(X,_,_), search(X,goalp,expand,'breadth-first',Path), write2(Path).

%s(X) :- search(X,goalp,expand,'breadth-first',Path), write2(Path).

write2([]) :- nl,nl.
write2([Node | R]) :- 
    write(Node),write('('),node(Node,Sec,_),write(Sec),write(') <- '),
    write2(R).

% valid transition: A and B are connected and the security level
% of B is at most one category higher than that of A:

filter_by_security([],[],_).

filter_by_security([Node | Rest1], [Node | Rest2], Security) :-
    node(Node, Sec2, _),
    Sec2 =< Security, !,
    filter_by_security(Rest1, Rest2, Security).

filter_by_security([_ | Rest1], Rest2, Security):-
    filter_by_security(Rest1, Rest2, Security).


expand(Node,Suc) :-
    node(Node,Sec,C),
    Sec2 is Sec + 1,
    filter_by_security(C,Suc,Sec2).