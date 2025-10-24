-- TP03 - Requêtes SQL avec WHERE et ORDER BY
-- Database: compta2

USE compta2;

-- a. Listez toutes les données concernant les articles
SELECT * FROM ARTICLE;

-- b. Listez uniquement les références et désignations des articles de plus de 2 euros
SELECT REF, DESIGNATION
FROM ARTICLE
WHERE PRIX > 2;

-- c. En utilisant les opérateurs de comparaison, listez tous les articles dont le prix est
--    compris entre 2 et 6.25 euros
SELECT *
FROM ARTICLE
WHERE PRIX >= 2 AND PRIX <= 6.25;

-- d. En utilisant l'opérateur BETWEEN, listez tous les articles dont le prix est compris
--    entre 2 et 6.25 euros
SELECT *
FROM ARTICLE
WHERE PRIX BETWEEN 2 AND 6.25;

-- e. Listez tous les articles, dans l'ordre des prix descendants, et dont le prix n'est pas
--    compris entre 2 et 6.25 euros et dont le fournisseur est Française d'Imports.
SELECT A.*
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
WHERE (PRIX NOT BETWEEN 2 AND 6.25)
  AND F.NOM = 'Française d''Imports'
ORDER BY PRIX DESC;

-- f. En utilisant un opérateur logique, listez tous les articles dont les fournisseurs sont la
--    Française d'imports ou Dubois et Fils
SELECT A.*
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
WHERE F.NOM = 'Française d''Imports' OR F.NOM = 'Dubois & Fils';

-- g. En utilisant l'opérateur IN, réalisez la même requête que précédemment
SELECT A.*
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
WHERE F.NOM IN ('Française d''Imports', 'Dubois & Fils');

-- h. En utilisant les opérateurs NOT et IN, listez tous les articles dont les fournisseurs ne
--    sont ni Française d'Imports, ni Dubois et Fils.
SELECT A.*
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
WHERE F.NOM NOT IN ('Française d''Imports', 'Dubois & Fils');

-- i. Listez tous les bons de commande dont la date de commande est entre le
--    01/02/2019 et le 30/04/2019.
SELECT *
FROM BON
WHERE datetime BETWEEN '2019-02-01' AND '2019-04-30';
