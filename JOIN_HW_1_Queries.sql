USE [Library]

/*1. Display books with the minimum number of pages issued by a particular publishing house.
1. Hər Publisherin ən az səhifəli kitabını ekrana çıxarın*/

SELECT B.[Name]
FROM Books AS B
INNER JOIN Press ON B.Id_Press = PRESS.Id
WHERE 
    B.Pages = (
        SELECT 
            MIN(Pages)
        FROM 
            Books
        WHERE 
            Id_Press = PRESS.Id)



/*2. Display the names of publishers who have issued books with an average number of pages larger than 100.	
2. Publisherin ümumi çap etdiyi kitabların orta səhifəsi 100dən yuxarıdırsa, o Publisherləri ekrana çıxarın.*/

SELECT PRESS.[Name]
FROM PRESS
INNER JOIN BOOKS ON BOOKS.Id_Press = PRESS.Id
GROUP BY PRESS.[NAME]
HAVING AVG(BOOKS.Pages) > 100


/*3. Output the total amount of pages of all the books in the library issued by the publishing houses BHV and BINOM.
3. BHV və BİNOM Publisherlərinin kitabların bütün cəmi səhifəsini ekrana çıxarın*/

SELECT PRESS.[NAME], SUM(BOOKS.PAGES) AS [SUM OF PAGES]
FROM PRESS
INNER JOIN BOOKS ON BOOKS.Id_Press = PRESS.Id
GROUP BY PRESS.[NAME]
HAVING PRESS.[NAME] IN ('BHV','BINOM')

/*4. Select the names of all students who took books between January 1, 2001 and the current date.
4. Yanvarın 1-i 2001ci il və bu gün arasında kitabxanadan kitab götürən bütün tələbələrin adlarını ekrana çıxarın*/

SELECT DISTINCT Students.[FirstName] AS FIRSTNAME, Students.[LastName] AS LASTNAME
FROM Students
INNER JOIN S_Cards ON Students.ID = S_Cards.Id_Student
LEFT JOIN Books ON S_Cards.Id_Book = Books.ID
WHERE S_Cards.DateOut BETWEEN '2001-01-01' AND GETDATE();

/*5. Find all students who are currently working with the book "Windows 2000 Registry" by Olga Kokoreva.
5. Olga Kokorevanın  "Windows 2000 Registry" kitabı üzərində işləyən tələbələri tapın*/

SELECT CONCAT(Students.FirstName, Students.LastName) AS [Full Name] 
FROM Students
INNER JOIN S_Cards ON Students.ID = S_Cards.Id_Student
INNER JOIN Books ON S_Cards.Id_Book = Books.ID
INNER JOIN Authors ON Books.Id_Author = Authors.ID
WHERE Books.[Name] = 'Windows 2000 Registry'
  AND (Authors.[FirstName] = 'Olga' AND Authors.LastName = 'Kokoreva');


/*6. Display information about authors whose average volume of books (in pages) is more than 600 pages.
6. Yazdığı bütün kitabları nəzərə aldıqda, orta səhifə sayı 600dən çox olan Yazıçılar haqqında məlumat çıxarın*/

SELECT Authors.FirstName, AVG(Books.Pages) AS [AVERAGE OF PAGES]
FROM Authors
INNER JOIN Books ON Books.Id_Author = Authors.Id
GROUP BY Authors.FirstName, Authors.LastName
HAVING AVG(BOOKS.Pages) > 600


/*7. Display information about publishers, whose total number of pages of books published by them is more than 700.
7. Çap etdiyi bütün kitabların cəmi səhifə sayı 700dən çox olan Publisherlər haqqında ekrana məlumat çıxarın*/

SELECT Press.[Name], SUM(Books.Pages) AS [SUM OF PAGES]
FROM Press
INNER JOIN Books ON Books.Id_Press = Press.Id
GROUP BY Press.[Name]
HAVING SUM(Books.Pages) > 700


/*8. Display all visitors to the library (and students and teachers) and the books they took.
8. Kitabxananın bütün ziyarətçilərini və onların götürdüyü kitabları çıxarın.*/



/*9. Print the most popular author (s) among students and the number of books of this author taken in the library.
9. Studentlər arasında ən məşhur author(lar) və onun(ların) götürülmüş kitablarının sayını çıxarın.*/

SELECT
    CONCAT(Authors.[FirstName], Authors.[LastName]) AS [Author'S Full Name],
    COUNT(*) AS NumberOfBooksTaken
FROM
    S_Cards
JOIN Books ON S_Cards.Id_Book = Books.Id
JOIN Authors ON Books.Id_Author = Authors.Id
GROUP BY
    Authors.[FirstName], Authors.LastName
ORDER BY
    NumberOfBooksTaken DESC;


/*10. Print the most popular author (s) among the teachers and the number of books of this author taken in the library.
10. Tələbələr arasında ən məşhur author(lar) və onun(ların) götürülmüş kitablarının sayını çıxarın.*/

SELECT
    CONCAT(Authors.[FirstName], Authors.[LastName]) AS [Author'S Full Name],
    COUNT(*) AS [Number of Taken Books]
FROM
    T_Cards
JOIN Books ON T_Cards.Id_Book = Books.Id
JOIN Authors ON Books.Id_Author = Authors.Id
GROUP BY
    Authors.[FirstName], Authors.LastName
ORDER BY
    [Number of Taken Books] DESC;