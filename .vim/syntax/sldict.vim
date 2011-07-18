""""""""""""""""""""""""""""""""""""""""""""""""""
" Language:	SL-Dict                          "
" Maintainer:	Devaev Maxim <mdevaev@gmail.com> "
" Updated:	2009-04-09                       "
""""""""""""""""""""""""""""""""""""""""""""""""""


if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif


syn region	bold		start=+[uU]\=\\\[+ end=+\\\]+ contains=escapes,bold,italic,official,underlined
syn region	italic		start=+[uU]\=\\(+ end=+\\)+ contains=escapes,bold,italic,official,underlined
syn region	official	start=+[uU]\=\\<+ end=+\\>+ contains=escapes,bold,italic,official,underlined
syn region	underlined	start=+[uU]\=\\_+ end=+\\_+ contains=escapes,bold,italic,official
syn region	sound		start=+[uU]\=\\s+ end=+\\s+

syn match	word		"^\([^ ]\|\s[^ ]\)*  "
syn match	comment		"#.*$"
syn match	escapes		+\\[nt\\]+

if version >= 508 || !exists("did_sldict_syn_inits")
  if version <= 508
    let did_sldict_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink bold		Statement
  HiLink italic		Constant
  HiLink official	Type
  HiLink underlined	Underlined
  HiLink sound		Identifier

  HiLink word		PreProc
  HiLink comment	Comment
  HiLink escapes	Special
endif


let b:current_syntax = "sldict"
