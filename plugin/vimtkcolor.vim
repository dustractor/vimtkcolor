if exists('g:vimtkcolor') | finish | endif
let g:vim_tkcolor = 1

function! s:SeeHex()
    let g:vtkc = ""
    py3 << EOF
import vim
from tkinter import Tk,Label,colorchooser
c = vim.eval("expand(\"<cword>\")")
if len(c) ==6 and set(c).issubset(set("aAbBcCdDeEfF0123456789")):
    h = "#" + c
    def choosecolor(*t):
        colorobj = colorchooser.askcolor(initialcolor=h)
        vim.vars["vtkc"] = colorobj[1][1:]
        root.destroy()
    root = Tk()
    root.title(c)
    root.bind("q",lambda *_:root.destroy())
    root.bind("<Button-1>",choosecolor)
    label = Label(root,bg=h)
    label.pack(fill="both",expand=True)
    root.mainloop()

EOF
let l:t = ":s/\\x*\\%#\\x*/".g:vtkc."/"
exe l:t
endfunction

com Hexi call s:SeeHex()

nnoremap <F6> :Hexi<CR>
nnoremap <2-LeftMouse> :Hexi<CR>
inoremap <F6> :Hexi<CR>

