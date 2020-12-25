# vimtkcolor
view the hex color under the cursor or edit it with a gui color picker


---

double click a six-digit hex to edit it

or use f6


must have vim built with python. Python versions 2 and 3 are supported but 
currently there are 2 branches in the repository where this script originates

https://github.com/dustractor/vimtkcolor/tree/py2

and

https://github.com/dustractor/vimtkcolor/

are not the same branch

---

If your vim is built with python3, do:

    Plug 'dustractor/vimtkcolor'

but if your vim only has support for python2, do:

    Plug 'dustractor/vimtkcolor', {'branch':'py2'}

