-- seed_03_remaining_topics.sql
-- Fills in sample MCQs for every topic that was created empty by
-- seed_02_expanded_topics.sql (19 Quantitative Aptitude topics, 4 Logical
-- Reasoning topics, 2 Data Interpretation topics), so every topic in the
-- app has practiceable content. Purely additive -- only inserts questions
-- for topics that don't yet have any -- safe to run once after
-- seed_02_expanded_topics.sql.

-- ============================================================
-- Quantitative Aptitude > Height and Distance
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('The angle of elevation of the top of a tower from a point 30 m away from its base is 45 degrees. Find the height of the tower.', '20 m', '25 m', '30 m', '35 m', 'c', 'tan 45 deg = 1, so height = base distance = 30 m.', 'easy'),
  ('A ladder 10 m long leans against a wall making an angle of 60 degrees with the ground. How high up the wall does the ladder reach? (sin 60 deg = 0.866)', '7 m', '7.5 m', '8.66 m', '9 m', 'c', 'Height = 10 x sin 60 deg = 10 x 0.866 = 8.66 m.', 'medium'),
  ('The angle of elevation of the sun is 30 degrees. Find the length of the shadow cast by a pole 15 m high. (tan 30 deg = 1/1.732)', '15 m', '20 m', '26 m', '30 m', 'c', 'Shadow = height x sqrt(3) = 15 x 1.732 = 25.98 ~ 26 m.', 'medium'),
  ('Two poles of height 6 m and 11 m stand on level ground 12 m apart. Find the distance between their tops.', '11 m', '12 m', '13 m', '14 m', 'c', 'Distance = sqrt((11-6)^2 + 12^2) = sqrt(25+144) = sqrt(169) = 13 m.', 'medium'),
  ('From the top of a 100 m high cliff, the angle of depression of a boat is 30 degrees. Find the distance of the boat from the base of the cliff. (tan 30 deg = 1/1.732)', '150 m', '160 m', '173.2 m', '180 m', 'c', 'Distance = 100/tan 30 deg = 100 x 1.732 = 173.2 m.', 'hard'),
  ('If the angle of elevation of the top of a tower from a point on the ground is such that tan(theta) = sqrt(3), find theta.', '30 deg', '45 deg', '60 deg', '75 deg', 'c', 'tan(theta) = sqrt(3) corresponds to theta = 60 degrees.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'height-and-distance';

-- ============================================================
-- Quantitative Aptitude > Calendar
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('What day of the week was 1st January 2000?', 'Friday', 'Saturday', 'Sunday', 'Monday', 'b', '1st January 2000 fell on a Saturday.', 'medium'),
  ('If today is Monday, what day will it be after 65 days?', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'b', '65 mod 7 = 2, so Monday + 2 days = Wednesday.', 'easy'),
  ('How many odd days are there in 100 years?', '3', '4', '5', '6', 'c', '100 years = 24 leap + 76 ordinary years = 48+76 = 124 days = 17 weeks + 5 days, so 5 odd days.', 'hard'),
  ('If 1st March 2021 was a Monday, what day was 1st March 2022?', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'b', '2021 is not a leap year, so exactly 365 days = 52 weeks + 1 day passed: Monday + 1 = Tuesday.', 'medium'),
  ('Which of the following years is a leap year?', '1900', '2000', '2100', '2200', 'b', 'A century year is a leap year only if divisible by 400. 2000/400 = 5 exactly, so 2000 is a leap year; 1900, 2100, 2200 are not.', 'medium'),
  ('How many odd days are there in a leap year?', '1', '2', '3', '4', 'b', 'A leap year has 366 days = 52 weeks + 2 days, so 2 odd days.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'calendars';

-- ============================================================
-- Quantitative Aptitude > Clock
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('What is the angle between the hour and minute hands of a clock at 3:00?', '60 deg', '75 deg', '90 deg', '105 deg', 'c', 'At 3:00 the minute hand is at 12 and the hour hand at 3, which is a quarter of the clock face: 90 degrees.', 'easy'),
  ('At what time between 4 and 5 o''clock will the hour and minute hands of a clock coincide?', '21 9/11 min past 4', '20 min past 4', '24 min past 4', '16 4/11 min past 4', 'a', 'Using the standard coincidence formula, the hands coincide at 21 9/11 minutes past 4.', 'hard'),
  ('How many times do the hands of a clock coincide in a 24-hour day?', '20', '21', '22', '24', 'c', 'The hands of a clock coincide 22 times in a 24-hour period.', 'medium'),
  ('What is the angle between the hour and minute hands of a clock at 6:30?', '0 deg', '10 deg', '15 deg', '20 deg', 'c', 'At 6:30 the hour hand is at 195 deg and the minute hand at 180 deg, a difference of 15 degrees.', 'medium'),
  ('What is the angle between the hour and minute hands at 8:00?', '100 deg', '110 deg', '120 deg', '130 deg', 'c', 'At 8:00 the hour hand is at 240 deg and the minute hand at 0 deg; the smaller angle is 360-240 = 120 degrees.', 'medium'),
  ('How many times in a day are the hands of a clock at right angles (90 degrees)?', '22', '44', '48', '66', 'b', 'The hands of a clock are at right angles 44 times in a 24-hour day.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'clocks';

-- ============================================================
-- Quantitative Aptitude > Area
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the area of a rectangle with length 12 cm and breadth 8 cm.', '80 cm2', '88 cm2', '96 cm2', '104 cm2', 'c', 'Area = length x breadth = 12 x 8 = 96 cm2.', 'easy'),
  ('Find the area of a square with side 15 cm.', '200 cm2', '210 cm2', '225 cm2', '240 cm2', 'c', 'Area = side^2 = 15^2 = 225 cm2.', 'easy'),
  ('Find the area of a triangle with base 10 cm and height 6 cm.', '24 cm2', '28 cm2', '30 cm2', '32 cm2', 'c', 'Area = (1/2) x base x height = (1/2) x 10 x 6 = 30 cm2.', 'easy'),
  ('Find the area of a circle with radius 7 cm. (use pi = 22/7)', '144 cm2', '150 cm2', '154 cm2', '160 cm2', 'c', 'Area = pi x r^2 = 22/7 x 49 = 154 cm2.', 'medium'),
  ('The length of a rectangle is increased by 20% and the breadth is decreased by 20%. What is the effect on its area?', '4% increase', '4% decrease', 'No change', '8% decrease', 'b', 'New area factor = 1.2 x 0.8 = 0.96, a 4% decrease.', 'hard'),
  ('Find the area of a parallelogram with base 14 cm and height 5 cm.', '60 cm2', '65 cm2', '70 cm2', '75 cm2', 'c', 'Area = base x height = 14 x 5 = 70 cm2.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'area';

-- ============================================================
-- Quantitative Aptitude > Volume and Surface Area
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the volume of a cube with side 5 cm.', '100 cm3', '110 cm3', '125 cm3', '130 cm3', 'c', 'Volume = side^3 = 5^3 = 125 cm3.', 'easy'),
  ('Find the volume of a cuboid with dimensions 6 cm x 4 cm x 3 cm.', '60 cm3', '66 cm3', '72 cm3', '78 cm3', 'c', 'Volume = 6 x 4 x 3 = 72 cm3.', 'easy'),
  ('Find the total surface area of a cube with side 6 cm.', '196 cm2', '206 cm2', '216 cm2', '226 cm2', 'c', 'Total surface area = 6 x side^2 = 6 x 36 = 216 cm2.', 'medium'),
  ('Find the volume of a cylinder with radius 7 cm and height 10 cm. (use pi = 22/7)', '1450 cm3', '1500 cm3', '1540 cm3', '1600 cm3', 'c', 'Volume = pi x r^2 x h = 22/7 x 49 x 10 = 1540 cm3.', 'medium'),
  ('Find the curved surface area of a cylinder with radius 7 cm and height 10 cm. (use pi = 22/7)', '400 cm2', '420 cm2', '440 cm2', '460 cm2', 'c', 'Curved surface area = 2 x pi x r x h = 2 x 22/7 x 7 x 10 = 440 cm2.', 'medium'),
  ('Find the volume of a sphere with radius 3 cm. (use pi = 22/7, volume = 4/3 x pi x r^3)', '100.5 cm3', '110.2 cm3', '113.1 cm3', '120.4 cm3', 'c', 'Volume = 4/3 x 22/7 x 27 = 2376/21 ~ 113.1 cm3.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'volume-and-surface-area';

-- ============================================================
-- Quantitative Aptitude > Permutation and Combination
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('In how many ways can the letters of the word "CAT" be arranged?', '3', '4', '6', '9', 'c', '3 distinct letters can be arranged in 3! = 6 ways.', 'easy'),
  ('How many ways can 3 people be selected from a group of 5?', '8', '9', '10', '12', 'c', 'C(5,3) = 10.', 'easy'),
  ('In how many ways can 4 distinct books be arranged on a shelf?', '16', '20', '24', '28', 'c', '4 distinct items can be arranged in 4! = 24 ways.', 'easy'),
  ('How many 3-digit numbers can be formed using digits 1,2,3,4,5 without repetition?', '50', '55', '60', '65', 'c', '5P3 = 5 x 4 x 3 = 60.', 'medium'),
  ('In how many ways can a committee of 3 men and 2 women be selected from 6 men and 4 women?', '100', '110', '120', '130', 'c', 'C(6,3) x C(4,2) = 20 x 6 = 120.', 'hard'),
  ('How many distinct arrangements are there of the letters of the word "LEVEL"?', '20', '24', '30', '60', 'c', '5 letters with L and E each repeated twice: 5!/(2! x 2!) = 120/4 = 30.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'permutations-and-combinations';

-- ============================================================
-- Quantitative Aptitude > Problems on H.C.F and L.C.M
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the H.C.F of 24 and 36.', '6', '8', '12', '18', 'c', 'The highest common factor of 24 and 36 is 12.', 'easy'),
  ('Find the L.C.M of 4 and 6.', '8', '10', '12', '24', 'c', 'The least common multiple of 4 and 6 is 12.', 'easy'),
  ('Find the H.C.F of 18, 24, and 30.', '2', '3', '6', '9', 'c', 'The highest common factor of 18, 24, and 30 is 6.', 'medium'),
  ('The product of two numbers is 216 and their H.C.F is 6. Find their L.C.M.', '24', '30', '36', '40', 'c', 'L.C.M = product / H.C.F = 216/6 = 36.', 'medium'),
  ('Find the L.C.M of 12, 15, and 20.', '40', '50', '60', '80', 'c', 'The least common multiple of 12, 15, and 20 is 60.', 'medium'),
  ('Two numbers are in the ratio 3:4 and their L.C.M is 48. Find the sum of the numbers.', '24', '26', '28', '30', 'c', 'Numbers = 3x, 4x with LCM = 12x = 48, so x = 4. Numbers are 12 and 16, sum = 28.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'problems-on-hcf-lcm';

-- ============================================================
-- Quantitative Aptitude > Decimal Fraction
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Simplify: 0.5 + 0.25', '0.65', '0.70', '0.75', '0.80', 'c', '0.5 + 0.25 = 0.75.', 'easy'),
  ('Convert 3/4 to a decimal.', '0.70', '0.72', '0.75', '0.80', 'c', '3 divided by 4 = 0.75.', 'easy'),
  ('Simplify: 2.5 x 0.4', '0.8', '0.9', '1.0', '1.2', 'c', '2.5 x 0.4 = 1.0.', 'easy'),
  ('Simplify: 12.6 / 0.3', '38', '40', '42', '45', 'c', '12.6 / 0.3 = 42.', 'medium'),
  ('What is 0.001 as a fraction?', '1/10', '1/100', '1/1000', '1/10000', 'c', '0.001 = 1/1000.', 'easy'),
  ('Simplify: (0.2)^2', '0.02', '0.04', '0.4', '4', 'b', '(0.2)^2 = 0.04.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'decimal-fraction';

-- ============================================================
-- Quantitative Aptitude > Simplification
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Simplify: 15 + 5 x 3', '30', '45', '60', '50', 'a', 'By order of operations, 5 x 3 = 15 first, then 15+15 = 30.', 'easy'),
  ('Simplify: (12 + 8) / 4', '3', '4', '5', '6', 'c', '(12+8)/4 = 20/4 = 5.', 'easy'),
  ('Simplify: 8 x 8 - 8 / 8', '56', '60', '63', '64', 'c', '8x8=64, 8/8=1, 64-1=63.', 'medium'),
  ('Simplify: 100 - [50 - (10 - 5)]', '45', '50', '55', '60', 'c', '10-5=5, 50-5=45, 100-45=55.', 'medium'),
  ('Simplify: 3/4 + 1/2', '1', '5/4', '3/2', '7/4', 'b', '3/4 + 2/4 = 5/4.', 'easy'),
  ('Simplify: 2 + 3 x (4 - 2)', '6', '7', '8', '10', 'c', '4-2=2, 3x2=6, 2+6=8.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'simplification';

-- ============================================================
-- Quantitative Aptitude > Square Root and Cube Root
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the square root of 144.', '10', '11', '12', '14', 'c', 'sqrt(144) = 12.', 'easy'),
  ('Find the cube root of 125.', '4', '5', '6', '7', 'b', 'cube root of 125 = 5, since 5^3 = 125.', 'easy'),
  ('Find the square root of 0.0081.', '0.09', '0.9', '0.009', '9', 'a', '0.09^2 = 0.0081, so sqrt(0.0081) = 0.09.', 'medium'),
  ('Find the value of sqrt(169) + sqrt(196).', '25', '26', '27', '28', 'c', 'sqrt(169) = 13, sqrt(196) = 14, sum = 27.', 'medium'),
  ('Find the cube root of 512.', '6', '7', '8', '9', 'c', 'cube root of 512 = 8, since 8^3 = 512.', 'medium'),
  ('Find the value of sqrt(50), correct to two decimal places.', '7.01', '7.07', '7.14', '7.21', 'b', 'sqrt(50) = 5 x sqrt(2) ~ 7.07.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'square-root-cube-root';

-- ============================================================
-- Quantitative Aptitude > Surds and Indices
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Simplify: 2^3 x 2^2', '16', '24', '32', '64', 'c', '2^3 x 2^2 = 2^5 = 32.', 'easy'),
  ('Simplify: (5^2)^3', '625', '3125', '15625', '78125', 'c', '(5^2)^3 = 5^6 = 15625.', 'medium'),
  ('Simplify: sqrt(8) x sqrt(2)', '2', '3', '4', '8', 'c', 'sqrt(8) x sqrt(2) = sqrt(16) = 4.', 'medium'),
  ('Simplify: 27^(1/3)', '2', '3', '9', '27', 'b', '27^(1/3) = 3, since 3^3 = 27.', 'easy'),
  ('Simplify: x^5 / x^2', 'x', 'x^2', 'x^3', 'x^7', 'c', 'x^5 / x^2 = x^(5-2) = x^3.', 'easy'),
  ('Simplify: 4^(3/2)', '6', '8', '12', '16', 'b', '4^(3/2) = (sqrt(4))^3 = 2^3 = 8.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'surds-and-indices';

-- ============================================================
-- Quantitative Aptitude > Chain Rule
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('If 6 men can build a wall in 10 days, how many days will 15 men take to build the same wall?', '3', '4', '5', '6', 'b', '6x10 = 60 man-days; 60/15 = 4 days.', 'easy'),
  ('If 12 workers can complete a job in 8 days, how many workers are needed to complete it in 6 days?', '14', '15', '16', '18', 'c', '12x8 = 96 worker-days; 96/6 = 16 workers.', 'medium'),
  ('A car travels 180 km in 3 hours. How far will it travel in 5 hours at the same speed?', '280 km', '290 km', '300 km', '320 km', 'c', 'Speed = 60 km/hr; distance in 5 hr = 300 km.', 'easy'),
  ('If the cost of 8 kg of rice is Rs. 320, find the cost of 15 kg of rice.', 'Rs. 560', 'Rs. 580', 'Rs. 600', 'Rs. 620', 'c', 'Rate = Rs. 40/kg; cost of 15 kg = 40x15 = Rs. 600.', 'easy'),
  ('If 5 pumps can empty a tank in 12 hours, how long will 6 pumps take?', '8 hr', '9 hr', '10 hr', '12 hr', 'c', '5x12 = 60 pump-hours; 60/6 = 10 hours.', 'medium'),
  ('20 workers can complete a task in 18 days. How many days will 15 workers take?', '20', '22', '24', '26', 'c', '20x18 = 360 worker-days; 360/15 = 24 days.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'chain-rule';

-- ============================================================
-- Quantitative Aptitude > Alligation or Mixture
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('In what ratio must tea worth Rs. 60/kg and Rs. 80/kg be mixed to get a mixture worth Rs. 70/kg?', '1:1', '2:1', '3:2', '1:2', 'a', 'By alligation: (80-70):(70-60) = 10:10 = 1:1.', 'medium'),
  ('A mixture of 40 liters contains milk and water in the ratio 3:1. How much water should be added to make the ratio 2:1?', '3 L', '4 L', '5 L', '6 L', 'c', 'Milk = 30 L, water = 10 L. For ratio 2:1, water needed = 15 L, so add 5 L.', 'hard'),
  ('In what ratio should rice at Rs. 40/kg be mixed with rice at Rs. 55/kg so the mixture costs Rs. 50/kg?', '1:2', '2:1', '3:1', '1:3', 'a', 'By alligation: (55-50):(50-40) = 5:10 = 1:2.', 'medium'),
  ('A vessel contains milk and water in the ratio 5:2. If the mixture contains 25 liters of milk, find the total quantity of the mixture.', '28 L', '30 L', '35 L', '40 L', 'c', 'Milk fraction = 5/7. Total = 25 / (5/7) = 35 L.', 'medium'),
  ('Two solutions of 20% and 50% alcohol are mixed to get 30 liters of a 35% alcohol solution. Find the quantity of the 20% solution used.', '10 L', '12 L', '15 L', '18 L', 'c', 'By alligation: (50-35):(35-20) = 15:15 = 1:1, so 15 L of each.', 'hard'),
  ('A trader mixes 26 kg of rice at Rs. 20/kg with 30 kg of rice at Rs. 36/kg. Find the approximate average price per kg of the mixture.', 'Rs. 26.5', 'Rs. 27.8', 'Rs. 28.57', 'Rs. 30', 'c', 'Total cost = 26x20 + 30x36 = 1600; total qty = 56; average = 1600/56 ~ 28.57.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'alligation-or-mixture';

-- ============================================================
-- Quantitative Aptitude > Logarithm
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the value of log base 10 of 100.', '1', '2', '3', '10', 'b', 'log10(100) = 2, since 10^2 = 100.', 'easy'),
  ('Find the value of log base 2 of 8.', '2', '3', '4', '8', 'b', 'log2(8) = 3, since 2^3 = 8.', 'easy'),
  ('Simplify: log10(10) + log10(10)', '1', '2', '10', '20', 'b', 'log10(10) = 1 for each term, so the sum is 2.', 'easy'),
  ('If log10(2) = 0.301, find log10(8).', '0.301', '0.602', '0.903', '1.204', 'c', 'log10(8) = 3 x log10(2) = 3 x 0.301 = 0.903.', 'medium'),
  ('Find the value of log base 5 of 1.', '0', '1', '5', 'Undefined', 'a', 'The logarithm of 1 to any valid base is always 0.', 'easy'),
  ('Simplify: log10(1000) - log10(10)', '1', '2', '3', '10', 'b', 'log10(1000) = 3, log10(10) = 1, difference = 2.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'logarithms';

-- ============================================================
-- Quantitative Aptitude > Races and Games
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('In a 100 m race, A''s speed is 10 m/s. Find the time A takes to finish the race.', '8 sec', '9 sec', '10 sec', '12 sec', 'c', 'Time = distance/speed = 100/10 = 10 seconds.', 'easy'),
  ('In a 400 m race, A finishes in 50 seconds and B finishes in 60 seconds. By how many meters does A win?', '60 m', '65 m', '66.7 m', '70 m', 'c', 'B''s speed = 400/60 m/s; in 50 sec B covers 333.3 m, so A wins by 400-333.3 = 66.7 m.', 'hard'),
  ('A can run 1 km in 5 minutes and B can run it in 6 minutes. By how much distance does A beat B in a 1 km race?', '150 m', '160 m', '166.7 m', '180 m', 'c', 'In 5 minutes, B covers 1000 x 5/6 = 833.3 m, so A beats B by 1000-833.3 = 166.7 m.', 'hard'),
  ('In a game of 100 points, A can give B 20 points and C 28 points. How many points can B give C in a game of 100?', '8', '10', '12', '15', 'b', 'When A scores 100, B scores 80 and C scores 72. For B=100, C = 100x72/80 = 90, so B gives C 10 points.', 'hard'),
  ('A and B run a 5 km race. A finishes in 20 minutes (speed 15 km/hr) and B finishes in 22 minutes. Find B''s speed.', '12 km/hr', '13 km/hr', '13.64 km/hr', '14 km/hr', 'c', 'B''s speed = 5 km / (22/60 hr) = 5 x 60/22 ~ 13.64 km/hr.', 'medium'),
  ('In a 1000 m race, A beats B by 100 m, and B beats C by 100 m. By how many meters does A beat C?', '180 m', '190 m', '200 m', '210 m', 'b', 'When B runs 1000 m, C runs 900 m, so when B runs 900 m, C runs 810 m. A beats C by 1000-810 = 190 m.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'races-and-games';

-- ============================================================
-- Quantitative Aptitude > Stocks and Shares
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the cost of a Rs. 100 share at a premium of Rs. 20.', 'Rs. 80', 'Rs. 100', 'Rs. 120', 'Rs. 140', 'c', 'Cost = face value + premium = 100 + 20 = Rs. 120.', 'easy'),
  ('A person buys a share of face value Rs. 100 at a discount of Rs. 10. Find the purchase price.', 'Rs. 80', 'Rs. 85', 'Rs. 90', 'Rs. 95', 'c', 'Purchase price = 100 - 10 = Rs. 90.', 'easy'),
  ('If a Rs. 100 share pays a 12% dividend, find the annual income from 50 such shares.', 'Rs. 500', 'Rs. 550', 'Rs. 600', 'Rs. 650', 'c', 'Income per share = Rs. 12; total = 50 x 12 = Rs. 600.', 'medium'),
  ('A man invests Rs. 4500 in Rs. 100 shares at a premium of Rs. 50. Find the number of shares he buys.', '25', '28', '30', '32', 'c', 'Price per share = Rs. 150; shares = 4500/150 = 30.', 'medium'),
  ('Find the income derived from investing Rs. 8000 in a 10% stock at 80.', 'Rs. 800', 'Rs. 900', 'Rs. 1000', 'Rs. 1200', 'c', 'Face value bought = 8000/80 x 100 = 10000; income = 10% of 10000 = Rs. 1000.', 'hard'),
  ('A person buys 20 shares of face value Rs. 100 at a premium of Rs. 25 each. Find the total investment.', 'Rs. 2000', 'Rs. 2250', 'Rs. 2500', 'Rs. 2750', 'c', 'Price per share = Rs. 125; total = 20 x 125 = Rs. 2500.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'stocks-and-shares';

-- ============================================================
-- Quantitative Aptitude > True Discount
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the true discount on Rs. 1100 due 1 year hence at 10% per annum simple interest.', 'Rs. 90', 'Rs. 95', 'Rs. 100', 'Rs. 110', 'c', 'TD = (Amount x R x T)/(100+RT) = (1100x10x1)/110 = Rs. 100.', 'medium'),
  ('Find the present worth of Rs. 1200 due 2 years hence at 5% per annum simple interest.', 'Rs. 1050', 'Rs. 1080', 'Rs. 1090.9', 'Rs. 1100', 'c', 'PW = Amount/(1+RT/100) = 1200/1.1 ~ Rs. 1090.9.', 'medium'),
  ('The true discount on a bill due 9 months hence at 16% per annum is Rs. 189. Find the amount of the bill.', 'Rs. 1700', 'Rs. 1750', 'Rs. 1764', 'Rs. 1800', 'c', 'RT = 16x9/12 = 12. Amount = TD x (100+RT)/RT = 189x112/12 = Rs. 1764.', 'hard'),
  ('Find the true discount on Rs. 2200 due 3 years hence at 5% simple interest per annum.', 'Rs. 270', 'Rs. 280', 'Rs. 287', 'Rs. 300', 'c', 'TD = (2200x5x3)/(100+15) = 33000/115 ~ Rs. 287.', 'hard'),
  ('The true discount on a sum due 2 years hence at 8% per annum is Rs. 160. Find the sum due.', 'Rs. 1100', 'Rs. 1140', 'Rs. 1160', 'Rs. 1200', 'c', 'Sum = TD x (100+RT)/RT = 160x116/16 = Rs. 1160.', 'medium'),
  ('Find the present worth of Rs. 660 due in 9 months at 4% per annum simple interest.', 'Rs. 620', 'Rs. 630', 'Rs. 640.8', 'Rs. 650', 'c', 'RT = 4x9/12 = 3. PW = 660/1.03 ~ Rs. 640.8.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'true-discount';

-- ============================================================
-- Quantitative Aptitude > Banker's Discount
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the banker''s discount on Rs. 1600 due 3 years hence at 5% per annum.', 'Rs. 200', 'Rs. 220', 'Rs. 240', 'Rs. 260', 'c', 'BD = (Amount x R x T)/100 = (1600x5x3)/100 = Rs. 240.', 'easy'),
  ('The banker''s discount on a sum of money for 1.5 years at 8% per annum is Rs. 180. Find the sum.', 'Rs. 1400', 'Rs. 1450', 'Rs. 1500', 'Rs. 1600', 'c', 'Sum = (BD x 100)/(R x T) = 18000/12 = Rs. 1500.', 'medium'),
  ('If the banker''s discount on Rs. 1650 due in 8 months is Rs. 88, find the rate percent.', '6%', '7%', '8%', '9%', 'c', 'T = 2/3 yr. 88 = (1650 x R x 2/3)/100 = 11R, so R = 8%.', 'hard'),
  ('The banker''s gain on a sum due 2 years hence at 10% per annum is Rs. 24. Find the true discount.', 'Rs. 100', 'Rs. 110', 'Rs. 120', 'Rs. 130', 'c', 'BG = (TD x R x T)/100, so 24 = TD x 0.2, giving TD = Rs. 120.', 'hard'),
  ('Find the true discount on Rs. 1500 due 6 months hence at 8% per annum (banker''s discount = Rs. 60).', 'Rs. 55', 'Rs. 56', 'Rs. 57.7', 'Rs. 60', 'c', 'TD = (Amount x R x T)/(100+RT) = (1500x8x0.5)/104 ~ Rs. 57.7.', 'hard'),
  ('The difference between banker''s discount and true discount on a sum due 1 year hence at 10% per annum is Rs. 10. Find the sum.', 'Rs. 1000', 'Rs. 1050', 'Rs. 1100', 'Rs. 1200', 'c', 'Using BG = Sum x R^2 / (100 x (100+R)) for T=1: 10 = Sum x 100/11000, so Sum = Rs. 1100.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'bankers-discount';

-- ============================================================
-- Quantitative Aptitude > Odd Man Out and Series
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the odd one out: 2, 4, 6, 8, 10, 13', '2', '8', '10', '13', 'd', 'The series increases by 2 each time; 13 breaks the pattern (should be 12).', 'easy'),
  ('Find the odd one out: 4, 9, 16, 25, 35, 49', '16', '25', '35', '49', 'c', 'These are perfect squares (2^2..7^2) except 35, which should be 36.', 'medium'),
  ('Find the odd one out: 8, 27, 64, 100, 125', '27', '64', '100', '125', 'c', '8, 27, 64, 125 are perfect cubes; 100 is not.', 'medium'),
  ('Find the odd one out: 1, 4, 9, 16, 24, 36', '9', '16', '24', '36', 'c', '1,4,9,16,25,36 are perfect squares; 24 breaks the pattern (should be 25).', 'medium'),
  ('Find the next number in the series: 2, 6, 12, 20, 30, ?', '36', '40', '42', '44', 'c', 'The differences increase by 2 each time (4,6,8,10,12), so the next term is 30+12 = 42.', 'medium'),
  ('Find the odd one out: 5, 10, 20, 40, 75, 160', '20', '40', '75', '160', 'c', 'The series doubles each time (5,10,20,40,80,160); 75 breaks the pattern (should be 80).', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'odd-man-out-and-series';

-- ============================================================
-- Logical Reasoning > Statement and Argument
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Statement: Should smoking be banned in public places? Which is the strongest argument in favor?', 'Smoking is a personal habit people enjoy', 'Smoking harms both smokers and passive smokers alike', 'Cigarettes are expensive', 'Some countries have not banned smoking', 'b', 'A strong argument must be directly relevant and factual -- health harm to smokers and bystanders is the most compelling and relevant point.', 'medium'),
  ('Statement: Should university education be made free for all? Which is the strongest argument in favor?', 'Education has always cost money', 'Some students prefer not to study', 'It would widen access to higher education regardless of financial background', 'Universities need funding to operate', 'c', 'This argument directly addresses the stated goal (accessibility) with a clear, relevant benefit.', 'medium'),
  ('Statement: Should the use of plastic bags be banned? Which is the strongest argument in favor?', 'Plastic bags are colorful', 'Plastic bags cause severe pollution and harm wildlife', 'Some shops still use paper bags', 'Plastic was invented a long time ago', 'b', 'This is the only option that is both factual and directly relevant to the environmental case for a ban.', 'easy'),
  ('Statement: Should online classes permanently replace traditional classroom teaching? Which is the strongest argument against?', 'Some students like their teachers', 'Traditional classrooms have existed for centuries', 'Online classes lack the personal interaction essential for effective learning', 'Online classes require electricity', 'c', 'This argument identifies a substantive, relevant drawback rather than an appeal to tradition or a trivial point.', 'medium'),
  ('Statement: Should junk food be banned in school canteens? Which is the strongest argument in favor?', 'Junk food tastes good', 'Junk food contributes to childhood obesity and poor nutrition', 'Some students bring their own lunch', 'Canteens earn profit from snacks', 'b', 'This is the only option presenting a substantive, relevant health-based case for a ban.', 'easy'),
  ('Statement: Should employees be allowed to work from home permanently? Which is the strongest argument in favor?', 'Offices have furniture', 'Some employees like to travel', 'Remote work has been shown to increase productivity and reduce commuting stress', 'Working from home means staying in pajamas', 'c', 'This argument is backed by a substantive, measurable benefit rather than a trivial observation.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'statement-and-argument';

-- ============================================================
-- Logical Reasoning > Statement and Conclusion
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Statements: All roses are flowers. Some flowers fade quickly. Which conclusion definitely follows?', 'All roses fade quickly', 'Some roses fade quickly', 'All flowers are roses', 'No definite conclusion can be drawn', 'd', 'The statements do not guarantee that any rose is among the flowers that fade quickly, so no definite conclusion follows.', 'hard'),
  ('Statements: All students in the class passed the exam. Ravi is a student in the class. Which conclusion follows?', 'Ravi did not pass the exam', 'Ravi is not a student', 'No conclusion follows', 'Ravi passed the exam', 'd', 'Since all students passed and Ravi is a student, it directly follows that Ravi passed.', 'easy'),
  ('Statements: Some doctors are teachers. All teachers are graduates. Which conclusion follows?', 'All doctors are graduates', 'No doctors are graduates', 'Some doctors are graduates', 'All graduates are teachers', 'c', 'Since some doctors are teachers, and all teachers are graduates, it follows that some doctors are graduates.', 'medium'),
  ('Statements: All squares are rectangles. All rectangles are quadrilaterals. Which conclusion follows?', 'No conclusion follows', 'All squares are quadrilaterals', 'All quadrilaterals are squares', 'No squares are quadrilaterals', 'b', 'By transitivity, since all squares are rectangles and all rectangles are quadrilaterals, all squares are quadrilaterals.', 'medium'),
  ('Statements: Some pens are pencils. All pencils are wooden. Which conclusion follows?', 'No conclusion follows', 'Some pens are wooden', 'All pens are wooden', 'No pens are wooden', 'b', 'Since some pens are pencils, and all pencils are wooden, it follows that some pens are wooden.', 'medium'),
  ('Statements (for logical purposes only): All birds can fly. Penguins are birds. Which conclusion follows from the statements as given?', 'No conclusion follows', 'Some penguins can fly', 'Penguins can fly', 'Penguins cannot fly', 'c', 'Purely on the logical validity of the given statements (regardless of real-world fact), it follows that penguins can fly.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'statement-and-conclusion';

-- ============================================================
-- Logical Reasoning > Cause and Effect
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('I. The company''s profits declined sharply last quarter. II. The company laid off 200 employees. What is the relationship?', 'I is the cause, II is the effect', 'II is the cause, I is the effect', 'Both are independent causes', 'Both are effects of a common cause', 'a', 'Declining profits (I) typically leads a company to cut costs through layoffs (II).', 'medium'),
  ('I. It rained heavily throughout the night. II. The streets were flooded in the morning. What is the relationship?', 'II is the cause, I is the effect', 'I is the cause, II is the effect', 'Both are independent events', 'Both are effects of a common cause', 'b', 'Heavy rain (I) directly causes street flooding (II).', 'easy'),
  ('I. The government increased the tax on fuel. II. Transportation costs across the city rose significantly. What is the relationship?', 'Both are independent events', 'II is the cause, I is the effect', 'I is the cause, II is the effect', 'Both are effects of a common cause', 'c', 'A fuel tax increase (I) directly drives up transportation costs (II).', 'medium'),
  ('I. Sales of ice cream increased in June. II. Sales of cold drinks also increased in June. What is the relationship?', 'I is the cause, II is the effect', 'II is the cause, I is the effect', 'Both are independent events', 'Both are effects of a common cause', 'd', 'Both increases are most plausibly driven by a common cause -- summer heat -- rather than one causing the other.', 'medium'),
  ('I. The factory installed new machinery. II. Production output increased by 30%. What is the relationship?', 'I is the cause, II is the effect', 'II is the cause, I is the effect', 'Both independent', 'Both effects of a common cause', 'a', 'Installing new machinery (I) is the direct cause of increased output (II).', 'easy'),
  ('I. The company launched an aggressive marketing campaign. II. The company''s sales figures reached a record high. What is the relationship?', 'Both are independent events', 'I is the cause, II is the effect', 'II is the cause, I is the effect', 'Both are effects of a common cause', 'b', 'The marketing campaign (I) is the most plausible direct cause of the record sales (II).', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'cause-and-effect';

-- ============================================================
-- Logical Reasoning > Puzzle Test
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Five friends A, B, C, D, E sit in a row. B is immediately right of A. C is immediately left of D. E is at one end. D is second from the left. Who sits at the leftmost position?', 'A', 'B', 'C', 'D', 'c', 'D is 2nd from left, so C (immediately left of D) is 1st (leftmost). E must then take the other end, and A,B fill the remaining middle seats.', 'hard'),
  ('Four boxes P, Q, R, S are stacked one above another. P is above Q. R is at the bottom. S is directly below P. Which box is at the top?', 'P', 'Q', 'R', 'S', 'a', 'With R at the bottom and the constraints satisfied by the order R, Q, S, P (bottom to top), P is at the top.', 'hard'),
  ('Six students are ranked by marks: A scored more than B but less than C. D scored the highest. E scored more than A but less than C. F scored the least. Who scored second-highest?', 'A', 'C', 'D', 'E', 'b', 'The order from highest to lowest is D, C, E, A, B, F, so C is second-highest.', 'hard'),
  ('In a row of children, Rahul is 7th from the left and Priya is 9th from the right. If they interchange positions, Rahul becomes 12th from the left. How many children are in the row?', '18', '19', '20', '21', 'c', 'After interchange, Rahul takes Priya''s original spot (9th from right), which becomes his 12th from left. Total = 12 + 9 - 1 = 20.', 'hard'),
  ('Five houses A, B, C, D, E are in a line. A is left of B. C is right of D. E is between B and C. D is at the left end. What is the order from left to right?', 'D, A, B, E, C', 'A, D, B, E, C', 'D, A, E, B, C', 'A, B, D, E, C', 'a', 'D is leftmost; placing A, B, E, C as D-A-B-E-C satisfies all constraints: A left of B, E between B and C, C right of D.', 'hard'),
  ('Five people sit in a row. B is at the rightmost end. C is exactly in the middle. How many people sit to the right of C?', '1', '2', '3', '4', 'b', 'With 5 seats and C in the middle (position 3), positions 4 and 5 are to its right -- 2 people.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'puzzle-test';

-- ============================================================
-- Data Interpretation > Pie Charts
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A family''s monthly budget of Rs. 40,000 is split as: Food 30%, Rent 25%, Transport 15%, Savings 20%, Others 10%. How much is spent on Food?', 'Rs. 10,000', 'Rs. 11,000', 'Rs. 12,000', 'Rs. 13,000', 'c', '30% of 40,000 = Rs. 12,000.', 'easy'),
  ('Using the same budget split (Food 30%, Rent 25%, Transport 15%, Savings 20%, Others 10% of Rs. 40,000), how much is spent on Rent?', 'Rs. 8,000', 'Rs. 9,000', 'Rs. 10,000', 'Rs. 11,000', 'c', '25% of 40,000 = Rs. 10,000.', 'easy'),
  ('Using the same budget split, how much more is spent on Food than on Transport?', 'Rs. 4,000', 'Rs. 5,000', 'Rs. 6,000', 'Rs. 7,000', 'c', 'Food = Rs. 12,000, Transport = 15% of 40,000 = Rs. 6,000. Difference = Rs. 6,000.', 'medium'),
  ('Using the same budget split, what is the combined amount spent on Rent and Savings?', 'Rs. 16,000', 'Rs. 17,000', 'Rs. 18,000', 'Rs. 19,000', 'c', 'Rent = Rs. 10,000, Savings = 20% of 40,000 = Rs. 8,000. Combined = Rs. 18,000.', 'medium'),
  ('Using the same budget split, what angle in the pie chart represents the Savings sector?', '60 deg', '68 deg', '72 deg', '80 deg', 'c', '20% of 360 degrees = 72 degrees.', 'medium'),
  ('If the family''s total budget increases by 10% next month (to Rs. 44,000) with the same percentage split, how much would be spent on Food?', 'Rs. 12,500', 'Rs. 13,000', 'Rs. 13,200', 'Rs. 13,500', 'c', '30% of 44,000 = Rs. 13,200.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'pie-charts';

-- ============================================================
-- Data Interpretation > Line Charts
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A line chart shows a company''s monthly revenue (in lakhs): Jan-50, Feb-60, Mar-55, Apr-70, May-65, Jun-80. In which month was revenue highest?', 'Apr', 'May', 'Jun', 'Mar', 'c', 'June had the highest revenue at 80 lakhs.', 'easy'),
  ('Using the same monthly revenue data (Jan-50, Feb-60, Mar-55, Apr-70, May-65, Jun-80), what is the total revenue over the 6 months?', '360', '370', '380', '390', 'c', 'Sum = 50+60+55+70+65+80 = 380 lakhs.', 'medium'),
  ('Using the same data, what is the average monthly revenue?', '60', '61.67', '63.33', '65', 'c', 'Average = 380/6 ~ 63.33 lakhs.', 'medium'),
  ('Using the same data, by how much did revenue increase from March to April?', '10', '12', '15', '18', 'c', 'April (70) - March (55) = 15 lakhs.', 'easy'),
  ('Using the same data, what was the percentage increase in revenue from January to June?', '50%', '55%', '60%', '65%', 'c', '(80-50)/50 x 100 = 60%.', 'medium'),
  ('Using the same data, in how many months was revenue above 60 lakhs?', '2', '3', '4', '5', 'b', 'April (70), May (65), and June (80) exceed 60 lakhs -- 3 months.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'line-charts';
