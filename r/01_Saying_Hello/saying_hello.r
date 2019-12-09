cat("What is your name? ");
name <- readLines("stdin",n=1);
cat(paste("Hello", name, "nice to meet you!", sep = ", "))
