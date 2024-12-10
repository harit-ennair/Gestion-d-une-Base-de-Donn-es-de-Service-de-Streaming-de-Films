-- name : harit
-- email : harit.enn@gmail.com

-- creation de database

CREATE DATABASE movies;

-- creation table de subscription

USE movies;

CREATE TABLE subscription (
subscriptionID INT AUTO_INCREMENT PRIMARY KEY,
subscriptionTYPE VARCHAR(50) NOT NULL,
CHECK(LOWER(subscriptionTYPE) = 'basic' OR LOWER(subscriptionTYPE) = 'premium'),
monthlyFee DECIMAL(10, 2) NOT NULL
);

-- creation table de users

USE movies;

CREATE TABLE users(
    usersID INT AUTO_INCREMENT PRIMARY KEY,
    firstNAME VARCHAR(100) NOT NULL,
    lastNAME VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE ,
    registrationDATE date NOT NULL,
    subscriptionID INT NOT NULL,
    FOREIGN KEY (SubscriptionID) REFERENCES subscription(SubscriptionID)
);

-- creation table de movie

USE movies;

CREATE TABLE movie (
    movieID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genr VARCHAR(100) NOT NULL,
    releaseyear YEAR NOT NULL,  
    duration INT NOT NULL,     
    rating VARCHAR(10) NOT NULL  
);

-- creation table de review

USE movies;

CREATE TABLE review(
    reviewID INT AUTO_INCREMENT PRIMARY KEY,
    usersID INT,
    FOREIGN KEY (usersID) REFERENCES users(usersID),
    movieID INT,
    FOREIGN KEY (movieID) REFERENCES movie(movieID),
    rating INT NOT NULL,
    reviewTEXT TEXT,
    reviewDATE DATE NOT NULL
);

-- creation table de watchhistory

USE movies;

CREATE TABLE watchhistory(
    watchID INT AUTO_INCREMENT PRIMARY KEY,
    usersID INT,
    FOREIGN KEY (usersID) REFERENCES users(usersID),
    movieID INT,
    FOREIGN KEY (movieID) REFERENCES movie(movieID),
    watchDATE DATE NOT NULL,
    completionpercentage INT DEFAULT 0
);

--Insérer un film: Ajouter un nouveau film intitulé Data Science Adventures dans le genre "Documentary"

INSERT INTO movie (title, genr, releaseyear, duration, rating)
VALUES ("Bullet Train", "action", "2022", "206", "PG");

--Rechercher des films : Lister tous les films du genre "Comedy" sortis après 2020

SELECT * 
FROM movie 
WHERE genr = 'comedy';

--Mise à jour des abonnements : Passer tous les utilisateurs de "Basic" à "Premium"

UPDATE subscription
SET subscriptionTYPE = 'premium'

--Afficher les abonnements : Joindre les utilisateurs à leurs types d'abonnements

SELECT users.lastNAME, users.firstNAME, subscription.subscriptionTYPE
FROM users
INNER JOIN subscription ON users.subscriptionID=subscription.subscriptionID;

--Filtrer les visionnages : Trouver tous les utilisateurs ayant terminé de regarder un film

SELECT *
FROM watchhistory
WHERE completionpercentage = 100

--Trier et limiter : Afficher les 5 films les plus longs, triés par durée

SELECT * 
FROM movie
ORDER BY duration DESC
LIMIT 5

--Agrégation : Calculer le pourcentage moyen de complétion pour chaque film

SELECT watchhistory.movieID , movie.title , AVG(completionpercentage)
FROM watchhistory 
join movie on movie.movieID = watchhistory.movieID
GROUP BY watchhistory.movieID , CompletionPercentage ;



