# libavlbst
`libavlbst` is a general purpose AVL binary search tree library.
Tools that need an easy and fast way to store, search and sort data
can link against this shared library.
For each search tree entry a key and a data field is provided.
For both fields several data types can be used:
`void *`,
`const void *`,
`intptr_t`,
`uintptr_t`,
`int`,
`long`,
`uint64_t`,
and
`time_t`,
so for most applications no memory needs to be allocated
(by the user) for storing key or data.

While the build process is UNIX specific, the
[source code](https://github.com/n-t-roff/libavlbst/blob/master/bst.c)
is ANSI C and hence system independent.
Additional information is found in the manual page
([HTML](http://n-t-roff.github.io/libavlbst.3.html),
[PDF](http://n-t-roff.github.io/libavlbst.3.pdf))
and the
[installation instructions](https://github.com/n-t-roff/libavlbst/blob/master/INSTALL).
A usage example of the library functions
`avl_add()`, `bst_srch()`, and `bst_del_node()`
can be found in the [rlcmp](https://github.com/n-t-roff/rlcmp)
project's file [dir.c](https://github.com/n-t-roff/rlcmp/blob/master/dir.c).

The library can be downloaded with
```
git clone https://github.com/n-t-roff/libavlbst.git
```
and updated with
```
git pull
```
later.
