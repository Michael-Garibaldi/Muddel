
[Muddel](#starMuddel)
[Screenshots](#starScreenshots)
[Installation](#Installation)


## :star:Muddel

Muddel is an emacs mud client 


It features :

*  Ansi Color compatibility

*  Input can be entered into either the minibuffer or the text buffer

  Right now it's in pre-alpha, so it's rough, but it's one file. Just place it into your emacs directory (in Windows it's C:\Program Files\Emacs\emacs-30.1\share\emacs\30.1\lisp\play) , restart Emacs and call it by typing in:
  
  **(require 'muddel)**

  Alternatively you can save it into your .emacs.d directory and create a path to it like:

  (add-to-list 'load-path "C:/Users/Tech/AppData/Roaming/.emacs.d/elpa/muddel/")

  

## :star:Screenshots


*FIRST:  
Be aware that you *may* need to change your theme to something with a dark background or at LEAST your baackground to a dark background if you use a light-colored background as it won't show up properly otherwise.   (Trust me, I hate this, my own theme doesn't work with it!)

The Login Screen:

![Login screen](https://github.com/Michael-Garibaldi/Muddel/blob/main/login.jpg)



The login screen **DOES** throw up some junk at the top, but beyond that, it's fine.

You can either use the minibuffer **OR** the full text buffer (which is default) to enter your text into.  The minibuffer is triggered by C-c c:

![The Minibuffer](https://github.com/Michael-Garibaldi/Muddel/blob/main/Mini_Buffer.jpg)


The full text window is used  by default:

![The Full Text Window](https://github.com/Michael-Garibaldi/Muddel/blob/main/Login_Text_Buffer.jpg)


Ansi color is supported by default. *(BE AWARE: You HAVE to add a line of elisp to your .emacs or .init for this to work, see the "INSTALL" section for details)*  :

![Ansi color support shown](https://github.com/Michael-Garibaldi/Muddel/blob/main/Ansi_support.jpg)


## :star:Installation
