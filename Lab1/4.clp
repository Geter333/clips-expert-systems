(deftemplate person
    (multislot name) 
    (slot age (type INTEGER))
    (slot sex (allowed-values male female))
)

(deffacts people
    (person (name Ivan Ivanov) (age 20) (sex male))
    (person (name Anna) (age 19) (sex female))
)

(defrule find-men
    (person (name $?name) (sex male)) ; 
=>
    (printout t "Found man: " $?name crlf)
)

(defrule find-woman
    (person (name $?name) (sex female))
=>
    (printout t "Found woman: " $?name crlf)
)

(defrule find-20-years-old
    (person (name $?name) (age 20))
=>
    (printout t "Person who is 20: " $?name crlf)
)
