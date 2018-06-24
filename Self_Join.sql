# Self Join


/*
-- In somem cases, where you want to join a table to it's self
For instance to find pairs of entries that have something in common. 

Example:

There is a table Residences

+-------------+-----------+--------+
| id          | building  | room   |         
+-------------+-----------+--------+
| 4130001     | Crosby    | 10     |
| 1161282     | Dolliver  | 7      |
| 881256      | Crosby    | 10     |
| 231742      | kedrick   | 3B     |
| 104131      | Dolliver  | 14     |
| 612412      | Crosby    | 31     |
+-------------+-----------+--------+

To find out which students are roommates; find pairs of roommates? 
*/

# The basic query but with some bugs
SELECT a.id, b.id, a.building, a.room
FROM Residences a, Residences b
WHERE a.building = b.building
AND a.room = b.room
ORDER BY a.building, a.room;

/* Output
+--------+--------+----------+------+
|     id |     id | building | room |
+========+========+==========+======+
| 413001 | 413001 |   Crosby |   10 |
| 413001 | 881256 |   Crosby |   10 |
| 881256 | 413001 |   Crosby |   10 |
| 881256 | 881256 |   Crosby |   10 |
| 496747 | 496747 |   Crosby |   19 |
| 496747 | 741532 |   Crosby |   19 |
| 741532 | 496747 |   Crosby |   19 |
| 741532 | 741532 |   Crosby |   19 |
| 410315 | 410315 |   Crosby |   20 |
| 498446 | 498446 |   Crosby |   21 |
| 851866 | 851866 |   Crosby |   22 |
| 612413 | 612413 |   Crosby |   31 |
| 612413 | 931027 |   Crosby |   31 |

# bug: it lists each pair of roommates twice in alternating order
*/


SELECT a.id, b.id, a.building, a.room
FROM Residences a, Residences b
WHERE a.building = b.building
AND a.room = b.room
AND a.id > b.id # eliminate the rows where they're equal, the same student
ORDER BY a.building, a.room;

/* Output
+--------+--------+----------+------+
|     id |     id | building | room |
+========+========+==========+======+
| 881256 | 413001 |   Crosby |   10 |
| 741532 | 496747 |   Crosby |   19 |
| 931027 | 612413 |   Crosby |   31 |
| 958827 | 170267 | Dolliver |    1 |
| 707536 | 104131 | Dolliver |   14 |
| 505241 | 477801 | Dolliver |    8 |
| 824292 | 118199 | Kendrick |   1A |
| 231742 | 105540 | Kendrick |   3B |
+--------+--------+----------+------+
*/

