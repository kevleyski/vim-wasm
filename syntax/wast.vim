if exists("b:current_syntax")
    finish
endif

syn cluster wastCluster       contains=wastModule,wastInstPrefix,wastInstName,wastInstAttr,wastParamInst,wastControlInst,wastwastString,wastNamedVar,wastUnnamedVar,wastFloat,wastNumber,wastComment,wastList,wastType

" Instructions
" https://webassembly.github.io/spec/core/text/instructions.html
syn match   wastInstPrefix    "\%((\s*\)\@<=\<\%(i32\|i64\|f32\|f64\|memory\)\." nextgroup=wastInstName contained display
syn match   wastInstName      "[[:alnum:]_]\+\>\%(/\%(i32\|i64\|f32\|f64\)\>\)\=" nextgroup=wastInstAttr   contained display
syn match   wastInstAttr      "\s\+\%(align\|offset\)=" contained display
" https://webassembly.github.io/spec/core/text/instructions.html#control-instructions
syn match   wastControlInst   "\%((\s*\)\@<=\<\%(block\|end\|loop\|if\|else\|unreachable\|nop\|br\|br_if\|br_table\|return\|call\|call_indirect\)" contained display
" https://webassembly.github.io/spec/core/text/instructions.html#parametric-instructions
syn match   wastParamInst     "\%((\s*\)\@<=\<\%(drop\|select\)" contained display

" Identifiers
" https://webassembly.github.io/spec/core/text/values.html#text-id
syn match   wastNamedVar      "$\+[[:alnum:]!#$%&'∗./:=><?@\\^_`~+-]*" contained display
syn match   wastUnnamedVar    "$\+\d\+[[:alnum:]!#$%&'∗./:=><?@\\^_`~+-]\@!" contained display

" String literals
" https://webassembly.github.io/spec/core/text/values.html#strings
syn region  wastString        start=+"+ skip=+\\\\\|\\"+ end=+"+ contained contains=wastStringSpecial
syn match   wastStringSpecial "\\\x\x\|\\[tnr'\\\"]\|\\u\x\+" contained containedin=wastString

" Float literals
" https://webassembly.github.io/spec/core/text/values.html#floating-point
syn match   wastFloat         "\<-\=\d\%(_\=\d\)*\%(\.\d\%(_\=\d\)*\)\=\%([eE][-+]\=\d\%(_\=\d\)*\)\=" display contained
syn match   wastFloat         "\<-\=0x\x\%(_\=\d\)*\%(\.\x\%(_\=\x\)*\)\=\%([pP][-+]\=\d\%(_\=\d\)*\)\=" display contained
syn keyword wastFloat         inf nan contained

" Integer literals
" https://webassembly.github.io/spec/core/text/values.html#integers
syn match   wastNumber        "\<-\=\d\%(_\=\d\)*\>" display contained
syn match   wastNumber        "\<-\=0x\x\%(_\=\x\)*\>" display contained

" Comments
" https://webassembly.github.io/spec/core/text/lexical.html#comments
syn region  wastComment       start=";;" end="$" display
syn region  wastComment       start="(;;\@!" end=";)"

syn region  wastList          matchgroup=wastListDelimiter start="(;\@!" matchgroup=wastListDelimiter end=";\@<!)" contains=@wastCluster

" Types
" https://webassembly.github.io/spec/core/text/types.html
syn keyword wastType          i64 i32 f64 f32 param result anyfunc mut contained
syn match   wastType          "\%((\_s*\)\@<=func\%(\_s*[()]\)\@=" display contained

" Modules
" https://webassembly.github.io/spec/core/text/modules.html
syn keyword wastModule        module type export import table memory global data elem contained
syn match   wastModule        "\%((\_s*\)\@<=func\%(\_s\+\$\)\@=" display contained

syn sync lines=100

hi def link wastModule        PreProc
hi def link wastListDelimiter Delimiter
hi def link wastInstPrefix    Operator
hi def link wastInstName      Operator
hi def link wastControlInst   Statement
hi def link wastParamInst     Conditional
hi def link wastString        String
hi def link wastStringSpecial Special
hi def link wastNamedVar      Identifier
hi def link wastUnnamedVar    PreProc
hi def link wastFloat         Float
hi def link wastNumber        Number
hi def link wastComment       Comment
hi def link wastType          Type

let b:current_syntax = "wast"
