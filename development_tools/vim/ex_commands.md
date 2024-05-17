These are : commands in vim

| :w                                  | save a file                                                                                |
| ----------------------------------- | ------------------------------------------------------------------------------------------ |
| :q                                  | close a file, will fail if file has unsaved changes                                        |
| :q!                                 | will close a file forcefully, even with unsaved changes                                    |
| :wq                                 | save and close a file                                                                      |
| :[range]s/{pattern}/{change}/{flgs} | Find and replace, pattern can be regex                                                     |
| :s/led/gold                         | change first occurance of led to gold in line                                              |
| :s/led/gold/g                       | change all occurances of led to gold in the line                                           |
| :%s/led/gold/g                      | change all occurances of led to gold in the whole file                                     |
| :%s/led/gold/gc                     | change all occurances of led to gold in whole file with confirmation required for each one |
| :%s/led/gold/gci                    | same as above but case insensitive                                                         |
| :sp file                            | split horizontally and open file                                                           |
| :vsp file                           | split vertically and open file                                                             |
| :!                                  | Type this, then you can execute a shell command                                            |


Vim also provides a series of Ex commands that perform equivalent actions to the _Normal mode_ operators but with a different use case in mind: Operating on multiple lines at once.

These text-editing Ex commands take the following shape:

```vim
:[range]command[options]
```

Where **`range`** defines a range of lines to which to apply the command and **`options`** vary depending on the command itself. For instance, in the case of **`:delete`** we have:

```text
:[range]d [register]
```

Where **`register`** represents a register in which to cut whatever it is we delete. For instance:

```text
:10,12d a
```

Deletes the lines 10, 11 and 12 and puts them inside the **`a`** register. As you can appreciate above, ranges are generally defined by their extremes: An initial line and an ending line. These extremes can, in turn, be expressed in different ways:

- Using numbers (e.g. **`:10,12d`** to delete lines 10, 11 and 12)
- Using offsets (e.g. **`:10,+2d`** to delete lines 10, 11 and 12)
- Using the current line represented by **`.`** (e.g. **`:.,+2d`** to delete the current line and the next two ones)
- Using **`%`** to represent the whole file (e.g. **`:%d`** to delete the whole file)
- Using **`0`** to represent the beginning of the file (e.g. **`:0,+10d`** to delete the first 10 lines)
- Using **`$`** to represent the end of the file (e.g. **`:.,$d`** to delete from the current line to the end of the file)
- If you use _Visual mode_ to make a text selection and then type **`:`** your command line area will be pre-populated with the following gobbledygook: **`:'<,'>`** which is a special range that represents the current visual text selection. (e.g. **`:'<,'>d`** means delete the current text selection)
