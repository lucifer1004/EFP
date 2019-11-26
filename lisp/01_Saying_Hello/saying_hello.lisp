
(write "What is your name? ")
(defvar name)
(setq name 
    (read-line))
(fresh-line)
(write 
    (concatenate 'string "Hello, " name ", nice to meet you!"))