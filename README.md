# vimtkcolor

https://github.com/dustractor/vimtkcolor/

Uses tkinter to view/edit the hex color under the cursor.
The default mappings are f6 or double-click a word

Your vim must have been built with support for python.
Python versions 2 and 3 are supported.


    Plug 'dustractor/vimtkcolor'





If you already have something mapped to F6 or double-click then you will need to make mappings for:
    
    <Plug>(ColorPickerKeyMapping)
    <Plug>(ColorPickerMouseMapping)


    
