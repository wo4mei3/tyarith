# tyarith
This prolog program runs the simply typed lambda calculus named tyarith which is introduced in TaPL in the big-step way.

# Usage
```
$ swipl tyarith.pl
Welcome to SWI-Prolog (threaded, 64 bits, version 8.4.2)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit https://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- run(app(lambda(x,tynat,var(x)),succ(zero)),V,T).
V = succ(0),
T = tynat .

```

# Special Thanks
The program is inspired by https://github.com/mitsuchi/copl-in-prolog 
