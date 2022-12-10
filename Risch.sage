def components(f, x):
    
    result = set()

    if f.has_free(x):
        if f.is_symbol and f.is_commutative:
            result.add(f)
        elif f.is_Function or f.is_Derivative:
            for g in f.args:
                result |= components(g, x)

            result.add(f)
        elif f.is_Pow:
            result |= components(f.base, x)

            if not f.exp.is_Integer:
                if f.exp.is_Rational:
                    result.add(f.base**(1/ f.exp.q))
                else:
                    result |= components(f.exp, x) | {f}
        else:
            for g in f.args:
                result |= components(g, x)

    return result
"""
# name -> [] of symbols
_symbols_cache: dict[str, list[Dummy]] = {}

# NB @cacheit is not convenient here
def _symbols(name, n):
    
    try:
        lsyms = _symbols_cache[name]
    except KeyError:
        lsyms = []
        _symbols_cache[name] = lsyms

    while len(lsyms) < n:
        lsyms.append( Dummy('%s%i' % (name, len(lsyms))) )

    return lsyms[:n]"""

