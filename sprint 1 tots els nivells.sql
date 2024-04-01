#SPRINT 1 NIVELL 1

select * from company ;
select * from transaction  ;

#Exercici 2 . Realitza la següent consulta: 
#Has d'obtenir el nom, email i país de cada companyia, ordena les dades en funció del nom de les companyies.
SELECT company_name , email, country 
FROM company 
order by company_name ; 

#Exercici 3 . Des de la secció de màrqueting et sol·liciten que els passis un
# llistat dels països que estan fent compres.

SELECT  distinct company.country  
FROM transactions.company 
INNER JOIN transactions.transaction on transaction.company_id = company.id
where declined = 0
 ;
#Exercici 4.Des de màrqueting també volen saber des de quants països es realitzen les compres.

SELECT  count(distinct company.country)
FROM transactions.company 
INNER JOIN transactions.transaction on transaction.company_id = company.id 
 where declined = 0;

#Exercici 5. El teu cap identifica un error amb la companyia que té ID 'b-2354'.
# Per tant, et sol·licita que li indiquis el país i nom de companyia d'aquest ID.


SELECT  company.country , company.company_name  
FROM company 
WHERE company.id = 'b-2354';

#Exercici 6 . A més, el teu cap et sol·licita que identifiquis la companyia amb major mitjana de vendes.
 
SELECT distinct(company.company_name) , company.country, avg(transaction.amount) as average_amount
FROM transactions.company 
INNER JOIN transactions.transaction on transaction.company_id = company.id 
WHERE transaction.declined = 0 
group by  company.country, company.company_name 
order by average_amount desc 
limit 1;

select * from company ;
select * from transaction , company ;
select * from transaction  ;

#prueba
Select credit_card_id , company_id, user_id , timestamp ,sum(amount)
FRom transaction 
where declined = 0 
group by credit_card_id , company_id, user_id , timestamp;


#NIVELL 2 

#Exercici 1: El teu cap està redactant un informe de tancament de l'any i 
#et sol·licita que li enviïs informació rellevant per al document. 
#Per a això et sol·licita verificar si en la base de dades existeixen companyies amb 
#identificadors (ID) duplicats.


SELECT company_name , id
FROM company 
GROUP BY id
HAVING COUNT(*) > 1;


SELECT company_name , id
FROM company 
WHERE id IS NULL
GROUP BY id ;


#Exercici 2 :Identifica els cinc dies limit 5n que es va generar la major quantitat d'ingressos 
#a l'empresa per vendes.
# Mostra la data de cada transacció juntament amb el total de les vendes.

#correcte 
select company_id, sum(amount), timestamp 
from transaction
where declined = 0
group by company_id,  timestamp
order by  sum(amount) DESC
limit 5 ;

#Exercici 3 .Identifica els cinc dies que es va generar la menor quantitat d'ingressos 
#a l'empresa per vendes. 
#Mostra la data de cada transacció juntament amb el total de les vendes.

select company_id, sum(amount), timestamp 
from transaction
where declined = 0
group by company_id,  timestamp
order by  sum(amount) 
limit 5 ;

#Exercici 4 .Quina és la mitjana de vendes per país?
# Presenta els resultats ordenats per la mitjana de major a menor 

SELECT company.country, AVG(transaction.amount) AS average_sales
FROM transactions.company 
INNER JOIN transactions.transaction ON transaction.company_id = company.id 
WHERE transaction.declined = 0    
GROUP BY company.country
ORDER BY average_sales DESC;


#Nivell 3
#Exercici 1
#Presenta el nom, telèfon i país de les companyies,
#juntament amb la quantitat total de vendes, 
#d'aquelles empreses que van realitzar transaccions amb una venda 
#compresa entre 100 i 200 euros. Ordena els resultats de major a menor quantitat.

SELECT company.country,  company.company_name,company.phone , count(transaction.amount) AS average_sales
FROM transactions.company 
INNER JOIN transactions.transaction ON transaction.company_id = company.id 
WHERE transaction.declined = 0 and (transaction.amount between 100 and 200)
GROUP BY company.country , company.company_name, company.phone 
ORDER BY average_sales DESC;
#prueba 
SELECT company.country,  company.company_name,company.phone , transaction.amount 
FROM transactions.company 
INNER JOIN transactions.transaction ON transaction.company_id = company.id 
WHERE transaction.declined = 0 and (transaction.amount between 100 and 200)
GROUP BY company.country , company.company_name, company.phone , transaction.amount 
;
#correcto 
SELECT company.country,  company.company_name,company.phone , count(transaction.amount) AS average_sales
FROM transactions.company 
INNER JOIN transactions.transaction ON transaction.company_id = company.id 
WHERE transaction.declined = 0 and (transaction.amount between 100 and 200)
GROUP BY company.country , company.company_name, company.phone 
ORDER BY average_sales DESC;
#Exercici 2
#Indica el nom de les companyies que 
#van fer compres el 16 de març del 2022, 28 de febrer del 2022 i 13 de febrer del 2022. 

#aixi no surt 
SELECT company.company_name, SUM(transaction.amount) as sales 
FROM transactions.company
INNER JOIN transactions.transaction ON transaction.company_id = company.id
WHERE transaction.declined = 0 AND transaction.timestamp IN ('2022-03-16', '2022-02-28', '2022-02-13')
GROUP BY company.company_name
ORDER BY SUM(transaction.amount) DESC;

#amb la funcio DATE sique surt ( i no se selecciona la hora )
SELECT company.company_name, SUM(transaction.amount) AS total_sales 
FROM transactions.company
INNER JOIN transactions.transaction ON transaction.company_id = company.id
WHERE transaction.declined = 0 AND DATE(transaction.timestamp) IN ('2022-03-16', '2022-02-28', '2022-02-13')
GROUP BY company.company_name
ORDER BY total_sales DESC;    
