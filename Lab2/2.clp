(deftemplate vehicle
   (slot name)         
   (slot type)        
   (slot max-speed (type INTEGER)) 
   (slot passengers (type INTEGER)) 
   (slot fuel)        
)

(deffacts vehicles-data
   (vehicle (name "автомобіль") (type "легковий") (max-speed 220) (passengers 5) (fuel "бензин"))
   
   (vehicle (name "велосипед") (type "двоколісний") (max-speed 30) (passengers 1) (fuel "відсутнє"))
   
   (vehicle (name "літак") (type "реактивний") (max-speed 900) (passengers 150) (fuel "авіаційний керосин"))
)