
# crun

> Run **C** code as script


## demo:

1. My C script, `test.c`:

    ```c
    #!/usr/bin/env crun

    #include <stdio.h>

    int main(void) {
        puts("Hello, world");
        return 0;
    }
    ```

    **Note:** We added a shebang! (`#!/usr/bin/env crun`)

2. Make it executable

    ```bash
    $ chmod +x test.c
    ```

3. Run it

    ```bash
    $ ./test.c
    ```


## rationale:

I just love C! (and why not?!) Okay! This allows me to write more C code
for day-to-day tasks, not just when you want to speed up some component
of an application. It makes C more practical for use.

The first time you invoke a crun script, it is compiled using `cc`, stored
away in `/tmp/crun` and run immediately. Subsequent invocations will run
the compiled executable, rather than re-compile, unless the source file
has been modified (in which case we compile!).


## installation:

It simple!

1. [Download the bash script][dl]
2. Rename it to `crun`
3. Place it in a directory in your `$PATH`.

For example,

```bash
$ cd ~/bin/
$ wget https://raw.githubusercontent.com/GochoMugo/crun/master/crun.sh
$ mv crun.sh crun
```


## license:

**The MIT License (MIT)**

Copyright (c) 2015 GochoMugo <mugo@forfuture.co.ke>

[dl]:https://raw.githubusercontent.com/GochoMugo/crun/master/crun.sh

