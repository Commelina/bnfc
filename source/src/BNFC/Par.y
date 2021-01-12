-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module BNFC.Par
  ( happyError
  , myLexer
  , pGrammar
  , pListDef
  , pDef
  , pItem
  , pListItem
  , pCat
  , pListCat
  , pLabel
  , pArg
  , pListArg
  , pSeparation
  , pListString
  , pExp
  , pExp1
  , pExp2
  , pListExp
  , pListExp2
  , pRHS
  , pListRHS
  , pMinimumSize
  , pReg
  , pReg1
  , pReg2
  , pReg3
  ) where
import qualified BNFC.Abs
import BNFC.Lex
}

%name pGrammar Grammar
%name pListDef ListDef
%name pDef Def
%name pItem Item
%name pListItem ListItem
%name pCat Cat
%name pListCat ListCat
%name pLabel Label
%name pArg Arg
%name pListArg ListArg
%name pSeparation Separation
%name pListString ListString
%name pExp Exp
%name pExp1 Exp1
%name pExp2 Exp2
%name pListExp ListExp
%name pListExp2 ListExp2
%name pRHS RHS
%name pListRHS ListRHS
%name pMinimumSize MinimumSize
%name pReg Reg
%name pReg1 Reg1
%name pReg2 Reg2
%name pReg3 Reg3
-- no lexer declaration
%monad { Either String } { (>>=) } { return }
%tokentype {Token}
%token
  '(' { PT _ (TS _ 1) }
  ')' { PT _ (TS _ 2) }
  '*' { PT _ (TS _ 3) }
  '+' { PT _ (TS _ 4) }
  ',' { PT _ (TS _ 5) }
  '-' { PT _ (TS _ 6) }
  '.' { PT _ (TS _ 7) }
  ':' { PT _ (TS _ 8) }
  '::=' { PT _ (TS _ 9) }
  ';' { PT _ (TS _ 10) }
  '=' { PT _ (TS _ 11) }
  '?' { PT _ (TS _ 12) }
  '[' { PT _ (TS _ 13) }
  ']' { PT _ (TS _ 14) }
  '_' { PT _ (TS _ 15) }
  'char' { PT _ (TS _ 16) }
  'coercions' { PT _ (TS _ 17) }
  'comment' { PT _ (TS _ 18) }
  'define' { PT _ (TS _ 19) }
  'delimiters' { PT _ (TS _ 20) }
  'digit' { PT _ (TS _ 21) }
  'entrypoints' { PT _ (TS _ 22) }
  'eps' { PT _ (TS _ 23) }
  'internal' { PT _ (TS _ 24) }
  'layout' { PT _ (TS _ 25) }
  'letter' { PT _ (TS _ 26) }
  'lower' { PT _ (TS _ 27) }
  'nonempty' { PT _ (TS _ 28) }
  'position' { PT _ (TS _ 29) }
  'rules' { PT _ (TS _ 30) }
  'separator' { PT _ (TS _ 31) }
  'stop' { PT _ (TS _ 32) }
  'terminator' { PT _ (TS _ 33) }
  'token' { PT _ (TS _ 34) }
  'toplevel' { PT _ (TS _ 35) }
  'upper' { PT _ (TS _ 36) }
  '{' { PT _ (TS _ 37) }
  '|' { PT _ (TS _ 38) }
  '}' { PT _ (TS _ 39) }
  L_charac { PT _ (TC $$) }
  L_doubl  { PT _ (TD $$) }
  L_integ  { PT _ (TI $$) }
  L_quoted { PT _ (TL $$) }
  L_Identifier { PT _ (T_Identifier _) }

%%

Char    :: { Char }
Char     : L_charac { (read ($1)) :: Char }

Double  :: { Double }
Double   : L_doubl  { (read ($1)) :: Double }

Integer :: { Integer }
Integer  : L_integ  { (read ($1)) :: Integer }

String  :: { String }
String   : L_quoted { $1 }

Identifier :: { BNFC.Abs.Identifier}
Identifier  : L_Identifier { BNFC.Abs.Identifier (mkPosToken $1) }

Grammar :: { BNFC.Abs.Grammar }
Grammar : ListDef { BNFC.Abs.Grammar $1 }

ListDef :: { [BNFC.Abs.Def] }
ListDef : {- empty -} { [] }
        | Def { (:[]) $1 }
        | Def ';' ListDef { (:) $1 $3 }
        | ';' ListDef { $2 }

Def :: { BNFC.Abs.Def }
Def : Label '.' Cat '::=' ListItem { BNFC.Abs.Rule $1 $3 $5 }
    | 'comment' String { BNFC.Abs.Comment $2 }
    | 'comment' String String { BNFC.Abs.Comments $2 $3 }
    | 'internal' Label '.' Cat '::=' ListItem { BNFC.Abs.Internal $2 $4 $6 }
    | 'token' Identifier Reg { BNFC.Abs.Token $2 $3 }
    | 'position' 'token' Identifier Reg { BNFC.Abs.PosToken $3 $4 }
    | 'entrypoints' ListCat { BNFC.Abs.Entryp $2 }
    | 'separator' MinimumSize Cat String { BNFC.Abs.Separator $2 $3 $4 }
    | 'terminator' MinimumSize Cat String { BNFC.Abs.Terminator $2 $3 $4 }
    | 'delimiters' Cat String String Separation MinimumSize { BNFC.Abs.Delimiters $2 $3 $4 $5 $6 }
    | 'coercions' Identifier Integer { BNFC.Abs.Coercions $2 $3 }
    | 'rules' Identifier '::=' ListRHS { BNFC.Abs.Rules $2 $4 }
    | 'define' Identifier ListArg '=' Exp { BNFC.Abs.Function $2 $3 $5 }
    | 'layout' ListString { BNFC.Abs.Layout $2 }
    | 'layout' 'stop' ListString { BNFC.Abs.LayoutStop $3 }
    | 'layout' 'toplevel' { BNFC.Abs.LayoutTop }

Item :: { BNFC.Abs.Item }
Item : String { BNFC.Abs.Terminal $1 }
     | Cat { BNFC.Abs.NTerminal $1 }

ListItem :: { [BNFC.Abs.Item] }
ListItem : {- empty -} { [] } | Item ListItem { (:) $1 $2 }

Cat :: { BNFC.Abs.Cat }
Cat : '[' Cat ']' { BNFC.Abs.ListCat $2 }
    | Identifier { BNFC.Abs.IdCat $1 }

ListCat :: { [BNFC.Abs.Cat] }
ListCat : {- empty -} { [] }
        | Cat { (:[]) $1 }
        | Cat ',' ListCat { (:) $1 $3 }

Label :: { BNFC.Abs.Label }
Label : Identifier { BNFC.Abs.Id $1 }
      | '_' { BNFC.Abs.Wild }
      | '[' ']' { BNFC.Abs.ListE }
      | '(' ':' ')' { BNFC.Abs.ListCons }
      | '(' ':' '[' ']' ')' { BNFC.Abs.ListOne }

Arg :: { BNFC.Abs.Arg }
Arg : Identifier { BNFC.Abs.Arg $1 }

ListArg :: { [BNFC.Abs.Arg] }
ListArg : {- empty -} { [] } | Arg ListArg { (:) $1 $2 }

Separation :: { BNFC.Abs.Separation }
Separation : {- empty -} { BNFC.Abs.SepNone }
           | 'terminator' String { BNFC.Abs.SepTerm $2 }
           | 'separator' String { BNFC.Abs.SepSepar $2 }

ListString :: { [String] }
ListString : String { (:[]) $1 }
           | String ',' ListString { (:) $1 $3 }

Exp :: { BNFC.Abs.Exp }
Exp : Exp1 ':' Exp { BNFC.Abs.Cons $1 $3 } | Exp1 { $1 }

Exp1 :: { BNFC.Abs.Exp }
Exp1 : Identifier ListExp2 { BNFC.Abs.App $1 $2 } | Exp2 { $1 }

Exp2 :: { BNFC.Abs.Exp }
Exp2 : Identifier { BNFC.Abs.Var $1 }
     | Integer { BNFC.Abs.LitInt $1 }
     | Char { BNFC.Abs.LitChar $1 }
     | String { BNFC.Abs.LitString $1 }
     | Double { BNFC.Abs.LitDouble $1 }
     | '[' ListExp ']' { BNFC.Abs.List $2 }
     | '(' Exp ')' { $2 }

ListExp :: { [BNFC.Abs.Exp] }
ListExp : {- empty -} { [] }
        | Exp { (:[]) $1 }
        | Exp ',' ListExp { (:) $1 $3 }

ListExp2 :: { [BNFC.Abs.Exp] }
ListExp2 : Exp2 { (:[]) $1 } | Exp2 ListExp2 { (:) $1 $2 }

RHS :: { BNFC.Abs.RHS }
RHS : ListItem { BNFC.Abs.RHS $1 }

ListRHS :: { [BNFC.Abs.RHS] }
ListRHS : RHS { (:[]) $1 } | RHS '|' ListRHS { (:) $1 $3 }

MinimumSize :: { BNFC.Abs.MinimumSize }
MinimumSize : 'nonempty' { BNFC.Abs.MNonempty }
            | {- empty -} { BNFC.Abs.MEmpty }

Reg :: { BNFC.Abs.Reg }
Reg : Reg '|' Reg1 { BNFC.Abs.RAlt $1 $3 } | Reg1 { $1 }

Reg1 :: { BNFC.Abs.Reg }
Reg1 : Reg1 '-' Reg2 { BNFC.Abs.RMinus $1 $3 } | Reg2 { $1 }

Reg2 :: { BNFC.Abs.Reg }
Reg2 : Reg2 Reg3 { BNFC.Abs.RSeq $1 $2 } | Reg3 { $1 }

Reg3 :: { BNFC.Abs.Reg }
Reg3 : Reg3 '*' { BNFC.Abs.RStar $1 }
     | Reg3 '+' { BNFC.Abs.RPlus $1 }
     | Reg3 '?' { BNFC.Abs.ROpt $1 }
     | 'eps' { BNFC.Abs.REps }
     | Char { BNFC.Abs.RChar $1 }
     | '[' String ']' { BNFC.Abs.RAlts $2 }
     | '{' String '}' { BNFC.Abs.RSeqs $2 }
     | 'digit' { BNFC.Abs.RDigit }
     | 'letter' { BNFC.Abs.RLetter }
     | 'upper' { BNFC.Abs.RUpper }
     | 'lower' { BNFC.Abs.RLower }
     | 'char' { BNFC.Abs.RAny }
     | '(' Reg ')' { $2 }
{

happyError :: [Token] -> Either String a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer = tokens
}

