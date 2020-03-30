concrete VerbHun of Verb = CatHun ** open ResHun, AdverbHun, Prelude in {


lin

-----
-- VP
  -- : V -> VP
  UseV = ResHun.useV ;

  --  : V2 -> VP ; -- be loved
  -- PassV2 = ResHun.passV2 ;

  -- : VPSlash -> VP ;
  -- ReflVP = ResHun.insertRefl ;

  -- : VV  -> VP -> VP ;
  -- ComplVV vv vp = let vc = vp.vComp in case vv.vvtype of {
  --
  --   } ;

  -- : VS  -> S  -> VP ;
  -- ComplVS vs s =
  --   let vps = useV vs ;
  --       subord = SubjS {s=""} s ;
  --    in vps ** {} ;

{-
  -- : VQ -> QS -> VP ;
  ComplVQ vq qs = ;

  -- : VA -> AP -> VP ;  -- they become red
  ComplVA va ap = ResHun.insertObj (CompAP ap).s (useV va) ;

--------
-- Slash
-}
  -- : V2 -> VPSlash
  SlashV2a = ResHun.useVc ;

{-
  -- : V3 -> NP -> VPSlash ; -- give it (to her)
  -- : V3 -> NP -> VPSlash ; -- give (it) to her
  Slash2V3,
  Slash3V3 = \v3 -> insertObj (useVc3 v3) ;

  -- : V2S -> S  -> VPSlash ;  -- answer (to him) that it is good
  SlashV2S v2s s =
    let vps = useVc v2s ;
        subord = SubjS {s=""} s ;
     in vps ** {obj = } ;


  -- : V2V -> VP -> VPSlash ;  -- beg (her) to go
  SlashV2V v2v vp = ;

  -- : V2Q -> QS -> VPSlash ;  -- ask (him) who came
  SlashV2Q v2q qs = ;

  -- : V2A -> AP -> VPSlash ;  -- paint (it) red
  SlashV2A v2a ap = useVc v2a ** {
    aComp = \\_ => (CompAP ap).aComp ! Sg3 Masc
  } ;
-}
  -- : VPSlash -> NP -> VP
  ComplSlash = ResHun.insertObj ;
{-
  -- : VV  -> VPSlash -> VPSlash ;
                  -- Just like ComplVV except missing subject!
  SlashVV vv vps = ComplVV vv vps ** { missing = vps.missing ;
                                       post = vps.post } ;

  -- : V2V -> NP -> VPSlash -> VPSlash ; -- beg me to buy
  SlashV2VNP v2v np vps =
    ComplVV v2v vps **
      { missing = vps.missing ;
        post = vps.post ;
        iobj = np ** { s = np.s ! Dat } } ;

-}

  -- : Comp -> VP ;
  UseComp comp = comp ;


  -- : VP -> Adv -> VP ;  -- sleep here
  AdvVP = insertAdv ;

  -- : VPSlash -> Adv -> VPSlash ;  -- use (it) here
  AdvVPSlash = insertAdvSlash ;
{-
  -- : VP -> Adv -> VP ;  -- sleep , even though ...
  ExtAdvVP vp adv = vp ** { } ;

  -- : AdV -> VP -> VP ;  -- always sleep
  AdVVP adv vp = vp ** { } ;

  -- : AdV -> VPSlash -> VPSlash ;  -- always use (it)
  AdVVPSlash adv vps = vps ** { } ;

  -- : VP -> Prep -> VPSlash ;  -- live in (it)
  VPSlashPrep vp prep =
-}

--2 Complements to copula

-- Adjectival phrases, noun phrases, and adverbs can be used.

  -- : AP  -> Comp ;
  CompAP ap = UseCopula ** {
    s = \\vf => case vf of {
                  VFin P3 n => ap.s ! n ;
                  VFin _  n => ap.s ! n  ++ copula.s ! vf ;
                  _         => ap.s ! Sg ++ copula.s ! vf} ;
    } ;

  -- : CN  -> Comp ;
  CompCN cn = UseCopula ** {
    s = \\vf => case vf of {
                  VFin P3 n => cn.s ! n ! Nom ;
                  VFin _  n => cn.s ! n ! Nom  ++ copula.s ! vf ;
                  _         => cn.s ! Sg ! Nom ++ copula.s ! vf} ;
    } ;

  -- : NP  -> Comp ;
  CompNP np = UseCopula ** {
    s = \\vf => case vf of {
                  VFin P3 _ => np.s ! Nom ;
                  _ => np.s ! Nom ++ copula.s ! vf } ;
    } ;

  -- : Adv  -> Comp ;
  CompAdv adv = UseCopula ** {
    s = \\vf => adv.s ++ copula.s ! vf ;
    } ;

  -- : VP -- Copula alone;
  UseCopula = useV copula ;

}
