concrete ConjunctionHun of Conjunction =
  CatHun ** open ResHun, Coordination, Prelude in {

-- Adverb and other simple {s : Str} types.
lincat
  [AdV],[IAdv],[S] = {s1,s2 : Str} ;

lin
  BaseAdV, BaseIAdv, BaseS = twoSS ;
  ConsAdV, ConsIAdv, ConsS = consrSS comma ;
  ConjAdV, ConjIAdv, ConjS = conjunctDistrSS ;

lincat
  [Adv] = {s1,s2 : Str ; isPre : Bool} ;

lin
  BaseAdv x y = y ** twoSS x y ;
  ConsAdv x xs = xs ** consrSS comma x xs ;
  ConjAdv co xs = xs ** conjunctDistrSS co xs ;

-- Adjectival phrases
lincat
  [AP] = {s1,s2 : Number => Case => Str}  ;

lin
  BaseAP x y =
    -- Don't try to have discontinuous comparative forms
    let xCont : AP = x ** {s = \\n,c => x.s ! n ! c ++ x.compar} ;
        yCont : AP = y ** {s = \\n,c => y.s ! n ! c ++ y.compar} ;
     in twoTable2 Number Case xCont yCont ;
  ConsAP a as =
    let aCont : AP = a ** {s = \\n,c => a.s ! n ! c ++ a.compar} ;
     in consrTable2 Number Case comma aCont as ;
  ConjAP co as = conjunctDistrTable2 Number Case co as ** {compar = []} ;

-- Noun phrases
lincat
  [NP] = ResHun.BaseNP ** {s1,s2 : Possessor => Case => Str} ;

lin
  BaseNP x y = twoTable2 Possessor Case x y ** y ;
  ConsNP x xs = xs ** consrTable2 Possessor Case comma x xs ;
  ConjNP co xs = conjunctDistrTable2 Possessor Case co xs ** xs ** {
    agr = <P3, case xs.agr.p2 of {
                  Pl => Pl ;
                  _  => co.n }>
    } ;

-- Relative sentences
lincat
  [RS] = {s1,s2 : Number => Case => Str} ;

lin
  BaseRS = twoTable2 Number Case ;
  ConsRS = consrTable2 Number Case comma ;
  ConjRS = conjunctDistrTable2 Number Case ;

{-
lincat
  [CN] = { } ;

lin
  BaseCN = {} ;
  ConsCN = {} ;
  ConjCN co cs = conjunctDistrTable … co cs ** cs ;

lincat
  [DAP] =

lin
  BaseDAP x y = x **
  ConsDAP xs x = xs **
  ConjDet conj xs = xs **

-}

}
