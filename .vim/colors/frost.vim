set background=dark
highlight clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "frost"

" Vim interface
hi ColorColumn              ctermbg=232
hi CursorLine   ctermbg=0                cterm=none
hi Directory    ctermfg=36
hi LineNr       ctermfg=234 ctermbg=232
hi MatchParen               ctermbg=23
hi ModeMsg      ctermfg=234
hi MoreMsg      ctermfg=81
hi NonText      ctermfg=234
hi Question     ctermfg=81
hi Search       ctermfg=136 ctermbg=none cterm=underline
hi SpecialKey   ctermfg=81
hi StatusLine   ctermfg=238 ctermbg=234
hi StatusLineNC ctermfg=234 ctermbg=238
hi Title        ctermfg=81
hi VertSplit    ctermfg=234 ctermbg=234
hi WildMenu                 ctermbg=81

" Red error
hi Error        ctermfg=9   ctermbg=52
hi ErrorMsg     ctermfg=9   ctermbg=52

" Miscellaneous
hi Comment      ctermfg=240
hi Todo         ctermfg=201 ctermbg=54

" Normal text color
hi cssAuralAttr            ctermfg=250
hi cssBoxAttr              ctermfg=250
hi cssColorAttr            ctermfg=250
hi cssCommonAttr           ctermfg=250
hi cssFontAttr             ctermfg=250
hi cssGeneratedContentAttr ctermfg=250
hi cssPagingAttr           ctermfg=250
hi cssRenderAttr           ctermfg=250
hi cssTableAttr            ctermfg=250
hi cssTextAttr             ctermfg=250
hi cssUIAttr               ctermfg=250
hi Normal                  ctermfg=250
hi phpClasses              ctermfg=250
hi Special                 ctermfg=250

" Dark blue
hi cssFunctionName    ctermfg=27
hi Entity             ctermfg=27
hi htmlEndTag         ctermfg=27
hi htmlTag            ctermfg=27
hi javaScriptOpAssign ctermfg=27
hi Operator           ctermfg=27
hi phpComparison      ctermfg=27
hi phpMemberSelector  ctermfg=27

" Medium blue
hi cssTagName         ctermfg=39
hi htmlSpecialTagName ctermfg=39
hi htmlStatement      ctermfg=39
hi htmlTagN           ctermfg=39
hi Identifier         ctermfg=39 cterm=none
hi javaScriptGlobal   ctermfg=39
hi phpStorageClass    ctermfg=39
hi phpStructure       ctermfg=39
hi PreProc            ctermfg=39
hi Variable           ctermfg=39

" Light blue
hi Constant      ctermfg=117
hi String        ctermfg=117
hi Regexp        ctermfg=117
hi cssIdentifier ctermfg=117

" Dark green

" Medium green
hi cssClassName       ctermfg=41
hi htmlArg            ctermfg=41
hi htmlArg            ctermfg=41
hi javaScriptFuncName ctermfg=41
hi Statement          ctermfg=41

" Light green
hi javaScriptType ctermfg=121
hi Type           ctermfg=121

" Medium orange
hi WarningMsg   ctermfg=202

" Light orange
hi cssBraces        ctermfg=215
hi cssImportant     ctermfg=215
hi Delimiter        ctermfg=215
hi javaScriptBraces ctermfg=215
hi javaScriptParens ctermfg=215
hi phpParent        ctermfg=215

" Purple
hi Visual ctermbg=55
