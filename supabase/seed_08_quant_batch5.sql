-- seed_08_quant_batch5.sql
-- Continues the "every topic gets at least 25 questions" expansion.
-- Tops up 4 more Quantitative Aptitude topics (each originally seeded
-- with 6 questions in seed_03) with 19 more each to reach 25:
-- Permutation and Combination, Problems on H.C.F and L.C.M, Decimal
-- Fraction, Simplification. Additive only; safe to run once after
-- seed_07_quant_batch4.sql.

-- ============================================================
-- Quantitative Aptitude > Permutation and Combination (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('In how many ways can 5 people be seated in a row?', '100', '110', '120', '130', 'c', '5! = 120.', 'easy'),
  ('How many ways can the letters of the word "APPLE" be arranged?', '50', '55', '60', '65', 'c', '5 letters with P repeated twice: 5!/2! = 60.', 'medium'),
  ('In how many ways can a president and a vice-president be chosen from 8 people?', '48', '52', '56', '60', 'c', '8P2 = 8x7 = 56.', 'medium'),
  ('How many 4-letter words can be formed from the letters of "NUMBER" without repetition?', '320', '340', '360', '380', 'c', '6P4 = 6x5x4x3 = 360.', 'medium'),
  ('In how many ways can 3 boys and 2 girls be arranged in a row such that both girls sit together?', '36', '42', '48', '52', 'c', 'Treat the girls as one unit: 4 units arrange in 4! ways, girls arrange among themselves in 2! ways: 24x2 = 48.', 'hard'),
  ('How many diagonals does a hexagon have?', '6', '8', '9', '12', 'c', 'Diagonals = n(n-3)/2 = 6x3/2 = 9.', 'medium'),
  ('In how many ways can 6 different books be distributed among 2 students so that each gets 3?', '15', '18', '20', '24', 'c', 'C(6,3) = 20 ways to choose the first student''s books.', 'medium'),
  ('How many ways can a committee of 4 be formed from 6 men and 4 women, if it must include exactly 2 women?', '80', '85', '90', '95', 'c', 'C(4,2) x C(6,2) = 6 x 15 = 90.', 'medium'),
  ('Find the number of ways to arrange the letters of the word "MISSISSIPPI".', '32000', '33000', '34650', '35000', 'c', '11 letters with M-1, I-4, S-4, P-2: 11!/(4!4!2!) = 34650.', 'hard'),
  ('How many ways can 4 different colored balls be placed in 4 different boxes, one ball per box?', '16', '20', '24', '28', 'c', '4! = 24.', 'easy'),
  ('In how many ways can a cricket team of 11 be selected from 15 players?', '1300', '1350', '1365', '1400', 'c', 'C(15,11) = C(15,4) = 1365.', 'hard'),
  ('How many 3-digit even numbers can be formed using digits 1,2,3,4,5 without repetition?', '20', '22', '24', '26', 'c', 'Last digit must be 2 or 4; remaining two digits chosen in 4P2=12 ways each: 2x12 = 24.', 'hard'),
  ('In how many ways can 5 different flags be arranged on a pole to form a signal, using all 5?', '100', '110', '120', '130', 'c', '5! = 120.', 'easy'),
  ('How many ways can 2 prizes be distributed among 5 students if no student gets more than one prize?', '15', '18', '20', '25', 'c', '5P2 = 5x4 = 20.', 'medium'),
  ('Find the number of ways to select 3 letters from the word "EQUATION" (8 distinct letters).', '48', '52', '56', '60', 'c', 'C(8,3) = 56.', 'medium'),
  ('In how many ways can 4 men and 4 women be seated in a row such that men and women alternate?', '1000', '1100', '1152', '1200', 'c', '2 alternating patterns x 4! x 4! = 2x24x24 = 1152.', 'hard'),
  ('How many ways can a group of 3 be selected from 7 people if a particular person must always be included?', '10', '12', '15', '18', 'c', 'The remaining 2 are chosen from 6: C(6,2) = 15.', 'medium'),
  ('Find the value of 6!/3!.', '100', '110', '120', '130', 'c', '720/6 = 120.', 'easy'),
  ('In how many ways can the letters of the word "BALLOON" be arranged?', '1200', '1220', '1260', '1280', 'c', '7 letters with L-2, O-2: 7!/(2!2!) = 1260.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'permutations-and-combinations';

-- ============================================================
-- Quantitative Aptitude > Problems on H.C.F and L.C.M (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the HCF of 48 and 60.', '6', '8', '12', '16', 'c', 'The highest common factor of 48 and 60 is 12.', 'easy'),
  ('Find the LCM of 15 and 25.', '50', '60', '75', '80', 'c', 'The least common multiple of 15 and 25 is 75.', 'easy'),
  ('Find the HCF of 36, 60, and 84.', '6', '8', '12', '16', 'c', 'The HCF of 36, 60, and 84 is 12.', 'medium'),
  ('Find the LCM of 8, 12, and 15.', '100', '110', '120', '130', 'c', 'The LCM of 8, 12, and 15 is 120.', 'medium'),
  ('Two numbers have HCF 8 and LCM 96. If one number is 24, find the other.', '28', '30', '32', '36', 'c', 'Other number = (HCF x LCM)/first = (8x96)/24 = 32.', 'medium'),
  ('Find the greatest number that divides 48 and 60 exactly.', '6', '8', '12', '16', 'c', 'This is the HCF of 48 and 60, which is 12.', 'easy'),
  ('Find the smallest number which, when divided by 12, 15, and 20, leaves no remainder.', '40', '50', '60', '80', 'c', 'This is the LCM of 12, 15, and 20, which is 60.', 'medium'),
  ('Find the HCF of 84 and 126.', '36', '40', '42', '44', 'c', 'The HCF of 84 and 126 is 42.', 'medium'),
  ('The LCM of two numbers is 180 and their HCF is 6. If one number is 36, find the other.', '24', '28', '30', '32', 'c', 'Other number = (6x180)/36 = 30.', 'medium'),
  ('Find the smallest number that leaves a remainder of 3 when divided by 4, 5, and 6.', '60', '61', '63', '65', 'c', 'LCM(4,5,6) = 60; smallest number = 60+3 = 63.', 'hard'),
  ('Find the LCM of 5, 10, and 15.', '20', '25', '30', '35', 'c', 'The LCM of 5, 10, and 15 is 30.', 'easy'),
  ('Two numbers are in the ratio 5:6 and their HCF is 4. Find their LCM.', '100', '110', '120', '130', 'c', 'Numbers are 20 and 24; LCM = 120.', 'medium'),
  ('Find the HCF of 105 and 175.', '25', '30', '35', '40', 'c', 'The HCF of 105 and 175 is 35.', 'medium'),
  ('Three bells ring at intervals of 6, 8, and 12 minutes. If they ring together at 9:00 am, when will they next ring together?', '9:12 am', '9:20 am', '9:24 am', '9:30 am', 'c', 'LCM(6,8,12) = 24 minutes; next ring at 9:24 am.', 'medium'),
  ('Find the LCM of 9 and 12.', '24', '30', '36', '40', 'c', 'The LCM of 9 and 12 is 36.', 'easy'),
  ('Find the HCF of 72 and 120.', '18', '20', '24', '28', 'c', 'The HCF of 72 and 120 is 24.', 'medium'),
  ('The product of the HCF and LCM of two numbers is 216. If one number is 12, find the other.', '15', '16', '18', '20', 'c', 'Product of HCF and LCM equals the product of the two numbers, so the other = 216/12 = 18.', 'medium'),
  ('Find the smallest 4-digit number exactly divisible by 12, 15, and 18.', '1000', '1040', '1080', '1100', 'c', 'LCM(12,15,18) = 180; the smallest 4-digit multiple of 180 is 1080.', 'hard'),
  ('Find the LCM of 14 and 21.', '28', '35', '42', '48', 'c', 'The LCM of 14 and 21 is 42.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'problems-on-hcf-lcm';

-- ============================================================
-- Quantitative Aptitude > Decimal Fraction (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Simplify: 1.5 + 2.25.', '3.5', '3.65', '3.75', '3.85', 'c', '1.5 + 2.25 = 3.75.', 'easy'),
  ('Convert 7/20 to a decimal.', '0.3', '0.35', '0.4', '0.45', 'b', '7 divided by 20 = 0.35.', 'easy'),
  ('Simplify: 0.75 - 0.25.', '0.4', '0.45', '0.5', '0.55', 'c', '0.75 - 0.25 = 0.5.', 'easy'),
  ('Simplify: 3.6 x 2.', '6.8', '7.0', '7.2', '7.4', 'c', '3.6 x 2 = 7.2.', 'easy'),
  ('Simplify: 9.6 / 0.4.', '20', '22', '24', '26', 'c', '9.6/0.4 = 24.', 'easy'),
  ('Convert 0.125 to a fraction in simplest form.', '1/6', '1/7', '1/8', '1/9', 'c', '0.125 = 1/8.', 'medium'),
  ('Simplify: 0.04 x 0.05.', '0.001', '0.002', '0.02', '0.2', 'b', '0.04 x 0.05 = 0.002.', 'medium'),
  ('Simplify: 5 - 1.75.', '3.0', '3.15', '3.25', '3.5', 'c', '5 - 1.75 = 3.25.', 'easy'),
  ('Which is greater: 0.6 or 0.58?', '0.6', '0.58', 'Equal', 'Cannot say', 'a', '0.60 > 0.58.', 'easy'),
  ('Simplify: (0.3)^3.', '0.09', '0.027', '0.27', '0.9', 'b', '(0.3)^3 = 0.027.', 'medium'),
  ('Simplify: 100 x 0.001.', '0.001', '0.01', '0.1', '1', 'c', '100 x 0.001 = 0.1.', 'easy'),
  ('Convert 5/8 to a decimal.', '0.6', '0.615', '0.625', '0.65', 'c', '5 divided by 8 = 0.625.', 'easy'),
  ('Simplify: 15.75 + 4.25.', '19.5', '19.75', '20', '20.25', 'c', '15.75 + 4.25 = 20.', 'easy'),
  ('Simplify: 0.9 / 0.03.', '25', '28', '30', '33', 'c', '0.9/0.03 = 30.', 'medium'),
  ('Simplify: 2.5 x 2.5.', '6', '6.15', '6.25', '6.5', 'c', '2.5 x 2.5 = 6.25.', 'easy'),
  ('Convert 0.45 to a fraction in simplest form.', '9/20', '4/9', '9/25', '3/20', 'a', '0.45 = 45/100 = 9/20.', 'medium'),
  ('Simplify: 1 - 0.001.', '0.99', '0.991', '0.999', '1.001', 'c', '1 - 0.001 = 0.999.', 'easy'),
  ('Simplify: 0.008 / 0.02.', '0.04', '0.4', '4', '40', 'b', '0.008/0.02 = 0.4.', 'medium'),
  ('Simplify: (0.1 + 0.2) x 10.', '2', '2.5', '3', '3.5', 'c', '(0.1+0.2) x 10 = 0.3 x 10 = 3.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'decimal-fraction';

-- ============================================================
-- Quantitative Aptitude > Simplification (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Simplify: 20 - 4 x 3.', '6', '7', '8', '48', 'c', '4x3=12 first; 20-12=8.', 'easy'),
  ('Simplify: (15 - 5) x 2.', '15', '18', '20', '22', 'c', '(15-5)=10; 10x2=20.', 'easy'),
  ('Simplify: 36 / 6 x 2.', '3', '6', '9', '12', 'd', 'Left to right: 36/6=6, then 6x2=12.', 'medium'),
  ('Simplify: 50 - 20 / 4.', '7.5', '40', '45', '50', 'c', '20/4=5 first; 50-5=45.', 'easy'),
  ('Simplify: 5 x (6 + 4) - 10.', '30', '35', '40', '50', 'c', '6+4=10; 5x10=50; 50-10=40.', 'medium'),
  ('Simplify: 2/3 + 1/6.', '1/2', '2/3', '5/6', '1', 'c', '4/6+1/6 = 5/6.', 'medium'),
  ('Simplify: 7 - 2 x 3 + 4.', '3', '5', '7', '15', 'b', '2x3=6 first; 7-6+4=5.', 'medium'),
  ('Simplify: (25 - 5) / (2 + 2).', '4', '5', '6', '10', 'b', '20/4 = 5.', 'easy'),
  ('Simplify: 3 x 3 + 3 x 3.', '12', '15', '18', '36', 'c', '9+9=18.', 'easy'),
  ('Simplify: 1/2 of (8 + 12).', '8', '9', '10', '12', 'c', '(8+12)=20; half of 20 = 10.', 'easy'),
  ('Simplify: 90 / (3 x 3).', '9', '10', '15', '30', 'b', '3x3=9; 90/9=10.', 'easy'),
  ('Simplify: 4 + 4 x 4 - 4.', '12', '14', '16', '28', 'c', '4x4=16; 4+16-4=16.', 'medium'),
  ('Simplify: 2/5 x 5/8.', '1/5', '1/4', '1/3', '2/5', 'b', '(2x5)/(5x8) = 10/40 = 1/4.', 'medium'),
  ('Simplify: [(6 x 4) - (3 x 2)] / 3.', '4', '5', '6', '7', 'c', '(24-6)/3 = 18/3 = 6.', 'medium'),
  ('Simplify: 5^2 - 3^2.', '12', '14', '16', '18', 'c', '25-9=16.', 'easy'),
  ('Simplify: (100/10) x (10/5).', '10', '15', '20', '25', 'c', '10 x 2 = 20.', 'easy'),
  ('Simplify: 3 + 3 x 3 - 3/3.', '9', '10', '11', '12', 'c', '3x3=9, 3/3=1; 3+9-1=11.', 'medium'),
  ('Simplify: 1/4 + 1/4 + 1/2.', '3/4', '7/8', '1', '5/4', 'c', '1/4+1/4+1/2 = 1.', 'easy'),
  ('Simplify: 8 x [5 + (6 - 2)].', '64', '68', '72', '76', 'c', '6-2=4; 5+4=9; 8x9=72.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'simplification';
