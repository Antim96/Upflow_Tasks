Select users.id,"firstName", "lastName", "email", count(actions.id) from users 
Inner join actions ON "performedByUserId" = users.id
WHERE '2018-12-12 00:00:00+01' <= "performedAt" + '15 day'::interval
group by users.id  
Order By count(actions.id)
LIMIT 2;