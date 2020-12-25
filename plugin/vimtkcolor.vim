if exists('g:vimtkcolor') | finish | endif
let g:vim_tkcolor = 1

function! s:VTKColorpicker()
    let g:vtkc = ''
    if has('python')
    py << EOF
import vim
from Tkinter import Tk,Label
import tkColorChooser as colorchooser

k = vim.eval("&iskeyword")
c = vim.eval("expand(\"<cword>\")")
if "#" in k:
    c = c[1:]
if len(c) in {3,4,6,8} and set(c).issubset(set("aAbBcCdDeEfF0123456789")):
    h = "#" + c
    def choosecolor(*t):
        (rgb,hex) = colorchooser.askcolor(initialcolor=h)
        if hex:
            vim.command("let g:vtkc = '" + hex[1:] + "'")
        root.destroy()
    root = Tk()
    root.title(c)
    root.bind("q",lambda *_:root.destroy())
    root.bind("<Return>",lambda *_:root.destroy())
    root.bind("<Button-1>",choosecolor)
    label = Label(root,bg=h)
    label.pack(fill="both",expand=True)
    root.mainloop()

EOF
elseif has('python3')
    py3 << EOF
import vim
from tkinter import Tk,Label,colorchooser

k = vim.eval("&iskeyword")
c = vim.eval("expand(\"<cword>\")")
if "#" in k:
    c = c[1:]
if len(c) in {3,4,6,8} and set(c).issubset(set("aAbBcCdDeEfF0123456789")):
    h = "#" + c
    def choosecolor(*t):
        (rgb,hex) = colorchooser.askcolor(initialcolor=h)
        if hex:
            vim.command("let g:vtkc = '" + hex[1:] + "'")
        root.destroy()
    root = Tk()
    root.title(c)
    root.bind("q",lambda *_:root.destroy())
    root.bind("<Return>",lambda *_:root.destroy())
    root.bind("<Button-1>",choosecolor)
    label = Label(root,bg=h)
    label.pack(fill="both",expand=True)
    root.mainloop()

EOF

endif
    if (g:vtkc != '')
        exe ':s/\x*\%#\x*/'.g:vtkc.'/'
    endif
    unlet g:vtkc
endfunction

com ColorPicker call s:VTKColorpicker()

nnoremap <silent> <Plug>(ColorPickerKeyMapping) :ColorPicker<CR>
nnoremap <silent> <Plug>(ColorPickerMouseMapping) :ColorPicker<CR>

if !hasmapto('<Plug>(ColorPickerKeyMapping)','n') && (mapcheck('<F6>','n') == '')
    nmap <silent> <F6> <Plug>(ColorPickerKeyMapping)
endif

if !hasmapto('<Plug>(ColorPickerKeyMapping)','i') && (mapcheck('<F6>','i') == '')
    imap <F6> <Plug>(ColorPickerKeyMapping)
endif

if !hasmapto('<Plug>(ColorPickerMouseMapping)','n') && (mapcheck('<2-Leftmouse>','i') == '')
    nmap <silent> <2-LeftMouse> <Plug>(ColorPickerMouseMapping)
endif

