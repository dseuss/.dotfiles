" Compiler: GNU Fortran Compiler
" Maintainer: H Xu <xuhdev@gmail.com>
" Version: 0.1.3
" Last Change: 2012 Apr 30
" Homepage: http://www.vim.org/scripts/script.php?script_id=3496
"           https://bitbucket.org/xuhdev/compiler-gfortran.vim
" License: Same as Vim

if exists('current_compiler')
    finish
endif
let current_compiler = 'xmds2'
let s:keepcpo= &cpo
set cpo&vim

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=xmds2\ %
CompilerSet errorformat=
            \%WWARNING:\ %m,
            \%Z%pAt\ line\ %l\\,\ column\ %c,
            \XML\ Parser\ error:\ %m:\ line\ %l\\,\ column\ %c,
            \%f:%l:%c:\ error:\ %m,
            \%EERROR:\ %m,
            \%Z%pError\ caused\ at\ line\ %l\\,\ column\ %c:

let &cpo = s:keepcpo
unlet s:keepcpo
