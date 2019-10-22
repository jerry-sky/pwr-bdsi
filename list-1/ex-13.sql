Select
  *
From
  pet
Where
  birth = (
    Select
      Min(`birth`)
    From
      pet
    Where
      death is null
  );