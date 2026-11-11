; ===== Лабораторна робота 5, індивідуальне завдання 8 =====
; Додавання двійкових чисел без арифметичних функцій

; Двійкове число: ім'я та цифри (від старшого розряду до молодшого)
(deftemplate binary-number
    (multislot name)
    (multislot digits))

; Запит на додавання двох чисел
(deftemplate add-binary-numbers
    (slot name-1)
    (slot name-2))

; Робоча структура: непроцесовані цифри, перенос і накопичений результат
(deftemplate adder
    (multislot name)
    (multislot rest-1)
    (multislot rest-2)
    (slot carry)
    (multislot result))

; Рядок таблиці істинності повного суматора
(deftemplate full-adder
    (slot a) (slot b) (slot cin)
    (slot sum) (slot cout))

(deffacts full-adder-table
    (full-adder (a 0) (b 0) (cin 0) (sum 0) (cout 0))
    (full-adder (a 0) (b 0) (cin 1) (sum 1) (cout 0))
    (full-adder (a 0) (b 1) (cin 0) (sum 1) (cout 0))
    (full-adder (a 0) (b 1) (cin 1) (sum 0) (cout 1))
    (full-adder (a 1) (b 0) (cin 0) (sum 1) (cout 0))
    (full-adder (a 1) (b 0) (cin 1) (sum 0) (cout 1))
    (full-adder (a 1) (b 1) (cin 0) (sum 0) (cout 1))
    (full-adder (a 1) (b 1) (cin 1) (sum 1) (cout 1)))

; Тестові дані
(deffacts test-data
    (binary-number (name A) (digits 1 0 1 1 1))
    (binary-number (name B) (digits 1 1 1 0))
    (add-binary-numbers (name-1 A) (name-2 B))
    (binary-number (name C) (digits 1 1 1 1))
    (binary-number (name D) (digits 1))
    (add-binary-numbers (name-1 C) (name-2 D))
    (binary-number (name E) (digits 1 0 1))
    (binary-number (name F) (digits 1 0 1))
    (add-binary-numbers (name-1 E) (name-2 F)))

; Крок 1: з запиту створюється робочий факт, перенос = 0
(defrule start-addition
    ?req <- (add-binary-numbers (name-1 ?n1) (name-2 ?n2))
    (binary-number (name ?n1) (digits $?d1))
    (binary-number (name ?n2) (digits $?d2))
    =>
    (retract ?req)
    (assert (adder (name ?n1 + ?n2)
                   (rest-1 $?d1) (rest-2 $?d2)
                   (carry 0) (result))))

; Крок 2а: в обох числах ще є цифри
(defrule add-both
    ?f <- (adder (rest-1 $?r1 ?a) (rest-2 $?r2 ?b)
                 (carry ?c) (result $?res))
    (full-adder (a ?a) (b ?b) (cin ?c) (sum ?s) (cout ?co))
    =>
    (modify ?f (rest-1 $?r1) (rest-2 $?r2)
               (carry ?co) (result ?s $?res)))

; Крок 2б: друге число закінчилось, його цифра вважається 0
(defrule add-first-only
    ?f <- (adder (rest-1 $?r1 ?a) (rest-2)
                 (carry ?c) (result $?res))
    (full-adder (a ?a) (b 0) (cin ?c) (sum ?s) (cout ?co))
    =>
    (modify ?f (rest-1 $?r1) (carry ?co) (result ?s $?res)))

; Крок 2в: перше число закінчилось, його цифра вважається 0
(defrule add-second-only
    ?f <- (adder (rest-1) (rest-2 $?r2 ?b)
                 (carry ?c) (result $?res))
    (full-adder (a 0) (b ?b) (cin ?c) (sum ?s) (cout ?co))
    =>
    (modify ?f (rest-2 $?r2) (carry ?co) (result ?s $?res)))

; Крок 3: цифри закінчились, але є перенос - дописуємо старшу 1
(defrule finish-carry
    ?f <- (adder (rest-1) (rest-2) (carry 1) (result $?res))
    =>
    (modify ?f (carry 0) (result 1 $?res)))

; Крок 4: цифр і переносу немає - створюємо результат
(defrule finish
    ?f <- (adder (name $?name) (rest-1) (rest-2)
                 (carry 0) (result $?res))
    =>
    (retract ?f)
    (assert (binary-number (name $?name) (digits $?res)))
    (printout t (implode$ $?name) " = " (implode$ $?res) crlf))
