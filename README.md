# libavlbst
libavlbst is a general purpose AVL binary search tree library.
Tools that need a easy and fast way to store, search and sort data can link against this shared library.
For each search tree entry a key and a data field is provided.
For both files several data types can be used:

- `void *`,
- `int`,
- `long`,
- `uint64_t` and
- `time_t`

so for most applications no memory needs to be allocated for the stored key or data (by the user).

Additional information can be found in the [manual page](http://n-t-roff.github.io/heirloom/bst.3.html)
and the [installation instructions](https://github.com/n-t-roff/libavlbst/blob/master/INSTALL).

The library can be downloaded as a
[realease tbz file](https://github.com/n-t-roff/libavlbst/releases/download/v1.0.1/libavlbst.tar.bz2),
with the [Download ZIP](https://github.com/n-t-roff/libavlbst/archive/master.zip) button or with
```
git clone https://github.com/n-t-roff/libavlbst.git
```
In the latter case the archive is updated with
```
git pull
```
later.
