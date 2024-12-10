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