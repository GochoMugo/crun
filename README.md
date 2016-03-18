
# crun

> Run **C** scripts, just like you would do with Python, Ruby etc.
>
> [![Build Status](https://travis-ci.org/GochoMugo/crun.svg?branch=master)](https://travis-ci.org/GochoMugo/crun)


## demo:

1. My C script, `test.c`:

    ```c
    #!/usr/bin/env crun
    /* -Wall -O3 */

    #include <stdio.h>

    int main(int argc, char *argv[]) {
        printf("Hello, world %s!", argv[1]);
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
    $ ./test.c Koninchwa
    ```

    **Note:** We can pass arguments to the script! (`Koninchwa`)


## rationale:

I just love C! (and why not?!) Okay! This allows me to write more C code
for day-to-day tasks, not just when you want to speed up some component
of an application. It makes C more practical for use. Also, it is really
handy when you are learning C; everything important is contained in the
single file.

The first time you invoke a crun script, it is compiled using `cc` in
the directory holding the script, stored away in `/tmp/crun` and run
immediately. Subsequent invocations will run the compiled executable,
rather than re-compile, unless the source file has been modified
(in which case we compile!).

If you may want to change the directory where the executables are stored,
you can use the `${CRUN_CACHE_DIR}` variable. This is useful if you wish
to cache executables across restarts. If no directory exists at
`${CRUN_CACHE_DIR}` yet, it will be created using `mkdir -p`. Make sure
`crun` has permissions to write to the directory.

If you have compilation flags that you need to be passed to `cc`, you
place them in the **2nd line** separately, inside a comment using `/*` and
`*/`. For example,

```c
/* -Wall -O3 */
```

**Note**: While you can start your code in the 2nd line, it is advisable
you **avoid** doing so since `crun`, in the case the 2nd line contains `/*`
and `*/`, will assume it's being fed compilation flags. This may lead
to some weird compilation errors!

Also, you can use bash expressions in the string holding the flags; they
are evaluated. For example, `/* $(pkg-config --libs libuv) */` is totally
valid.


### extras:

To allow maximum efficiency, you can create a quick template of a script
using:

```bash
$ crun --create my_script
```

This will create an executable crun script that you can edit to add the meat.

In some cases, you want the script re-compiled, maybe you've modified some
library files. To bypass the cache:

```bash
$ crun --force-compile my_script
```

Sometimes, you may want to debug your script with `gdb`, or you just want to
skip running the compiled executable:

```bash
$ crun --just-compile my_script
```

Since `--just-compile` will make crun **not** run your executable, any arguments
passed will be considered to be more compilation flags to use. It also
echo's back the path to the compiled executable. So you could do something
like:

```bash
$ gdb `crun --just-compile script.c -Wall -g`
$ valgrind --leak-check=yes `crun --just-compile script.c -Wall -g` arg1 arg2
```



## installation:

It's simple!

1. [Download crun.sh][dl]
2. Rename it to `crun`
3. Place it in a directory in your `$PATH`.

For example,

```bash
$ cd ~/bin/
$ wget https://raw.githubusercontent.com/GochoMugo/crun/master/crun.sh
$ mv crun.sh crun
```


## contributing:

The **master** branch always remains stable. Development is done on the
**develop** branch.


## license:

**The MIT License (MIT)**

Copyright (c) 2015-2016 GochoMugo <mugo@forfuture.co.ke>

[dl]:https://raw.githubusercontent.com/GochoMugo/crun/master/crun.sh

