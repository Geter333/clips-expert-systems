(deftemplate fire-material
   (slot name)
)

(deftemplate fire-class
   (slot type)
)

(deffunction log-identified-class (?material ?class)
   (printout t ">>> Material [" ?material "] identified as: Class " ?class " fire." crlf)
)

(deffunction print-fire-instructions (?class ?action ?extinguishers ?notes)
   (printout t "Action for Class " ?class ": " ?action crlf)
   (printout t "Extinguishers: " ?extinguishers crlf)
   (if (neq ?notes "None.") then
      (printout t "CRITICAL ACTION: " ?notes crlf)
   else
      (printout t "Additional notes: " ?notes crlf)
   )
   (printout t crlf)
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
   (log-identified-class ?m "A")
)

(defrule classify-type-B
   (fire-material (name ?m&oil|gas|grease))
=>
   (assert (fire-class (type B)))
   (log-identified-class ?m "B")
)

(defrule classify-type-C
   (fire-material (name ?m&electrical-wiring|energized-equipment))
=>
   (assert (fire-class (type C)))
   (log-identified-class ?m "C")
)

(defrule classify-type-D
   (fire-material (name ?m&magnesium|sodium|potassium))
=>
   (assert (fire-class (type D)))
   (log-identified-class ?m "D")
)

(defrule handle-class-A
   ?f <- (fire-class (type A))
=>
   (retract ?f)
   (print-fire-instructions "A" 
      "Extinguish with heat-absorbing agents (water, water-based liquids, dry chemicals)."
      "Water, dry chemicals."
      "None.")
)

(defrule handle-class-B
   ?f <- (fire-class (type B))
=>
   (retract ?f)
   (print-fire-instructions "B" 
      "Extinguish by excluding air or interrupting combustion chain."
      "Dry chemicals, carbon dioxide (CO2), foam, bromotrifluoromethane."
      "None.")
)

(defrule handle-class-C
   ?f <- (fire-class (type C))
=>
   (retract ?f)
   (print-fire-instructions "C" 
      "Use nonconducting agents to prevent short circuits."
      "Dry chemicals, carbon dioxide (CO2), bromotrifluoromethane."
      "Cut off electrical power immediately!")
)

(defrule handle-class-D
   ?f <- (fire-class (type D))
=>
   (retract ?f)
   (print-fire-instructions "D" 
      "Extinguish with smothering/heat-absorbing chemicals non-reactive with burning metals."
      "Trimethoxyboroxine, screened graphitized coke."
      "None.")
)