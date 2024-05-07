Setup relative line numbers

# Vim Motions

| **Keys** | **Action**                            |
| -------- | ------------------------------------- |
| w        | navigate forward word by word         |
| b        | navigate back word by word            |
| ctrl-f   | move forward one page                 |
| ctrl-b   | move back one page                    |
| gg       | move to top of page                   |
| G        | move to end of page                   |
| :w       | save file                             |
| i        | insert mode before cursor             |
| a        | insert mode after cursor              |
| I        | insert text at start of line          |
| A        | insert text at end of line            |
| o        | insert text below current line        |
| O        | insert text above current line        |
| yy       | copy an entire line                   |
| dd       | delete an entire line                 |
| p        | paste                                 |
| u        | undo last change                      |
| ctrl-r   | redo last change                      |
| .        | repeat last operation in normal mode  |
| /word    | search for word forward               |
| ?word    | search for word backward              |
| n        | next search result                    |
| N        | previous search result                |
| *        | search forward for word under cursor  |
| #        | search backward for word under cursor |
| gd       | go to definition (within file)        |

# Vim Operators and Text Objects
The following table contains vim operators
## Operators

| **Keys** | **Action**                                                         |
| -------- | ------------------------------------------------------------------ |
| c        | delete and then place in insert mode essentially changing the text |
| d        | delete                                                             |
| y        | copy                                                               |
| p        | paste                                                              |
## Text Objects
Text objects are structured pieces of text or, if you will, the entities of a document domain model. What is a document composed of? Words, sentences, quoted text, paragraphs, blocks, (HTML) tags, etc. **These are text objects.**

The way that you specify a text object within a command is by combining the letter **`a`** (**a** text object plus whitespace) or **`i`** (**inner** object without whitespace) with a character that represents a text object itself: {operator}{a|i}{text-object}

Built in text objects are:

| **Text Objects** | **Description** |
| ---------------- | --------------- |
| w                | word            |
| s                | sentence        |
| p                | paragraph       |
| b or (           | inside ()       |
| B or {           | inside {}       |
| ' or "           | quotes          |
| <                | <>              |
| [                | []              |
## Combining Operators with text objects
Examples:

| yi{ | copy text inside curly brace you are in             |
| --- | --------------------------------------------------- |
| ya{ | copy text inside curly brace including curly braces |
| ci{ | change text inside curly brace                      |
| ca{ | change text including curly braces                  |
| ciw | change word not including white space               |
| di{ | delete inside curly brace                           |
| da{ | delete inside curly brace including curly braces    |
## Find and replace
/word to search for word, then type cgn, change word, exit insert mode, then . will change and switch to next word

## Copy and Paste with Registers
- The **unnamed register** **`"`** is where you copy and cut stuff to, when you don’t explicitly specify a register. The default register if you will.
- The **named registers** **`a-z`** are registers you can use explicitly to copy and cut text at will
- The **yank register** **`0`** stores the last thing you have yanked (copied)
- The **cut registers** **`1-9`** store the last 9 things you cut by using either the delete or the change command

To put things into specific registers:
```
"{name of register}y{motion}
"{name of register}d{motion}
"{name of register}c{motion}
```
For instance, **`"ayas`** yanks a sentence and stores it in register **`a`**. Now if you want to paste it somewhere else, you can type **`"ap`**.

At any point in time, you can use the `:reg` command to see what is in your registers. Or you can type `:reg {register}` to inspect the contents of a specific register.

All the commands we’ve seen thus far operate in _Normal mode_. What if you want to paste something when you’re in _Insert mode_? Well you can do that as well. Using `CTRL-R {register}` you can paste the contents of a register after the cursor:

- **`CTRL-R "`** pastes the contents of the unnamed register
- **`CTRL-R a`** pastes the contents of register **`a`**
- **`CTRL-R 0`** pastes the contents of the yank register
