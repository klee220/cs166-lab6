SELECT s.sname, COUNT(c.sid)
FROM catalog c, suppliers s
WHERE s.sid = c.sid
GROUP BY s.sname;

SELECT s.sname, COUNT(c.sid)
FROM catalog c, suppliers s
WHERE s.sid = c.sid
GROUP BY s.sname HAVING count(c.sid)>2;

(SELECT s.sname, COUNT(c.sid)
FROM suppliers s, catalog c, parts p
WHERE s.sid = c.sid AND c.pid = p.pid AND p.color = 'Green'
GROUP BY s.sname)
EXCEPT
(SELECT s.sname, COUNT(c.sid)
FROM suppliers s, catalog c, parts p
WHERE s.sid = c.sid AND c.pid = p.pid AND p.color != 'Green'
GROUP BY s.sname);

SELECT k.sname, MAX(c1.cost)
FROM suppliers k, catalog c1
WHERE c1.sid = k.sid AND k.sname IN ((SELECT s.sname
FROM suppliers s, catalog c, parts p
WHERE s.sid = c.sid AND c.pid = p.pid AND p.color = 'Green' 
GROUP BY s.sname)
INTERSECT
(SELECT s.sname
FROM suppliers s, catalog c, parts p
WHERE s.sid = c.sid AND c.pid = p.pid AND p.color = 'Red' 
GROUP BY s.sname))
GROUP BY k.sname;
