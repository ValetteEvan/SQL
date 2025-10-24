-- TP03 - Requêtes SQL avec WHERE et ORDER BY
-- Database: compta2

USE compta2;

-- a. Listez toutes les données concernant les articles
SELECT * FROM article;

-- b. Listez uniquement les références et désignations des articles de plus de 2 euros
SELECT ref, designation
FROM article
WHERE prix > 2;

-- c. En utilisant les opérateurs de comparaison, listez tous les articles dont le prix est
--    compris entre 2 et 6.25 euros
SELECT *
FROM article
WHERE prix >= 2 AND prix <= 6.25;

-- d. En utilisant l'opérateur BETWEEN, listez tous les articles dont le prix est compris
--    entre 2 et 6.25 euros
SELECT *
FROM article
WHERE prix BETWEEN 2 AND 6.25;

-- e. Listez tous les articles, dans l'ordre des prix descendants, et dont le prix n'est pas
--    compris entre 2 et 6.25 euros et dont le fournisseur est Française d'Imports.
SELECT a.*
FROM article a
JOIN fournisseur f ON a.id_fou = f.id
WHERE (prix NOT BETWEEN 2 AND 6.25)
  AND f.nom = 'Française d''imports'
ORDER BY prix DESC;

-- f. En utilisant un opérateur logique, listez tous les articles dont les fournisseurs sont la
--    Française d'imports ou Dubois et Fils
SELECT a.*
FROM article a
JOIN fournisseur f ON a.id_fou = f.id
WHERE f.nom = 'Française d''imports' OR f.nom = 'Dubois & Fils';

-- g. En utilisant l'opérateur IN, réalisez la même requête que précédemment
SELECT a.*
FROM article a
JOIN fournisseur f ON a.id_fou = f.id
WHERE f.nom IN ('Française d''imports', 'Dubois & Fils');

-- h. En utilisant les opérateurs NOT et IN, listez tous les articles dont les fournisseurs ne
--    sont ni Française d'Imports, ni Dubois et Fils.
SELECT a.*
FROM article a
JOIN fournisseur f ON a.id_fou = f.id
WHERE f.nom NOT IN ('Française d''imports', 'Dubois & Fils');

-- i. Listez tous les bons de commande dont la date de commande est entre le
--    01/02/2019 et le 30/04/2019.
SELECT *
FROM bon
WHERE date_cmde BETWEEN '2019-02-01' AND '2019-04-30';
