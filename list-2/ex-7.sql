

Drop PROCEDURE IF EXISTS fill_out_random;

DELIMITER $$
CREATE PROCEDURE fill_out_random(IN name VARCHAR(255), num INT)
BEGIN
    DECLARE iterator INT DEFAULT 0;

    DECLARE columnName VARCHAR(255);

    DECLARE columns CURSOR FOR
        SELECT column_name
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE table_name = name
        ORDER BY ordinal_position;

    WHILE iterator < num
        DO
            SET @query = CONCAT('Show Columns From ', name);
            PREPARE stmt From @query;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
            SET iterator = iterator + 1;
        end WHILE;
END
$$
DELIMITER ;