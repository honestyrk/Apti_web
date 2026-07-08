-- seed_11_reasoning_batch1.sql
-- Continues the "every topic gets at least 25 questions" expansion, now
-- moving to Logical Reasoning. Covers the 2 topics that had zero
-- questions and are the most mechanical/formulaic to author reliably:
-- Direction Sense and Series Completion, 25 questions each.
-- Additive only; safe to run once after seed_10_quant_batch7.sql.

-- ============================================================
-- Logical Reasoning > Direction Sense
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A man walks 5 km north, then 3 km east. How far is he from the starting point?', '5 km', '5.5 km', '5.83 km', '6 km', 'c', 'Distance = sqrt(5^2+3^2) = sqrt(34) ~ 5.83 km.', 'medium'),
  ('A man walks 10 m north, turns right and walks 10 m, then turns right again and walks 10 m. In which direction is he now facing?', 'North', 'South', 'East', 'West', 'b', 'North -> (turn right) East -> (turn right) South.', 'medium'),
  ('A man starts walking south, turns left, walks some distance, then turns left again. In which direction is he walking now?', 'North', 'South', 'East', 'West', 'a', 'South -> (left) East -> (left) North.', 'medium'),
  ('Ravi walks 6 km east, then 8 km north. Find the distance between his starting point and current position.', '8 km', '9 km', '10 km', '12 km', 'c', 'Distance = sqrt(36+64) = sqrt(100) = 10 km.', 'medium'),
  ('A man faces east. He turns 90 degrees clockwise, then 180 degrees. Which direction does he face now?', 'North', 'South', 'East', 'West', 'a', 'East + 90 deg CW = South; + 180 deg = North.', 'medium'),
  ('A person walks 4 km west, then 3 km south. How far is he from the starting point?', '4 km', '4.5 km', '5 km', '5.5 km', 'c', 'Distance = sqrt(16+9) = 5 km.', 'medium'),
  ('Starting from a point, a man walks 12 m north, then 5 m west. Find his distance from the starting point.', '11 m', '12 m', '13 m', '14 m', 'c', 'Distance = sqrt(144+25) = 13 m.', 'medium'),
  ('A man is facing north. He turns 45 degrees clockwise and then another 90 degrees clockwise. Which direction is he facing?', 'North-East', 'South-East', 'South-West', 'North-West', 'b', 'North + 45 deg = NE; + 90 deg = SE.', 'medium'),
  ('Two persons A and B start from the same point. A walks 3 km north and B walks 4 km east. Find the distance between them.', '4 km', '4.5 km', '5 km', '5.5 km', 'c', 'Distance = sqrt(9+16) = 5 km.', 'medium'),
  ('A man walks 8 km south, then turns right and walks 6 km. How far is he from the starting point?', '8 km', '9 km', '10 km', '12 km', 'c', 'Distance = sqrt(64+36) = 10 km.', 'medium'),
  ('Facing south, a man turns left. Which direction is he now facing?', 'North', 'South', 'East', 'West', 'c', 'South -> (left, counterclockwise) East.', 'easy'),
  ('A man walks 15 m east and then 15 m north. In which direction is his starting point from his current position?', 'North-East', 'South-East', 'South-West', 'North-West', 'c', 'He is north-east of the start, so the start is south-west of him.', 'medium'),
  ('A person starts from point A, walks 10 km north to B, then 10 km east to C. Find the direction of C from A.', 'North', 'North-East', 'East', 'South-East', 'b', 'Moving north then east places C to the north-east of A.', 'medium'),
  ('A man walks 2 km north, 3 km east, then 2 km south. Find his position relative to the starting point.', '2 km north', '3 km east', '3 km west', '5 km east', 'b', 'The north and south legs cancel, leaving 3 km east.', 'medium'),
  ('If south-east becomes north, and north-east becomes west, what does south become?', 'North-East', 'South-East', 'North-West', 'South-West', 'a', 'The consistent rotation that maps SE to N and NE to W also maps South to North-East.', 'hard'),
  ('A man walks 1 km east, then turns left and walks 1 km, then turns left and walks 1 km, then turns left again and walks 1 km. Where is he now relative to the start?', '1 km east', '1 km north', 'At the starting point', '1 km west', 'c', 'Four equal-length left turns of 90 degrees trace a square back to the start.', 'medium'),
  ('A person walks 20 m south, then 10 m east, then 20 m north. Find his position relative to the start.', '10 m east', '10 m west', '10 m north', '10 m south', 'a', 'The north and south legs cancel, leaving 10 m east.', 'medium'),
  ('Facing north, if you turn 270 degrees clockwise, which direction do you face?', 'North', 'South', 'East', 'West', 'd', 'North + 270 deg CW = West.', 'medium'),
  ('Town B is east of town A. Town C is south of town B. In which direction is town C from town A?', 'North', 'South', 'South-East', 'North-West', 'c', 'Moving east then south places C south-east of A.', 'medium'),
  ('A man walks 7 km north and then 7 km west. Find the direction of the starting point from his current position.', 'North-East', 'South-East', 'South-West', 'North-West', 'b', 'He is north-west of the start, so the start is south-east of him.', 'medium'),
  ('If west becomes north (a consistent 90-degree rotation), what does north become?', 'East', 'West', 'South', 'North', 'a', 'The same 90-degree clockwise rotation that maps west to north maps north to east.', 'hard'),
  ('A man walks 5 km towards south, then turns to his right. Which direction is he moving in now?', 'North', 'South', 'East', 'West', 'd', 'South -> (right, clockwise) West.', 'easy'),
  ('Towns X and Y are 10 km apart, with Y directly north of X. Town Z is 10 km east of Y. Find the distance between X and Z.', '10 km', '12 km', '14.14 km', '15 km', 'c', 'Distance = sqrt(10^2+10^2) ~ 14.14 km.', 'medium'),
  ('A man walks 4 km east, then 3 km north, from his house to his office. Find the shortest distance between them.', '4 km', '5 km', '6 km', '7 km', 'b', 'Distance = sqrt(16+9) = 5 km.', 'easy'),
  ('Facing east, a man turns anticlockwise by 135 degrees. Which direction is he now facing?', 'North-East', 'South-East', 'South-West', 'North-West', 'd', 'East minus 135 degrees (counterclockwise) lands on North-West.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'direction-sense';

-- ============================================================
-- Logical Reasoning > Series Completion
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the next term: 2, 4, 6, 8, 10, ?', '11', '12', '13', '14', 'b', 'The series increases by 2 each time: 12.', 'easy'),
  ('Find the next term: 1, 3, 5, 7, 9, ?', '10', '11', '12', '13', 'b', 'The series of odd numbers continues with 11.', 'easy'),
  ('Find the next letter: A, C, E, G, ?', 'H', 'I', 'J', 'K', 'b', 'Each letter skips one: I follows G.', 'easy'),
  ('Find the next term: 3, 9, 27, 81, ?', '162', '200', '243', '270', 'c', 'Each term is multiplied by 3: 243.', 'medium'),
  ('Find the missing term: 5, 10, 20, 40, ?, 160.', '60', '70', '80', '90', 'c', 'Each term doubles: 80.', 'medium'),
  ('Find the next term: 1, 1, 2, 3, 5, 8, ?', '11', '12', '13', '14', 'c', 'This is the Fibonacci sequence; the next term is 13.', 'medium'),
  ('Find the next letter: B, D, F, H, ?', 'I', 'J', 'K', 'L', 'b', 'Each letter skips one: J follows H.', 'easy'),
  ('Find the next term: 100, 90, 80, 70, ?', '50', '55', '60', '65', 'c', 'The series decreases by 10 each time: 60.', 'easy'),
  ('Find the next term: 2, 6, 12, 20, 30, ?', '40', '42', '44', '46', 'b', 'Differences increase by 2 each time (4,6,8,10,12): 30+12 = 42.', 'medium'),
  ('Find the missing number: 4, 9, 16, 25, ?, 49.', '30', '32', '34', '36', 'd', 'These are perfect squares (2^2..7^2); the missing term is 36.', 'medium'),
  ('Find the next term: 7, 14, 21, 28, ?', '32', '33', '34', '35', 'd', 'The series increases by 7 each time: 35.', 'easy'),
  ('Find the next letter: Z, Y, X, W, ?', 'U', 'V', 'W', 'T', 'b', 'The letters go backward one at a time: V follows W.', 'easy'),
  ('Find the next term: 1, 4, 9, 16, 25, ?', '30', '32', '34', '36', 'd', 'These are perfect squares; the next is 36.', 'easy'),
  ('Find the next term: 2, 3, 5, 8, 12, ?', '15', '16', '17', '18', 'c', 'Differences increase by 1 each time (1,2,3,4,5): 12+5 = 17.', 'medium'),
  ('Find the missing term: 10, 15, ?, 25, 30.', '18', '19', '20', '22', 'c', 'The series increases by 5 each time: 20.', 'easy'),
  ('Find the next term: 3, 6, 11, 18, 27, ?', '36', '37', '38', '39', 'c', 'Differences increase by 2 each time (3,5,7,9,11): 27+11 = 38.', 'medium'),
  ('Find the next term in the pattern: AZ, BY, CX, ?', 'DV', 'DW', 'EW', 'DX', 'b', 'The first letter advances (A,B,C,D...) while the second retreats (Z,Y,X,W...).', 'medium'),
  ('Find the next term: 5, 11, 17, 23, ?', '27', '28', '29', '30', 'c', 'The series increases by 6 each time: 29.', 'easy'),
  ('Find the next term: 2, 4, 8, 16, 32, ?', '60', '62', '64', '66', 'c', 'Each term doubles: 64.', 'easy'),
  ('Find the next term: 1, 8, 27, 64, ?', '100', '110', '125', '130', 'c', 'These are perfect cubes (1^3..5^3); the next is 125.', 'medium'),
  ('Find the missing number: 6, 13, 20, 27, ?, 41.', '32', '33', '34', '35', 'c', 'The series increases by 7 each time: 34.', 'easy'),
  ('Find the next letter: M, O, Q, S, ?', 'T', 'U', 'V', 'W', 'b', 'Each letter skips one: U follows S.', 'easy'),
  ('Find the next term: 80, 70, 61, 53, ?', '44', '45', '46', '48', 'c', 'Differences decrease by 1 each time (-10,-9,-8,-7): 53-7 = 46.', 'medium'),
  ('Find the next term: 2, 5, 11, 23, 47, ?', '90', '92', '94', '95', 'd', 'Each term follows x2+1: 47x2+1 = 95.', 'medium'),
  ('Find the next term: 1, 2, 6, 24, 120, ?', '600', '700', '720', '750', 'c', 'This is the factorial sequence (1!,2!,3!,4!,5!,6!); the next term is 720.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'series-completion';
