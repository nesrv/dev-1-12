CREATE TABLE authors(
    author_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    last_name text NOT NULL,
    first_name text NOT NULL,
    middle_name text
);

CREATE TABLE books(
    book_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title text NOT NULL
);

CREATE TABLE authorship(
    book_id integer REFERENCES books,
    author_id integer REFERENCES authors,
    seq_num integer NOT NULL,
    PRIMARY KEY (book_id,author_id)
);

CREATE TABLE operations(
    operation_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    book_id integer NOT NULL REFERENCES books,
    qty_change integer NOT NULL,
    date_created date NOT NULL DEFAULT current_date
);

INSERT INTO authors(last_name, first_name, middle_name)
VALUES 
    ('Пушкин', 'Александр', 'Сергеевич'),
    ('Тургенев', 'Иван', 'Сергеевич'),
    ('Стругацкий', 'Борис', 'Натанович'),
    ('Стругацкий', 'Аркадий', 'Натанович'),
    ('Толстой', 'Лев', 'Николаевич'),
    ('Свифт', 'Джонатан', NULL);

INSERT INTO books(title)
VALUES
    ('Сказка о царе Салтане'),
    ('Муму'),
    ('Трудно быть богом'),
    ('Война и мир'),
    ('Путешествия в некоторые удаленные страны мира в четырех частях: сочинение Лемюэля Гулливера, сначала хирурга, а затем капитана нескольких кораблей'),
    ('Хрестоматия');


INSERT INTO authorship(book_id, author_id, seq_num) 
VALUES
    (1, 1, 1),
    (2, 2, 1),
    (3, 3, 2),
    (3, 4, 1),
    (4, 5, 1),
    (5, 6, 1),
    (6, 1, 1),
    (6, 5, 2),
    (6, 2, 3);


-- все книги Пушкина

select b.title
from books b
join authorship a on a.book_id = b.book_id
join authors au on au.author_id = a.author_id
where au.last_name = 'Пушкин';


-- всех авторов книги 'Трудно быть богом'

SELECT last_name, first_name
FROM authors
NATURAL JOIN authorship
NATURAL JOIN books
WHERE title = 'Трудно быть богом';

-- склей авторов книги 'Трудно быть богом' в одну строчку с помощью string_agg в запросе

SELECT title, string_agg(last_name || ' ' || first_name, ', ' ) AS authors
FROM books
NATURAL JOIN authorship
NATURAL JOIN authors
WHERE title = 'Трудно быть богом'
GROUP BY title;
