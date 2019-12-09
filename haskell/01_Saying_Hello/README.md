# Tips

Run `ghci saying_hello.hs` to enter `ghci` and then type `main` to run the program.

The problem with `ghc` is that `putStr` will be blocked by `getLine` in that case.