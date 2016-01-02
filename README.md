
# crun

> Run **C** code as script


## demo:

1. My C script, `test.c`:

    ```c
    #!/usr/bin/env crun
    /* -Wall -O3 */

    #include <stdio.h>

    int main(void) {
        puts("Hello, world");
        return 0;
    }
    ```

    **Note:** We added a shebang on the 1st line! (`#!/usr/bin/env crun`) <br/>
    **Note:** We added flags to be used in compilation in 2nd line! (`-Wall -O3`)

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
of an application. It makes C more practical for use. Also, it is really
handy when you are learning C; everything important is contained in the
single file.

The first time you invoke a crun script, it is compiled using `cc`, stored
away in `/tmp/crun` and run immediately. Subsequent invocations will run
the compiled executable, rather than re-compile, unless the source file
has been modified (in which case we compile!).

And remember **your C code should start from the 3rd line!** The 1st line always
holds the shebang. The second line holds the flags to be passed to `cc` inside
a comment using `/*` and `*/`. If you are **not** using any flags, leave it empty.

Also, you can use bash expressions in the string holding the flags; they
are evaluated. For example, `/* `pkg-config --libs libuv` */` is totally
valid.


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

