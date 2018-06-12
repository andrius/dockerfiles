fbless - CLI .fb2 and .fb2.zip books reader
===========================================

Usage:

Add following snippet to the bashrc/zshrc:

```bash
fbless() {
  docker run -ti --rm -v ${PWD}/$1:/book.fb2 andrius/fbless
}
```

Read book with command:

`fbless ./book.fb2` or `fbless ./book.fb2.zip`
