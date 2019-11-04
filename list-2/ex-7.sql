DELIMITER $$
CREATE OR REPLACE FUNCTION generate_random_string(length INT) Returns VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE iterator INT DEFAULT 0;
    DECLARE output VARCHAR(255) DEFAULT '';
    While iterator < length
        DO
            SET output = concat(
                    output,
                    substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', rand() * 25 + 1, 1)
                );
            SET iterator = iterator + 1;
        end while;
    RETURN output;
END $$

CREATE OR REPLACE FUNCTION generate_random_date(a date, b date) RETURNS Date DETERMINISTIC
BEGIN
    RETURN FROM_UNIXTIME(UNIX_TIMESTAMP(a) + (UNIX_TIMESTAMP(b) - UNIX_TIMESTAMP(a)) * rand());
end $$

Drop PROCEDURE IF EXISTS fill_out_random;

CREATE PROCEDURE fill_out_random(IN name VARCHAR(255), num INT)
BEGIN
    DECLARE iterator INT DEFAULT 0;
    DECLARE query_values TEXT DEFAULT '';

    CASE name
        WHEN 'osoba' THEN SET query_values = '(imię, nazwisko, dataUrodzenia, plec) VALUES (?, ?, ?, ?)';
        WHEN 'hobby' THEN SET query_values = '(osoba, typ) VALUES (?, ?)';
        WHEN 'inne' THEN SET query_values = '(nazwa, lokacja, towarzysze) VALUES (?, ?, ?)';
        WHEN 'nauka' THEN SET query_values = '(nazwa, lokacja) VALUES (?, ?)';
        WHEN 'sport' THEN SET query_values = '(nazwa, typ, lokacja) VALUES (?, ?, ?)';
        END CASE;

    WHILE iterator < num
        DO
            SET @query = CONCAT('Insert Into ', name, ' ', query_values);
            PREPARE stmt From @query;
            Set @random_string_1 = generate_random_string(7);
            Set @random_string_2 = generate_random_string(11);
            IF name = 'osoba' Then
                Set @random_date_1 = generate_random_date('1980-01-01', '1999-12-31');
            END IF;
            IF name = 'osoba' Then
                Set @random_gender = substring('fm', 1 + Round(rand()), 1);
            END IF;
            IF name = 'hobby' Then
                SET @osoba_min := (SELECT MIN(id) FROM osoba);
                SET @osoba_max := (SELECT MAX(id) FROM osoba);
                SET @osoba_random_id =
                        (Select id from osoba Where id >= FLOOR(@osoba_min + rand() * (@osoba_max - @osoba_min)) Limit 1);
                SET @random_hobby_type = ELT(1 + rand() * 2, 'sport', 'nauka', 'inne');
            END IF;
            IF name = 'inne' Then
                SET @inne_towarzysze = Round(rand());
            END IF;
            IF name = 'sport' Then
                SET @sport_typ = ELT(1 + rand() * 2, 'indywidualny', 'drużynowy', 'mieszany');
            END IF;
            CASE name
                WHEN 'osoba' THEN EXECUTE stmt using @random_string_1, @random_string_2, @random_date_1, @random_gender;
                WHEN 'hobby' THEN EXECUTE stmt using @osoba_random_id, @random_hobby_type;
                WHEN 'inne' THEN EXECUTE stmt using @random_string_1, @random_string_2, @inne_towarzysze;
                WHEN 'nauka' THEN EXECUTE stmt using @random_string_1, @random_string_2;
                WHEN 'sport' THEN EXECUTE stmt using @random_string_1, @sport_typ, @random_string_2;
                END CASE;
            DEALLOCATE PREPARE stmt;
            SET iterator = iterator + 1;
        end WHILE;
END
$$
DELIMITER ;