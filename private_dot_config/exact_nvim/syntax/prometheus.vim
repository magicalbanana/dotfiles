" Vim syntax file
" Language: Prometheus Metrics
" Maintainer: Christian Haudum
" Last Revision: 10 January 2022
"

if exists("b:current_syntax")
  finish
endif

" Integer with - + or nothing in front
syn match metricValue '\d\+'
syn match metricValue '[-+]\d\+'

" Floating point number with decimal no E or e
syn match metricValue '[-+]\d\+\.\d*'

" Floating point like number with E and no decimal point (+,-)
syn match metricValue '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match metricValue '\d[[:digit:]]*[eE][\-+]\=\d\+'

" Floating point like number with E and decimal point (+,-)
syn match metricValue '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match metricValue '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'

" Match +/- NaN
syn match metricValue 'NaN'
syn match metricValue '[-+]NaN'

syn keyword metricHelpType contained TYPE
syn keyword metricType contained histogram gauge counter summary
syn match metricHelpText "#.*$" contains=metricHelpType,metricType

syn match metricLabelName '\w\+' nextgroup=eq contained
syn region metricLabelValue start='"' end='"' contained
syn match eq '=' nextgroup=metricLabelValue contained

syn region metricLabels start="{" end="}" fold transparent contains=metricLabelName,eq,metricLabelValue nextgroup=metricValue skipwhite

syn match metricName '[a-zA-Z_]\+' nextgroup=metricLabels

let b:current_syntax = "prometheus"

hi def link metricName Function
hi def link metricHelpText Comment
hi def link metricHelpType Identifier
hi def link metricType Identifier
hi def link metricLabelName Identifier
hi def link metricLabelValue String
hi def link metricValue Float
