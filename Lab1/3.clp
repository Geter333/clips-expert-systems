(deffacts what-day-is-it?
    (Today is Thursday)
    (Tomorrow is Friday)
)

(defrule print-day
    (Today is ?day)
=>
    (printout t "Today is " ?day crlf)
)