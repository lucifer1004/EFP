(ns saying-hello.core
  (:gen-class))

(defn -main
  [& args]
  (print "What is your name? ")
  (flush)
  (def username (read-line))
  (println (str "Hello, " username ", nice to meet you!")))
