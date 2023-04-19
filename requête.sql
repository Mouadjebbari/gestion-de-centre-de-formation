-- Afficher les sessions de formation à venir qui ne se chevauchent pas avec une session donnée.
SELECT * FROM session 
WHERE date_début > CURDATE() 
AND date_début NOT BETWEEN '2023-01-01' AND '2023-05-05' 
AND date_fin NOT BETWEEN '2023-01-01' AND '2023-05-05';

-- Afficher les sessions de formation à venir avec des places encore disponibles.
SELECT S.* FROM session S 
LEFT JOIN aprenant_session A ON S.id_session = A.id_session 
GROUP BY S.id_session 
HAVING COUNT(A.id_apprenant) < S.place_max 
AND S.date_début > CURDATE();

-- Afficher le nombre des inscrits par session de formation.
SELECT S.id_session, COUNT(A.id_apprenant) AS Nombre_inscrits 
FROM session S 
LEFT JOIN aprenant_session A ON S.id_session = A.id_session 
GROUP BY S.id_session;


-- Afficher l'historique des sessions de formation d'un apprenant donné.
SELECT S.* FROM session S 
INNER JOIN aprenant_session A ON S.id_session = A.id_session 
INNER JOIN aprenant AP ON A.id_aprenant = AP.id_aprenant 
WHERE AP.nom = 'nom_apprenant' AND AP.prenom = 'prenom_apprenant';


-- Afficher la liste des sessions qui sont affectées à un formateur donné, triées par date de début.
SELECT * FROM session 
WHERE id_formateur = 'id_formateur' 
ORDER BY date_début ASC;

-- Afficher la liste des apprenants d'une session donnée d'un formateur donné.
SELECT AP.* FROM aprenant AP 
INNER JOIN aprenant_session A ON AP.id_aprenant = A.id_aprenant 
INNER JOIN session S ON A.id_session = S.id_session 
WHERE S.id_session = 'id_session' AND S.id_formateur = 'id_formateur';


-- Afficher l'historique des sessions de formation d'un formateur donné.
SELECT * FROM session WHERE id_formateur = 'id_formateur';


-- Afficher les formateurs qui sont disponibles entre 2 dates.
SELECT * FROM formateur 
WHERE id_formateur NOT IN (
    SELECT DISTINCT S.id_formateur FROM session S 
    WHERE (S.date_début BETWEEN '2023-01-01' AND '2023-05-05') 
    OR (S.date_fin BETWEEN '2023-01-01' AND '2023-05-05')
);


-- Afficher toutes les sessions d'une formation donnée.
SELECT * FROM session WHERE id_formation = 'id_formation';


-- Afficher le nombre total des sessions par catégorie de formation.
SELECT F.catégorie, COUNT(S.id_session) AS Nombre_sessions 
FROM formation F 
INNER JOIN session S ON F.id_formation = S.id_formation 
GROUP BY F.catégorie;


-- Afficher le nombre total des inscrits par catégorie formation.
SELECT F.catégorie, COUNT(A.id_apprenant) AS Nombre_inscrits 
FROM formation F 
INNER JOIN session S ON F.id_formation = S.id_formation 
INNER JOIN aprenant_session A ON S.id_session = A.id_session 
GROUP BY F.catégorie;

