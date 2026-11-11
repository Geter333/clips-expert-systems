(deftemplate person
   (slot name)
   (slot gender)
   (slot role)
)

(deftemplate family
   (slot child)
   (slot father)
   (slot mother)
)

(deffacts family-data
   (person (name Tom) (gender male) (role father))
   
   (person (name Susan) (gender female) (role mother))
   
   (person (name John) (gender male) (role son))
   
   (family (child John) (father Tom) (mother Susan))
)