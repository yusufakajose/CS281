/*
1. Find the name, surname, and date of birth of the actor that lives in either New York
or Istanbul or New Jersey or Antalya. 
*/
SELECT Name, Surname, DOB
FROM Actor
WHERE City IN (‘New York’, ‘Istanbul’, ‘New Jersey’, ‘Antalya’)
/* 
2. Find the name and surname of the youngest actor(s). 
*/
SELECT Name, Surname
FROM Actor
WHERE DOB = (SELECT MIN(DOB) FROM Actor)
/* 
3. Find the title of the movie made by the director “Justin Lin” and released in the
year 1989. 
*/
SELECT Title
FROM Movie M, Movie_ Director MB, Director D
WHERE M.MID = MB.MID AND MB.DID = D.DID AND D.Name = ‘Justin Lin’ AND
M.Year = 1989
/* 
4. List the name of each genre along with the total number of movies included in that
genre. 
*/
SELECT Genre, COUNT(*)
FROM Movie
GROUP BY Genre
/* 
5. List title of the movies having 5 or more actors.
*/
SELECT M.Title
FROM Movie M
WHERE M.MID IN (
Select M.MID
From Movie M, Actor A, Cast C
Where M.MID = C.MID and C.AID = A.AID
Group BY M.MID Having Count(*) >= 5)
/* 
6. Find the title of all the movies of actor name “Paul Walker” and also display his
role in each movie.
*/
SELECT M.Title, C.Role
FROM Movie M, Cast C , Actor A
WHERE A.AID = C.AID AND C.MID = M.MID
AND A.Name = “Paul Walker” 
/*  
7. Find name of studio and total duration time for movies launched by this studio.
Order the list in descending total duration.
*/
SELECT S.Name, SUM(M.Duration) as Duration
FROM Movie M, Movie_Studio MS , Studio S
WHERE M.MID = MS.MID AND MS.SID = S.SID GROUP BY S.Name
ORDER BY Duration DESC
/* 
8. Find the title of the movies in which “Jennifer Lawrence” and “Chris Prat”
worked together. 
*/
SELECT M.MID, M.Title
FROM Actor A, Cast C, Movie M
WHERE a.name='Jennifer Lawrence'
and a.AID=C.AID
and C.MID=M.MID
INTERSECT
SELECT M.MID, M.Title
FROM Actor A, Cast C , Movie M
WHERE a.name='Chris Pratt'
and a.AID=C.AID
and C.MID=M.MID
/*
9. Find the title and duration of the movies that have Studio Located in “New York”. 
*/
SELECT Title, Duration
FROM Movie M, Movie_Studio MS, Studio S
WHERE S.SID = MS.SID AND MS.MID = M.MID
AND S.Location = “New York” 
/* 
10. Find the name of all the actors who worked with the Director having name “Alan
Fitch”.
*/
SELECT A.Name
FROM Movie M, Director D, Movie_Director MD, Actor A, Cast C
WHERE A.AID = C.AID
AND C.MID = M.MID
AND M.MID = MD.MID
AND MD.DID = D.DID
AND D.Name = “Alan Fitch”
