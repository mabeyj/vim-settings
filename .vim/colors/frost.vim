set background=dark
highlight clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "frost"

" Splits
hi ColorColumn              ctermbg=234
hi Folded       ctermfg=242 ctermbg=234
hi FoldColumn   ctermfg=242 ctermbg=234
hi LineNr       ctermfg=238 ctermbg=233
hi StatusLine   ctermfg=238 ctermbg=245
hi StatusLineNC ctermfg=235 ctermbg=242
hi VertSplit    ctermfg=235 ctermbg=235

" Vim interface
hi CursorLine   ctermbg=0                cterm=none
hi Directory    ctermfg=36
hi MatchParen   ctermfg=202 ctermbg=none cterm=bold
hi ModeMsg      ctermfg=238
hi MoreMsg      ctermfg=81
hi NonText      ctermfg=234
hi Question     ctermfg=81
hi Search       ctermfg=136 ctermbg=none cterm=underline
hi SpecialKey   ctermfg=234
hi Title        ctermfg=81
hi Visual                   ctermbg=52
hi WildMenu                 ctermbg=81

" Red error
hi Error        ctermfg=9   ctermbg=52
hi ErrorMsg     ctermfg=9   ctermbg=52

" Miscellaneous
hi Comment        ctermfg=240
hi CommentSummary ctermfg=60
hi CommentProp    ctermfg=23
hi CommentHeading ctermfg=24
hi Todo           ctermfg=201 ctermbg=54

" Normal text color
hi cssAuralAttr            ctermfg=249
hi cssBoxAttr              ctermfg=249
hi cssColorAttr            ctermfg=249
hi cssCommonAttr           ctermfg=249
hi cssFontAttr             ctermfg=249
hi cssGeneratedContentAttr ctermfg=249
hi cssPagingAttr           ctermfg=249
hi cssRenderAttr           ctermfg=249
hi cssTableAttr            ctermfg=249
hi cssTextAttr             ctermfg=249
hi cssUIAttr               ctermfg=249
hi Normal                  ctermfg=249
hi phpClasses              ctermfg=249
hi Special                 ctermfg=249

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

" Bold blue
hi cssClassName       ctermfg=33 cterm=bold
hi htmlArg            ctermfg=33 cterm=bold
hi htmlArg            ctermfg=33 cterm=bold
hi javaScriptFuncName ctermfg=33 cterm=bold
hi Statement          ctermfg=33 cterm=bold

" Light blue
hi Constant      ctermfg=117
hi String        ctermfg=117
hi Regexp        ctermfg=117
hi cssIdentifier ctermfg=117

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

" Diffs
hi DiffAdd     ctermfg=84 ctermbg=22
hi diffAdded   ctermfg=84 ctermbg=22
hi DiffChange  ctermfg=228 ctermbg=58
hi DiffDelete  ctermfg=161 ctermbg=52
hi diffRemoved ctermfg=161 ctermbg=52
