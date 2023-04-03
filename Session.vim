let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/AppData/Local/nvim/lua/custom
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +72 plugins.lua
badd +1 ~/AppData/Local/nvim/lua/custom/init.lua
badd +1 ~/AppData/Local/nvim/lua/custom/mappings.lua
badd +1 ~/AppData/Local/nvim/lua/custom/chadrc.lua
badd +1 ~/AppData/Local/nvim/lua/custom/highlights.lua
badd +20 ~/AppData/Local/nvim/lua/custom/configs/lspconfig.lua
badd +11 ~/AppData/Local/nvim/lua/custom/configs/null-ls.lua
badd +63 ~/AppData/Local/nvim/lua/custom/configs/overrides.lua
argglobal
%argdel
edit plugins.lua
argglobal
balt ~/AppData/Local/nvim/lua/custom/configs/lspconfig.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
14,16fold
12,17fold
10,18fold
19,22fold
8,23fold
26,29fold
31,34fold
36,39fold
43,45fold
51,56fold
50,57fold
49,58fold
47,59fold
41,61fold
66,69fold
70,72fold
63,73fold
79,81fold
76,82fold
85,88fold
90,95fold
101,103fold
100,104fold
96,105fold
110,112fold
106,113fold
119,122fold
116,123fold
127,129fold
125,130fold
140,144fold
136,145fold
131,146fold
157,159fold
156,160fold
162,164fold
152,170fold
147,171fold
185,189fold
183,190fold
180,192fold
177,194fold
175,195fold
198,200fold
173,201fold
206,208fold
203,209fold
4,212fold
let &fdl = &fdl
let s:l = 72 - ((24 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 72
normal! 06|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=1
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
