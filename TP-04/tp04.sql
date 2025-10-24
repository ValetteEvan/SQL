-- TP04 - Requêtes SQL avec WHERE, ORDER BY, GROUP BY et HAVING

USE compta;

-- a. Listez les articles dans l'ordre alphabétique des désignations
SELECT *
FROM article
ORDER BY designation ASC;

-- b. Listez les articles dans l'ordre des prix du plus élevé au moins élevé
SELECT *
FROM article
ORDER BY prix DESC;

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT *
FROM article
WHERE designation LIKE '%boulon%'
ORDER BY prix ASC;

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT *
FROM article
WHERE designation LIKE '%sachet%';

-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT *
FROM article
WHERE LOWER(designation) LIKE LOWER('%sachet%');

-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats
--    doivent être triées dans l'ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT a.*, f.nom AS nom_fournisseur
FROM article a
JOIN fournisseur f ON a.id_fou = f.id
ORDER BY f.nom ASC, a.prix DESC;

-- g. Listez les articles de la société « Dubois & Fils »
SELECT a.*
FROM article a
JOIN fournisseur f ON a.id_fou = f.id
WHERE f.nom = 'Dubois & Fils';

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT AVG(a.prix) AS prix_moyen
FROM article a
JOIN fournisseur f ON a.id_fou = f.id
WHERE f.nom = 'Dubois & Fils';

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT f.nom AS fournisseur, AVG(a.prix) AS prix_moyen
FROM article a
JOIN fournisseur f ON a.id_fou = f.id
GROUP BY f.id, f.nom;

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT *
FROM bon
WHERE date_cmde BETWEEN '2019-03-01 00:00:00' AND '2019-04-05 12:00:00';

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT b.*
FROM bon b
JOIN compo c ON b.id = c.id_bon
JOIN article a ON c.id_art = a.id
WHERE a.designation LIKE '%boulon%';

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT DISTINCT b.*, f.nom AS nom_fournisseur
FROM bon b
JOIN compo c ON b.id = c.id_bon
JOIN article a ON c.id_art = a.id
JOIN fournisseur f ON b.id_fou = f.id
WHERE a.designation LIKE '%boulon%';

-- m. Calculez le prix total de chaque bon de commande
SELECT b.id, b.numero, SUM(a.prix * c.qte) AS prix_total
FROM bon b
JOIN compo c ON b.id = c.id_bon
JOIN article a ON c.id_art = a.id
GROUP BY b.id, b.numero;

-- n. Comptez le nombre d'articles de chaque bon de commande
SELECT b.id, b.numero, SUM(c.qte) AS nombre_articles
FROM bon b
JOIN compo c ON b.id = c.id_bon
GROUP BY b.id, b.numero;

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et
--    affichez le nombre d'articles de chacun de ces bons de commande
SELECT b.numero, SUM(c.qte) AS nombre_articles
FROM bon b
JOIN compo c ON b.id = c.id_bon
GROUP BY b.id, b.numero
HAVING SUM(c.qte) > 25;

-- p. Calculez le coût total des commandes effectuées sur le mois d'avril
SELECT SUM(a.prix * c.qte) AS cout_total_avril
FROM bon b
JOIN compo c ON b.id = c.id_bon
JOIN article a ON c.id_art = a.id
WHERE MONTH(b.date_cmde) = 4 AND YEAR(b.date_cmde) = 2019;

-- a. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs différents
--    (indice : réaliser une auto-jointure i.e. de la table avec elle-même)
SELECT DISTINCT a1.id, a1.ref, a1.designation, a1.prix, a1.id_fou,
       a2.id AS id_autre, a2.ref AS ref_autre, a2.prix AS prix_autre, a2.id_fou AS id_fou_autre
FROM article a1
JOIN article a2 ON a1.designation = a2.designation AND a1.id_fou <> a2.id_fou
WHERE a1.id < a2.id;

-- b. Calculez les dépenses en commandes mois par mois
--    (indice : utilisation des fonctions MONTH et YEAR)
SELECT YEAR(b.date_cmde) AS annee,
       MONTH(b.date_cmde) AS mois,
       SUM(a.prix * c.qte) AS depenses_totales
FROM bon b
JOIN compo c ON b.id = c.id_bon
JOIN article a ON c.id_art = a.id
GROUP BY YEAR(b.date_cmde), MONTH(b.date_cmde)
ORDER BY annee, mois;

-- c. Sélectionnez les bons de commandes sans article
--    (indice : utilisation de EXISTS)
SELECT b.*
FROM bon b
WHERE NOT EXISTS (
    SELECT 1
    FROM compo c
    WHERE c.id_bon = b.id
);

-- d. Calculez le prix moyen des bons de commande par fournisseur.
SELECT f.nom AS fournisseur, AVG(prix_bon) AS prix_moyen_bons
FROM fournisseur f
JOIN bon b ON f.id = b.id_fou
JOIN (
    SELECT c.id_bon, SUM(a.prix * c.qte) AS prix_bon
    FROM compo c
    JOIN article a ON c.id_art = a.id
    GROUP BY c.id_bon
) AS prix_bons ON b.id = prix_bons.id_bon
GROUP BY f.id, f.nom;
