if exists('g:vimtkcolor') | finish | endif


function! s:VTKColorpicker()

    let g:vtkc = ''

    if has('pythonx')
        pyx << EOF

import vim

if sys.version_info.major == 2:
    from Tkinter import Tk,Label
    import tkColorChooser as colorchooser
elif sys.version_info.major == 3:
    from tkinter import Tk,Label,colorchooser
else:
    pass

keywordcharacters = vim.eval("&iskeyword")
colorword = vim.eval("expand(\"<cword>\")")
colorword = colorword[1:] if "#" in vim.eval("&iskeyword") else colorword
if len(colorword) in {3,4,6,8} and set(colorword).issubset(set("aAbBcCdDeEfF0123456789")):
    root = Tk()
    root.title(colorword)
    w,h,(x,y) = 200,200,root.winfo_pointerxy()
    root.geometry("%dx%d+%d+%d"%(w,h,x,y))
    root.bind("q",lambda *_:root.destroy())
    root.bind("<Escape>",lambda *_:root.destroy())
    init_color = "#" + colorword
    label = Label(root,bg=init_color)
    label.pack(fill="both",expand=True)
    def choosecolor(*t):
        (rgb,hex) = colorchooser.askcolor(initialcolor=init_color)
        if hex:
            vim.command("let g:vtkc = '%s'"%hex[1:])
        root.destroy()
    root.bind("<Return>",choosecolor)
    root.bind("<F6>",choosecolor)
    root.bind("<Button-1>",choosecolor)
    root.mainloop()

EOF

    endif
    if (g:vtkc != '') | exe ':s/\x*\%#\x*/'.g:vtkc.'/' | endif
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

let g:vimtkcolor = 1
