main = do   
  putStr "What is your name? "
  name <- getLine
  putStrLn ("Hello, " ++ name ++ ", nice to meet you!")