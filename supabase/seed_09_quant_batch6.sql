-- seed_09_quant_batch6.sql
-- Continues the "every topic gets at least 25 questions" expansion.
-- Tops up 4 more Quantitative Aptitude topics (each originally seeded
-- with 6 questions in seed_03) with 19 more each to reach 25: Square
-- Root and Cube Root, Surds and Indices, Chain Rule, Alligation or
-- Mixture. Additive only; safe to run once after seed_08_quant_batch5.sql.

-- ============================================================
-- Quantitative Aptitude > Square Root and Cube Root (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the square root of 225.', '13', '14', '15', '16', 'c', 'sqrt(225) = 15.', 'easy'),
  ('Find the cube root of 27.', '2', '3', '4', '5', 'b', 'Cube root of 27 = 3.', 'easy'),
  ('Find the square root of 400.', '18', '19', '20', '22', 'c', 'sqrt(400) = 20.', 'easy'),
  ('Find the cube root of 1000.', '8', '9', '10', '12', 'c', 'Cube root of 1000 = 10.', 'easy'),
  ('Find the square root of 1.44.', '1.1', '1.2', '1.3', '1.4', 'b', '1.2^2 = 1.44.', 'medium'),
  ('Find the value of sqrt(81) + sqrt(25).', '12', '13', '14', '15', 'c', '9 + 5 = 14.', 'easy'),
  ('Find the cube root of 216.', '5', '6', '7', '8', 'b', 'Cube root of 216 = 6.', 'easy'),
  ('Find the square root of 0.25.', '0.05', '0.5', '5', '0.025', 'b', '0.5^2 = 0.25.', 'easy'),
  ('Find the value of sqrt(0.09) x sqrt(0.04).', '0.06', '0.6', '0.006', '6', 'a', '0.3 x 0.2 = 0.06.', 'medium'),
  ('Find the smallest number by which 32 must be multiplied to make it a perfect square.', '2', '3', '4', '8', 'a', '32 = 2^5; multiplying by 2 gives 2^6, a perfect square.', 'hard'),
  ('Find the square root of 625.', '20', '22', '25', '28', 'c', 'sqrt(625) = 25.', 'easy'),
  ('Find the cube root of 343.', '6', '7', '8', '9', 'b', 'Cube root of 343 = 7.', 'easy'),
  ('If sqrt(x) = 12, find x.', '120', '132', '144', '156', 'c', 'x = 12^2 = 144.', 'easy'),
  ('Find the value of sqrt(196) - sqrt(144).', '1', '2', '3', '4', 'b', '14 - 12 = 2.', 'easy'),
  ('Find the smallest number by which 108 must be divided to make it a perfect cube.', '2', '3', '4', '9', 'c', '108 = 2^2 x 3^3; dividing by 4 leaves 27, a perfect cube.', 'hard'),
  ('Find the square root of 2.25.', '1.4', '1.5', '1.6', '1.7', 'b', '1.5^2 = 2.25.', 'medium'),
  ('Find the value of sqrt(50) x sqrt(2).', '8', '9', '10', '12', 'c', 'sqrt(50) x sqrt(2) = sqrt(100) = 10.', 'medium'),
  ('Find the cube root of 0.008.', '0.02', '0.2', '2', '0.002', 'b', '0.2^3 = 0.008.', 'medium'),
  ('If the area of a square is 324 cm2, find its side length.', '16 cm', '17 cm', '18 cm', '20 cm', 'c', 'sqrt(324) = 18 cm.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'square-root-cube-root';

-- ============================================================
-- Quantitative Aptitude > Surds and Indices (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Simplify: 3^4 / 3^2.', '6', '9', '12', '27', 'b', '3^(4-2) = 3^2 = 9.', 'easy'),
  ('Simplify: (2^3)^2.', '32', '48', '64', '128', 'c', '2^(3x2) = 2^6 = 64.', 'medium'),
  ('Simplify: 5^0.', '0', '1', '5', 'undefined', 'b', 'Any nonzero number raised to the power 0 equals 1.', 'easy'),
  ('Simplify: 9^(1/2).', '2', '3', '4.5', '9', 'b', 'sqrt(9) = 3.', 'easy'),
  ('Simplify: 2^-3.', '1/8', '1/6', '-8', '8', 'a', '2^-3 = 1/2^3 = 1/8.', 'medium'),
  ('Simplify: sqrt(36) + sqrt(64).', '12', '13', '14', '15', 'c', '6 + 8 = 14.', 'easy'),
  ('Simplify: (a^3)^0, where a is not zero.', '0', '1', 'a', 'a^3', 'b', 'Anything (nonzero) raised to the power 0 equals 1.', 'easy'),
  ('Simplify: x^2 x x^3.', 'x^5', 'x^6', '2x^5', 'x', 'a', 'x^(2+3) = x^5.', 'easy'),
  ('Simplify: 16^(3/4).', '4', '6', '8', '12', 'c', '(16^(1/4))^3 = 2^3 = 8.', 'medium'),
  ('Simplify: 100^(1/2).', '5', '10', '20', '50', 'b', 'sqrt(100) = 10.', 'easy'),
  ('Simplify: 3^2 x 3^3 / 3^4.', '1', '3', '9', '27', 'b', '3^(2+3-4) = 3^1 = 3.', 'medium'),
  ('Simplify: (1/2)^-2.', '1/4', '2', '4', '8', 'c', '(1/2)^-2 = 2^2 = 4.', 'medium'),
  ('Simplify: sqrt(a^4).', 'a', 'a^2', 'a^4', 'a^8', 'b', 'sqrt(a^4) = a^2.', 'medium'),
  ('Simplify: 8^(2/3).', '2', '4', '6', '16', 'b', '(8^(1/3))^2 = 2^2 = 4.', 'medium'),
  ('Simplify: 2^5 / 2^2.', '4', '6', '8', '10', 'c', '2^(5-2) = 2^3 = 8.', 'easy'),
  ('Simplify: 64^(1/3).', '2', '4', '8', '16', 'b', 'Cube root of 64 = 4.', 'easy'),
  ('Simplify: sqrt(3) x sqrt(12).', '4', '5', '6', '8', 'c', 'sqrt(3x12) = sqrt(36) = 6.', 'medium'),
  ('Simplify: 10^3 x 10^-1.', '10', '100', '1000', '10000', 'b', '10^(3-1) = 10^2 = 100.', 'medium'),
  ('Simplify: (25)^(1/2) x (4)^(1/2).', '8', '9', '10', '12', 'c', '5 x 2 = 10.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'surds-and-indices';

-- ============================================================
-- Quantitative Aptitude > Chain Rule (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('If 8 workers can complete a task in 6 days, how many workers are needed to complete it in 4 days?', '10', '11', '12', '14', 'c', '8x6 = 48 worker-days; 48/4 = 12 workers.', 'easy'),
  ('A car covers 240 km in 4 hours. How far will it travel in 6 hours at the same speed?', '320 km', '340 km', '360 km', '380 km', 'c', 'Speed = 60 km/hr; distance in 6 hr = 360 km.', 'easy'),
  ('If the cost of 12 pens is Rs. 180, find the cost of 20 pens.', 'Rs. 280', 'Rs. 290', 'Rs. 300', 'Rs. 320', 'c', 'Rate = Rs. 15/pen; cost of 20 = Rs. 300.', 'easy'),
  ('If 10 taps can fill a tank in 6 hours, how long will 15 taps take?', '3 hr', '4 hr', '5 hr', '6 hr', 'b', '10x6 = 60 tap-hours; 60/15 = 4 hours.', 'medium'),
  ('25 laborers can build a wall in 12 days. How many days will 20 laborers take?', '12', '14', '15', '16', 'c', '25x12 = 300 laborer-days; 300/20 = 15 days.', 'medium'),
  ('A car travels 150 km using 10 liters of fuel. How much fuel is needed for 375 km?', '20 L', '22 L', '25 L', '28 L', 'c', 'Rate = 15 km/liter; fuel = 375/15 = 25 liters.', 'medium'),
  ('If 15 men can dig a trench in 10 days, how many men are needed to dig it in 6 days?', '20', '22', '25', '28', 'c', '15x10 = 150 man-days; 150/6 = 25 men.', 'medium'),
  ('A factory produces 500 units using 20 machines in a day. How many units will 25 machines produce in a day at the same rate per machine?', '550', '600', '625', '650', 'c', 'Rate = 25 units/machine; 25x25 = 625 units.', 'medium'),
  ('If 6 pipes can fill a pool in 8 hours, how long will 4 pipes take?', '10 hr', '11 hr', '12 hr', '14 hr', 'c', '6x8 = 48 pipe-hours; 48/4 = 12 hours.', 'easy'),
  ('A tank is filled by 5 taps in 18 minutes. How long will 9 taps take?', '8 min', '9 min', '10 min', '12 min', 'c', '5x18 = 90 tap-minutes; 90/9 = 10 minutes.', 'easy'),
  ('The wages of 6 workers for 8 days is Rs. 3600. Find the wages of 9 workers for 12 days at the same daily rate per worker.', 'Rs. 7800', 'Rs. 8000', 'Rs. 8100', 'Rs. 8300', 'c', 'Rate/worker/day = 75; total = 75x9x12 = Rs. 8100.', 'hard'),
  ('18 men can complete a project in 20 days. How many men are needed to complete it in 15 days?', '20', '22', '24', '26', 'c', '18x20 = 360 man-days; 360/15 = 24 men.', 'medium'),
  ('A car uses 8 liters of petrol to travel 120 km. How far can it travel with 20 liters?', '280 km', '290 km', '300 km', '320 km', 'c', 'Rate = 15 km/liter; distance = 20x15 = 300 km.', 'medium'),
  ('If 24 workers complete a task in 15 days, how many days will 20 workers take at the same rate?', '16', '17', '18', '20', 'c', '24x15 = 360 worker-days; 360/20 = 18 days.', 'medium'),
  ('40 kg of rice costs Rs. 1600. Find the cost of 65 kg of rice at the same rate.', 'Rs. 2400', 'Rs. 2500', 'Rs. 2600', 'Rs. 2700', 'c', 'Rate = Rs. 40/kg; cost of 65 kg = Rs. 2600.', 'easy'),
  ('If 12 cows can graze a field in 8 days, how many days will 16 cows take?', '5', '6', '7', '8', 'b', '12x8 = 96 cow-days; 96/16 = 6 days.', 'medium'),
  ('A tank is filled by 8 pumps in 15 hours. How long would 12 pumps take?', '8 hr', '9 hr', '10 hr', '12 hr', 'c', '8x15 = 120 pump-hours; 120/12 = 10 hours.', 'medium'),
  ('If 5 workers earn Rs. 2000 in 4 days, how much will 8 workers earn in 6 days at the same daily rate per worker?', 'Rs. 4400', 'Rs. 4600', 'Rs. 4800', 'Rs. 5000', 'c', 'Rate/worker/day = 100; total = 100x8x6 = Rs. 4800.', 'hard'),
  ('15 students can eat a box of food in 8 days. How many days would 10 students take?', '10', '11', '12', '14', 'c', '15x8 = 120 student-days; 120/10 = 12 days.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'chain-rule';

-- ============================================================
-- Quantitative Aptitude > Alligation or Mixture (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('In what ratio must water be mixed with milk to gain 20% on selling the mixture at cost price (water is free)?', '1:4', '1:5', '1:6', '1:8', 'b', 'By alligation, water:milk = 20:100 = 1:5.', 'hard'),
  ('A mixture contains milk and water in the ratio 3:1. If 5 liters of water is added, the ratio becomes 3:2. Find the initial quantity of milk.', '12 L', '14 L', '15 L', '16 L', 'c', 'Solving 3x/(x+5) = 3/2 gives x=5, so milk = 15 L.', 'hard'),
  ('A container has 40 liters of a milk-water mixture in the ratio 7:1. How much water must be added to make the ratio 7:2?', '3 L', '4 L', '5 L', '6 L', 'c', 'Milk = 35 L, water = 5 L; solving 35/(5+w)=7/2 gives w = 5 L.', 'hard'),
  ('Two types of coffee costing Rs. 200/kg and Rs. 280/kg are mixed to get a blend costing Rs. 230/kg. Find the mixing ratio.', '5:3', '3:5', '4:3', '3:4', 'a', 'By alligation: (280-230):(230-200) = 50:30 = 5:3.', 'medium'),
  ('In what ratio should two varieties of sugar costing Rs. 18/kg and Rs. 24/kg be mixed to get a mixture worth Rs. 20/kg?', '1:2', '2:1', '3:1', '1:3', 'b', 'By alligation: (24-20):(20-18) = 4:2 = 2:1.', 'medium'),
  ('A merchant mixes 30 kg of rice worth Rs. 30/kg with some rice worth Rs. 40/kg to get a mixture worth Rs. 36/kg. Find the quantity of the second variety used.', '15 kg', '18 kg', '20 kg', '22 kg', 'c', 'By alligation, the ratio is 3:2; 30 kg = 3 parts, so the second variety = 20 kg.', 'hard'),
  ('A jar has liquids A and B in the ratio 4:1. When 10 liters of the mixture is removed and replaced with B, the ratio becomes 2:3. Find the initial quantity of A.', '12 L', '14 L', '16 L', '18 L', 'c', 'Solving the replacement equation gives total = 20 L, so A initially = 16 L.', 'hard'),
  ('A vessel contains milk and water in the ratio 2:1. If 6 liters of water is added, the ratio becomes 1:1. Find the initial quantity of milk.', '10 L', '11 L', '12 L', '14 L', 'c', 'Solving 2x/(x+6)=1 gives x=6, so milk = 12 L.', 'medium'),
  ('A 40% acid solution is mixed with a 60% acid solution to get 10 liters of a 48% solution. Find the quantity of the 40% solution used.', '5 L', '6 L', '7 L', '8 L', 'b', 'By alligation, the ratio is 3:2; the 40% part = (3/5)x10 = 6 L.', 'medium'),
  ('In what ratio must rice at Rs. 9.30/kg be mixed with rice at Rs. 10.80/kg so that the mixture is worth Rs. 10/kg?', '7:8', '8:7', '4:3', '3:4', 'b', 'By alligation: (10.80-10):(10-9.30) = 0.8:0.7 = 8:7.', 'hard'),
  ('A trader has 50 kg of sugar, part sold at 8% profit and the rest at 18% profit, gaining 14% overall. Find the quantity sold at 18% profit.', '18 kg', '20 kg', '22 kg', '25 kg', 'b', 'By alligation, the ratio is 2:3; the 18%-part = (2/5)x50 = 20 kg.', 'hard'),
  ('Find the ratio in which a 20% alcohol solution must be mixed with a 50% alcohol solution to get a 30% solution.', '1:2', '2:1', '3:1', '1:3', 'b', 'By alligation: (50-30):(30-20) = 20:10 = 2:1.', 'medium'),
  ('A shopkeeper mixes peanuts at Rs. 50/kg with cashews at Rs. 200/kg in the ratio 3:1. Find the cost per kg of the mixture.', 'Rs. 80', 'Rs. 85', 'Rs. 87.5', 'Rs. 90', 'c', '(3x50+1x200)/4 = 350/4 = Rs. 87.5.', 'medium'),
  ('Two mixtures contain milk and water in the ratios 3:2 and 5:3. Equal quantities of both are mixed. Find the resulting ratio of milk to water.', '49:31', '3:2', '5:3', '2:1', 'a', 'Averaging the milk fractions of both mixtures gives a combined ratio of 49:31.', 'hard'),
  ('How many liters of pure acid must be added to 20 liters of a 25% acid solution to make it 40% acid?', '4 L', '5 L', '6 L', '7 L', 'b', 'Solving 5+x = 0.4(20+x) gives x = 5 liters.', 'medium'),
  ('In what ratio should a 25% milk solution be mixed with pure milk (100%) to get a 40% milk solution?', '4:1', '1:4', '3:1', '1:3', 'a', 'By alligation: (100-40):(40-25) = 60:15 = 4:1.', 'medium'),
  ('A container has 100 liters of milk. 10 liters is replaced with water twice in succession. Find the quantity of milk left.', '78 L', '80 L', '81 L', '82 L', 'c', 'Milk left = 100 x (0.9)^2 = 81 liters.', 'hard'),
  ('Two solutions containing 15% and 25% salt are mixed to form 20 liters of a 20% salt solution. Find the quantity of the 25% solution used.', '8 L', '9 L', '10 L', '12 L', 'c', 'By alligation, the ratio is 1:1, so each contributes 10 liters.', 'medium'),
  ('A grocer mixes two varieties of pulses costing Rs. 60/kg and Rs. 84/kg in the ratio 3:2. Find the price per kg of the mixture.', 'Rs. 66', 'Rs. 68', 'Rs. 69.6', 'Rs. 72', 'c', '(3x60+2x84)/5 = 348/5 = Rs. 69.6.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'alligation-or-mixture';
