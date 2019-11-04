PREPARE stmt From 'Select \'nauka\' as kategoria, nazwa From nauka Union
Select \'sport\' as kategoria, nazwa From sport Union
Select \'inne\' as kategoria, nazwa From inne';

EXECUTE stmt;
DEALLOCATE PREPARE stmt;
