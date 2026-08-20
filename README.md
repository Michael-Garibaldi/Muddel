# CAUTION:  THIS PROJECT IS IN BETA MODE - IT RUNS, BUT YOU MAY FIND ERRORS!!



[Muddel](#starMuddel)
[Screenshots](#starScreenshots)
[Installation](#Installation)
[Cautions](#Cautions)

## :star:Muddel

Muddel is an emacs mud client 


It features :

*  Ansi Color compatibility



  Right now it's in Beta, so it's got some rough spots, but it's one file. Just place it into your emacs directory (in Windows it's C:\Program Files\Emacs\emacs-30.1\share\emacs\30.1\lisp\play) , restart Emacs and call it by typing in:
  
  **(require 'muddel)**

  Alternatively you can save it into your .emacs.d directory and create a path to it like:

  (add-to-list 'load-path "C:/Users/Tech/AppData/Roaming/.emacs.d/elpa/muddel/")

  

## :star:Screenshots


*FIRST:  
Be aware that you *may* need to change your theme to something with a dark background or at LEAST your background to a dark background if you use a light-colored background as it won't show up properly otherwise.   (Trust me, I hate this, my own theme doesn't work with it!)

The Login Screen:

![Login screen](https://github.com/Michael-Garibaldi/Muddel/blob/main/login.jpg)



The login screen **DOES** throw up some junk at the top, but beyond that, it's fine.

You can  use the the full text buffer to to enter your text into.  :


![The Full Text Window](https://github.com/Michael-Garibaldi/Muddel/blob/main/Login_Text_Buffer.jpg)


Ansi color is supported by default. *(BE AWARE: You HAVE to add a line of elisp to your .emacs or .init for this to work, see the "INSTALL" section for details)*  :

![Ansi color support shown](https://github.com/Michael-Garibaldi/Muddel/blob/main/Ansi_support.jpg)


## :star:Installation

**ATTENTION:**  In order to have Ansi color support you *NEED* to follow step one. If you don't want it, feel free to skip it:

**1:** Open up your emacs init file *(either .emacs or .init)* and add one line of elisp to it:

![Ansi support Elisp](https://github.com/Michael-Garibaldi/Muddel/blob/main/Elisp.jpg)

Save this now.  

**2:**  Download muddel.el.  You can either save it in your .emacs.d/ folder OR save it in emacs's program area (In Windows 11, that area is C:\Program Files\Emacs\emacs-30.1\share\emacs\30.1\lisp\play *(I'm using emacs 30.1)) *.


**3:** Be aware that once you start muddel, it will automatically attempt to connect to aardmud. You can change that easily, just edit the following two lines:

![Muddel elisp](https://github.com/Michael-Garibaldi/Muddel/blob/main/muddel_elisp.jpg)

Change it to whatever mud and port you'd like, just place the names inside the quotes, then save it.

**4:**  Now you can either 

a.) open up your emacs init file again and add in "**(require 'muddel)**"  (no quotes) and save it

OR

b.) **M-X Load-file** and go to the directory you saved Muddel in and load it. 

If you **"require"**d it, you can **M-x start-my-telnet-buffer** and muddel will start.  If you loaded it, it will start automatically.


## :star:Cautions

Please be aware that this is in Alpha Mode so you may find errors in this code.  Feel free to reach out or submit a pull. I'm a relative newbie in Elisp, so I don't bite!

Be aware of the following issues:

**1:** Your password WILL show up in plain text

**2:** The first line contains garbage, but that's the end of it.


It's not fancy, no triggers, bots, or fancy windows.  Perhaps in the future, or feel free to submit a pull! 

Enjoy!
