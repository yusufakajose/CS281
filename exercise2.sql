/* 
Find title and description of games that are released after 2019
*/
select title,description
from Game
where releaseyear> 2019
/*  
Find name and city of stores that have 0 stock of the game “PUBG”.
*/
select storename, city
from Game g, Sell s, Store st
where g.title=’PUBG’ and instockqty=0
and g.Gameid=s.Gameid and s.Storeid=st.Storeid
/* 
Find name of stores that are located in “Ankara” or sell a game of category “First Person
Shooter”
*/
select storename
from Store S1,
(Select Storeid
From Store
Where city=’Ankara’
UNION
Select Storeid
From category c, hasCategory hc, Sell s
Where cname=’First Person Shooter’
And c.Categoryid=hc.Categoryid and hc.Gameid=S.gameid ) T1
Where S1.Storeid=T1.Storeid
/* 
Find title and release year of games in “Simulation” Category
*/
Select title, ReleaseYear
From category c, hasCategory hc, Game g
Where cname=’Simulation’
And c.Categoryid=hc.Categoryid and hc.Gameid=g.gameid
/* 
Find name of stores that do NOT sell any game of “Action” category.
*/
Select Storename
From Store
Where Storeid not in
(Select s.Storeid
From category c, hasCategory hc, Sell s
Where cname=’Action’
And c.Categoryid=hc.Categoryid and hc.Gameid=s.gameid )
/* 
Find title of games which has at least 2 different categories
*/
Select g.title
From hasCategory hc, Game g
Where hc.gameid=g.gameid
Group by g.gameid, g.title
Having count(*) > 1 
/* 
Find name and city of store(s) which has the highest in stock of “Minecraft”
*/
select storename, city
from store st1, sell s2, game g1
where Where g1.title=’Minecraft’
And g1.gameid=s1.gameid
And st1.storeid=s1.storeid
And s1.instockqty=
(Select max(inStockqty)
From Game g, Sell s
Where g.title=’Minecraft’
And g.gameid=s.gameid )
/* 
Find names of stores in Ankara which sell all video games
*/
select storename
from sell s, store st
where s.storeid=st.storeid
and s.city=’Ankara’
group by storeid, storename
having count(*) =
(Select count(*) from Game)
/*
Find names of stores in İzmir which sell both ‘Call of Duty’ and ‘GTA V’ games 
*/
select Storeid, storename
from sell s, store st, Game g
where st.city=’İzmir’
and g.title=’Call of Duty’
and st.storeid=s.storeid
and s.gameid=G.gameid
INTERSECT
select Storeid, storename
from sell s, store st, Game g
where st.city=’İzmir’
and g.title=’GTA V’
and st.storeid=s.storeid
and s.gameid=G.gameid