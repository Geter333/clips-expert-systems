(deftemplate fire-material
   (slot name)
)

(deftemplate fire-class
   (slot type)
)

(deffacts fire-incidents
   (fire-material (name paper))
   (fire-material (name oil))
   (fire-material (name electrical-wiring))
   (fire-material (name magnesium))
)


(defrule classify-type-A
   (fire-material (name ?m&paper|wood|cloth))
=>
   (assert (fire-class (type A)))
   (printout t ">>> Material [" ?m "] identified as: Class A fire." crlf)
)

(defrule classify-type-B
   (fire-material (name ?m&oil|gas|grease))
=>
   (assert (fire-class (type B)))
   (printout t ">>> Material [" ?m "] identified as: Class B fire." crlf)
)

(defrule classify-type-C
   (fire-material (name ?m&electrical-wiring|energized-equipment))
=>
   (assert (fire-class (type C)))
   (printout t ">>> Material [" ?m "] identified as: Class C fire." crlf)
)

(defrule classify-type-D
   (fire-material (name ?m&magnesium|sodium|potassium))
=>
   (assert (fire-class (type D)))
   (printout t ">>> Material [" ?m "] identified as: Class D fire." crlf)
)


(defrule handle-class-A
   ?f <- (fire-class (type A))
=>
   (retract ?f)
   (printout t "Action for Class A: Extinguish with heat-absorbing agents (water, water-based liquids, dry chemicals)." crlf)
   (printout t "Additional notes: None." crlf crlf)
)

(defrule handle-class-B
   ?f <- (fire-class (type B))
=>
   (retract ?f)
   (printout t "Action for Class B: Extinguish by excluding air or interrupting combustion chain." crlf)
   (printout t "Extinguishers: Dry chemicals, carbon dioxide (CO2), foam, bromotrifluoromethane." crlf crlf)
)

(defrule handle-class-C
   ?f <- (fire-class (type C))
=>
   (retract ?f)
   (printout t "Action for Class C: Use nonconducting agents to prevent short circuits." crlf)
   (printout t "CRITICAL ACTION: Cut off electrical power immediately!" crlf)
   (printout t "Extinguishers: Dry chemicals, carbon dioxide (CO2), bromotrifluoromethane." crlf crlf)
)

(defrule handle-class-D
   ?f <- (fire-class (type D))
=>
   (retract ?f)
   (printout t "Action for Class D: Extinguish with smothering/heat-absorbing chemicals non-reactive with burning metals." crlf)
   (printout t "Extinguishers: Trimethoxyboroxine, screened graphitized coke." crlf crlf)
)