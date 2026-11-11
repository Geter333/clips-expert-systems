(deffacts initial-data
   (person Tom male father)
   (person Susan female mother)
   (person John male son)
   (family-relation John Tom Susan)
)

(defrule rule-1
   (declare (salience 90))
   (family-relation ?child ?father ?mother)
=>
   (printout t "The father of " ?child " is " ?father "." crlf)
)

(defrule rule-2
   (declare (salience 80))
   (family-relation ?child ?father ?mother)
=>
   (printout t "The mother of " ?child " is " ?mother "." crlf)
)

(defrule rule-3
   (declare (salience 70))
   (family-relation ?child ?father ?mother)
=>
   (printout t "The parents of " ?child " are " ?father " and " ?mother "." crlf)
)

(defrule rule-4
   (declare (salience 60))
   (person ?name ? father)
=>
   (printout t ?name " is a father." crlf)
)

(defrule rule-5
   (declare (salience 50))
   (person ?name ? mother)
=>
   (printout t ?name " is a mother." crlf)
)

(defrule rule-6
   (declare (salience 40))
   (person ?name ? son)
=>
   (printout t ?name " is a son." crlf)
)

(defrule rule-7
   (declare (salience 30))
   (person Tom male ?)
=>
   (printout t "Tom is a male." crlf)
)

(defrule rule-8
   (declare (salience 20))
   (person Susan female ?)
=>
   (printout t "Susan is a female." crlf)
)

(defrule rule-9
   (declare (salience 10))
   (person John male ?)
=>
   (printout t "John is a male." crlf)
)