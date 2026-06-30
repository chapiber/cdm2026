-- Score aux tirs au but pronostiqué en cas de nul (phases finales à élimination directe)

ALTER TABLE PORTAIL_CLUB_cdm_predictions
  ADD COLUMN pred_pen_home TINYINT UNSIGNED NULL DEFAULT NULL AFTER pred_winner,
  ADD COLUMN pred_pen_away TINYINT UNSIGNED NULL DEFAULT NULL AFTER pred_pen_home;
