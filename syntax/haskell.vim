" syntax highlighting for haskell
"
" Heavily modified version of the haskell syntax
" highlighter to support haskell.
"
" original author: raichoo (raichoo@googlemail.com)
" modified by: Adam R. Nelson (adam@sector91.com)

if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

syn match haskellRecordField "[_a-z][a-zA-Z0-9_']*\s*\(::\|∷\)" contains=haskellIdentifier,haskellOperators,haskellKeyOperators contained
syn match haskellTopLevelDecl "^\s*\(where\s\+\|let\s\+\|default\s\+\)\?[_a-z][a-zA-Z0-9_']*\(,\s*[_a-z][a-zA-Z0-9_']*\)*\(\s*\(::\|∷\)\|\n\s\+\(::\|∷\)\)" contains=haskellIdentifier,haskellOperators,haskellKeyOperators,haskellDelimiter,haskellWhere,haskellLet,haskellDefault
syn keyword haskellBlockKeywords data type family module where class instance deriving contained
if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
  syn region haskellModuleBlock start="\<module\>" end="\<where\>"
    \ contains=haskellType,haskellDelimiter,haskellDot,haskellOperators,haskellKeyOperators,haskellModule,haskellBlockKeywords,haskellLineComment,haskellBlockComment,haskellPragma,haskellPreProc,haskellPatternKeyword keepend
else
  syn region haskellModuleBlock start="\<module\>" end="\<where\>"
    \ contains=haskellType,haskellDelimiter,haskellDot,haskellOperators,haskellKeyOperators,haskellModule,haskellBlockKeywords,haskellLineComment,haskellBlockComment,haskellPragma,haskellPreProc keepend
endif
syn region haskellBlock start="\<\(class\|instance\)\>" end="\(\<where\>\|^\s*$\)"
  \ contains=haskellType,haskellDelimiter,haskellDot,haskellOperators,haskellKeyOperators,haskellModule,haskellBlockKeywords,haskellLineComment,haskellBlockComment,haskellPragma keepend
syn region haskellDataBlock start="\<\(data\|type\)\>\(\s\+\<family\>\)\?" end="\([=]\|\<where\>\|^\s*$\)" keepend
  \ contains=haskellType,haskellDelimiter,haskellDot,haskellOperators,haskellKeyOperators,haskellModule,haskellBlockKeywords,haskellLineComment,haskellBlockComment,haskellPragma keepend
syn keyword haskellStandaloneDerivingKeywords deriving instance contained
syn keyword haskellStructure newtype deriving
syn keyword haskellDefault default
syn region haskellStandaloneDeriving start="\<deriving\>\s\+\<instance\>" end="$"
  \ contains=haskellType,haskellDelimiter,haskellDot,haskellOperators,haskellKeyOperators,haskellStandaloneDerivingKeywords
syn keyword haskellImportKeywords import qualified safe as hiding contained
syn keyword haskellForeignKeywords foreign export import ccall safe unsafe interruptible capi prim contained
syn region haskellForeignImport start="\<foreign\>" contains=haskellString,haskellOperators,haskellKeyOperators,haskellForeignKeywords,haskellIdentifier end="::\|∷" keepend
syn region haskellImport start="\<import\>" contains=haskellDelimiter,haskellType,haskellDot,haskellImportKeywords,haskellString end="\((\|$\)" keepend
syn keyword haskellStatement do case of in
syn keyword haskellWhere where
syn keyword haskellLet let
if exists('g:haskell_enable_static_pointers') && g:haskell_enable_static_pointers == 1
  syn keyword haskellStatic static
endif
syn keyword haskellConditional if then else
syn match haskellNumber "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>\|\<0[bB][10]\+\>"
syn match haskellFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
syn match haskellDelimiter  "(\|)\|\[\|\]\|,\|;\|{\|}"
syn keyword haskellInfix infix infixl infixr
syn keyword haskellBottom undefined error
syn match haskellOperators #\(\(\i\|\s\|['"`,;()\[\]{}]\)\@!.\)\+#
syn match haskellKeyOperators #\(^\|\i\|\s\|['"`,;()\[\]{}]\)\@<=\(|\|=\|::\|=>\|∷\|→\|←\|⇒\)\($\|\i\|\s\|['"`,;()\[\]{}]\)\@=#
syn match haskellKeyOperators #\(^\|\i\|\s\|['"`,;()\[\]{}]\)\@<=->\($\|\i\|\s\|['"`,;()\[\]{}]\)\@=# conceal cchar=→
syn match haskellKeyOperators #\(^\|\i\|\s\|['"`,;()\[\]{}]\)\@<=<-\($\|\i\|\s\|['"`,;()\[\]{}]\)\@=# conceal cchar=←
syn match haskellKeyOperators #\(^\|\i\|\s\|['"`,;()\[\]{}]\)\@<=\\\($\|\i\|\s\|['"`,;()\[\]{}]\)\@=# conceal cchar=λ
syn match haskellKeyOperators "\<_\>"
syn match haskellQuote "\<'\+" contained
syn match haskellQuotedType "\u\(\i\|'\)*\>" contained
syn region haskellQuoted start="\<'\+" end="\s\|$" contains=haskellType,haskellQuote,haskellQuotedType,haskellDelimiter,haskellOperators,haskellKeyOperators,haskellIdentifier
syn match haskellDot "\."
syn match haskellLineComment "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=@Spell
syn match haskellBacktick "`\I\(\i\|'\)*`"
syn region haskellString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
syn region haskellBlockComment start="{-" end="-}" contains=haskellBlockComment,@Spell
syn region haskellPragma start="{-#" end="#-}"
syn match haskellIdentifier "\I\(\i\|'\)*" contained
syn match haskellChar "\<'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'\>"
syn match haskellType "\<\u\(\i\|'\)*\>"
syn region haskellRecordBlock start="\u\(\i\|'\)*\s\+{[^-]" end="[^-]}" keepend
  \ contains=haskellType,haskellDelimiter,haskellOperators,haskellKeyOperators,haskellDot,haskellRecordField,haskellString,haskellChar,haskellFloat,haskellNumber,haskellBacktick,haskellLineComment, haskellBlockComment,haskellPragma,haskellBottom,haskellConditional,haskellStatement,haskellWhere,haskellLet
syn match haskellQuasiQuoteDelimiters "\I\(\i\|'\)*|\||\]" contained
syn region haskellQuasiQuote start="\I\(\i\|'\)*|" end="|\]" contains=haskellQuasiQuoteDelimiters keepend
syn match haskellTHQuasiQuotes "\[||\|||\]\|\[|\||\]\|\[\(d\|t\|p\)|"
syn match haskellPreProc "^#.*$"

if exists('g:haskell_enable_typeroles') && g:haskell_enable_typeroles == 1
  syn keyword haskellTypeRoles type role phantom representational nominal contained
  syn region haskellTypeRoleBlock start="type\s\+role" end="[\n]"
    \ contains=haskellType,haskellTypeRoles keepend
endif
if exists('g:haskell_enable_quantification') && g:haskell_enable_quantification == 1
  syn keyword haskellForall forall contained
  syn match haskellQuantification "\<\(forall\)\>\s\+[^.=]*\."
    \ contains=haskellForall,haskellOperators,haskellKeyOperators,haskellDot,haskellDelimiter
endif
if exists('g:haskell_enable_recursivedo') && g:haskell_enable_recursivedo == 1
  syn keyword haskellRecursiveDo mdo rec
endif
if exists('g:haskell_enable_arrowsyntax') && g:haskell_enable_arrowsyntax == 1
  syn keyword haskellArrowSyntax proc
endif
if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
  syn region haskellPatternSynonyms start="^\s*pattern\s\+[A-Z][A-za-z0-9_]*\s*" end="=\|<-\|←\|$" keepend contains=haskellPatternKeyword,haskellType,haskellOperators,haskellKeyOperators
  syn keyword haskellPatternKeyword pattern contained
endif

highlight def link haskellBottom Macro
highlight def link haskellQuasiQuoteDelimiters Boolean
highlight def link haskellTHQuasiQuotes Boolean
highlight def link haskellBlockKeywords Structure
highlight def link haskellStandaloneDerivingKeywords Structure
highlight def link haskellIdentifier Identifier
highlight def link haskellImportKeywords Structure
highlight def link haskellForeignKeywords Structure
highlight def link haskellStructure Structure
highlight def link haskellStatement Statement
highlight def link haskellWhere Statement
highlight def link haskellLet Statement
highlight def link haskellDefault Statement
highlight def link haskellConditional Conditional
highlight def link haskellNumber Number
highlight def link haskellFloat Float
highlight def link haskellDelimiter Delimiter
highlight def link haskellInfix PreProc
highlight def link haskellKeyOperators Delimiter
highlight def link haskellOperators Operator
highlight def link haskellQuote Operator
highlight def link haskellQuotedType Include
highlight def link haskellDot Operator
highlight def link haskellType Include
highlight def link haskellLineComment Comment
highlight def link haskellBlockComment Comment
highlight def link haskellPragma SpecialComment
highlight def link haskellString String
highlight def link haskellChar String
highlight def link haskellBacktick Operator
highlight def link haskellPreProc Macro
highlight! link Conceal Delimiter
setlocal conceallevel=2

if exists('g:haskell_enable_quantification') && g:haskell_enable_quantification == 1
  highlight def link haskellForall Operator
endif
if exists('g:haskell_enable_recursivedo') && g:haskell_enable_recursivedo == 1
  highlight def link haskellRecursiveDo Operator
endif
if exists('g:haskell_enable_arrowsyntax') && g:haskell_enable_arrowsyntax == 1
  highlight def link haskellArrowSyntax Operator
endif
if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
  highlight def link haskellPatternKeyword Structure
endif
if exists('g:haskell_enable_typeroles') && g:haskell_enable_typeroles == 1
  highlight def link haskellTypeRoles Structure
endif
if exists('g:haskell_enable_static_pointers') && g:haskell_enable_static_pointers == 1
  highlight def link haskellStatic Statement
endif

let b:current_syntax = "haskell"
