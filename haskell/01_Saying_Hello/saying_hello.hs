import System.IO

main = do   
  putStrLn "What is your name? "
  name <- getLine
  putStrLn ("Hello, " ++ name ++ ", nice to meet you!")