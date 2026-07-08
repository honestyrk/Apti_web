-- seed_06_quant_batch3.sql
-- Continues the "every topic gets at least 25 questions" expansion.
-- Tops up 6 Quantitative Aptitude topics (each originally seeded with 8
-- questions in seed_02) with 17 more each to reach 25: Problems on Trains,
-- Pipes and Cistern, Boats and Streams, Average, Probability, Problems on
-- Ages. Additive only; safe to run once after seed_05_quant_batch2.sql.

-- ============================================================
-- Quantitative Aptitude > Problems on Trains (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A train 240 m long crosses a platform 260 m long in 25 seconds. Find the speed of the train in km/hr.', '64', '68', '72', '75', 'c', 'Total distance = 500 m; speed = 500/25 = 20 m/s = 72 km/hr.', 'medium'),
  ('Two trains, each 150 m long, moving in opposite directions, cross each other in 12 seconds. One train moves twice as fast as the other. Find the speed of the faster train.', '54 km/hr', '57 km/hr', '60 km/hr', '63 km/hr', 'c', 'Relative speed = 300/12 = 25 m/s = 3v, so v ~ 8.33 m/s; faster train ~ 16.67 m/s = 60 km/hr.', 'hard'),
  ('A train speeds past a pole in 20 seconds and a platform 200 m long in 30 seconds. Find the length of the train.', '350 m', '380 m', '400 m', '420 m', 'c', 'L = 20v and L+200 = 30v gives v = 20 m/s, L = 400 m.', 'medium'),
  ('A train running at 45 km/hr takes 36 seconds to cross a bridge. If the train is 130 m long, find the length of the bridge.', '300 m', '310 m', '320 m', '330 m', 'c', 'Speed = 12.5 m/s; total distance = 450 m; bridge = 450-130 = 320 m.', 'medium'),
  ('A train 280 m long is moving at 60 km/hr. Find the time it takes to cross a man running at 6 km/hr in the same direction.', '16 sec', '17 sec', '18.67 sec', '20 sec', 'c', 'Relative speed = 54 km/hr = 15 m/s; time = 280/15 ~ 18.67 sec.', 'medium'),
  ('Two trains 100 m and 120 m long run on parallel tracks in the same direction at 72 km/hr and 54 km/hr. Find the time taken by the faster to cross the slower.', '40 sec', '42 sec', '44 sec', '46 sec', 'c', 'Relative speed = 18 km/hr = 5 m/s; total length = 220 m; time = 44 sec.', 'medium'),
  ('A train 360 m long crosses a platform in 30 seconds and a signal pole in 12 seconds. Find the speed of the train.', '96 km/hr', '100 km/hr', '108 km/hr', '112 km/hr', 'c', 'Speed = 360/12 = 30 m/s = 108 km/hr.', 'medium'),
  ('A train passes a platform 100 m long in 15 seconds and a platform 250 m long in 25 seconds. Find the length of the train.', '100 m', '110 m', '125 m', '140 m', 'c', 'L+100 = 15v and L+250 = 25v gives v = 15 m/s, L = 125 m.', 'hard'),
  ('A 150 m train crosses another 250 m train running in the opposite direction in 8 seconds. If the first train''s speed is 40 km/hr, find the second train''s speed.', '120 km/hr', '130 km/hr', '140 km/hr', '150 km/hr', 'c', 'Relative speed = 400/8 = 50 m/s = 180 km/hr; second train = 180-40 = 140 km/hr.', 'hard'),
  ('A train running at 90 km/hr crosses a pole in 10 seconds. Find the length of the train.', '200 m', '225 m', '250 m', '275 m', 'c', 'Speed = 25 m/s; length = 25x10 = 250 m.', 'easy'),
  ('Two trains of length 200 m each, running in opposite directions at equal speeds, cross each other in 10 seconds. Find the speed of each train.', '60 km/hr', '66 km/hr', '72 km/hr', '78 km/hr', 'c', 'Relative speed = 400/10 = 40 m/s; each train = 20 m/s = 72 km/hr.', 'medium'),
  ('A train covers a distance of 12 km in 10 minutes. Find its speed in km/hr.', '60', '66', '72', '78', 'c', 'Speed = 12/(10/60) = 72 km/hr.', 'easy'),
  ('A train 90 m long moving at 54 km/hr crosses another train 120 m long moving in the opposite direction at 36 km/hr. Find the time taken to cross.', '7 sec', '7.8 sec', '8.4 sec', '9 sec', 'c', 'Relative speed = 90 km/hr = 25 m/s; total length = 210 m; time = 8.4 sec.', 'medium'),
  ('A train 100 m long passes a man running at 5 km/hr in the direction opposite to the train in 6 seconds. Find the speed of the train.', '50 km/hr', '52 km/hr', '55 km/hr', '58 km/hr', 'c', 'Relative speed ~ 16.67 m/s = 60 km/hr; train speed = 60-5 = 55 km/hr.', 'hard'),
  ('A train travelling at 48 km/hr crosses another train, half its length, running in the opposite direction at 42 km/hr, in 12 seconds, then crosses a platform in 45 seconds. Find the length of the platform.', '350 m', '380 m', '400 m', '420 m', 'c', 'Combined length = 1.5L = 300 m gives L = 200 m; using the train''s own speed, platform = 600-200 = 400 m.', 'hard'),
  ('A train 300 m long crosses a platform of length 200 m in 25 seconds. Find the speed of the train in m/s.', '16', '18', '20', '22', 'c', 'Total distance = 500 m; speed = 500/25 = 20 m/s.', 'easy'),
  ('A train takes 15 seconds to cross a platform 100 m long and 20 seconds to cross a platform 200 m long. Find the length of the train.', '180 m', '190 m', '200 m', '220 m', 'c', 'L+100 = 15v and L+200 = 20v gives v = 20 m/s, L = 200 m.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'problems-on-trains';

-- ============================================================
-- Quantitative Aptitude > Pipes and Cistern (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A pipe can fill a tank in 6 hours. Find the part of the tank filled in 2 hours.', '1/4', '1/3', '1/2', '2/3', 'b', '2/6 = 1/3 of the tank.', 'easy'),
  ('Two pipes A and B can fill a tank in 15 and 20 minutes respectively. If both are opened together, find the time to fill the tank.', '7.5 min', '8 min', '8.57 min', '9 min', 'c', 'Combined rate = 1/15+1/20 = 7/60; time = 60/7 ~ 8.57 min.', 'medium'),
  ('A tank is filled by pipe A in 8 hours. Due to a leak, it takes 10 hours to fill. Find the time the leak alone would take to empty the tank.', '35 hr', '38 hr', '40 hr', '45 hr', 'c', 'Leak rate = 1/8-1/10 = 1/40; leak alone takes 40 hours.', 'medium'),
  ('Pipe A can fill a tank in 24 minutes and pipe B can empty it in 36 minutes. If both are opened together, find the time to fill the tank.', '60 min', '66 min', '72 min', '78 min', 'c', 'Net rate = 1/24-1/36 = 1/72; time = 72 minutes.', 'medium'),
  ('Three pipes A, B, and C can fill a tank in 10, 15, and 30 hours respectively. Find the time to fill the tank if all three are opened together.', '4 hr', '5 hr', '6 hr', '7 hr', 'b', 'Combined rate = 1/10+1/15+1/30 = 1/5; time = 5 hours.', 'medium'),
  ('A tank has two inlet pipes filling it in 12 and 18 hours. Both are opened together but the first is closed after 4 hours. Find the total time to fill the tank.', '10 hr', '11 hr', '12 hr', '14 hr', 'c', 'In 4 hr, 5/9 is done; the remaining 4/9 is filled by the second pipe alone in 8 more hours -- total 12 hours.', 'hard'),
  ('A cistern is filled by a tap in 4 hours. Due to a leak, it takes 5 hours. If the cistern is full, how long will the leak alone take to empty it?', '16 hr', '18 hr', '20 hr', '24 hr', 'c', 'Leak rate = 1/4-1/5 = 1/20; leak alone takes 20 hours.', 'medium'),
  ('Two pipes fill a cistern in 10 and 15 hours, while a third empties it in 20 hours. If all three are opened at once, find the time to fill the cistern.', '7.5 hr', '8 hr', '8.57 hr', '9 hr', 'c', 'Net rate = 1/10+1/15-1/20 = 7/60; time = 60/7 ~ 8.57 hr.', 'hard'),
  ('A pipe can empty a tank in 30 minutes and a second pipe in 45 minutes. If both are opened together on a full tank, find the time to empty it.', '15 min', '16 min', '18 min', '20 min', 'c', 'Combined rate = 1/30+1/45 = 1/18; time = 18 minutes.', 'medium'),
  ('Pipe A fills a tank 3 times as fast as pipe B. If together they fill the tank in 36 minutes, find the time B alone would take.', '130 min', '140 min', '144 min', '150 min', 'c', 'Combined rate = 4B = 1/36, so B alone takes 144 minutes.', 'medium'),
  ('A tank can be filled by pipe A in 20 minutes and emptied by pipe B in 25 minutes. If both are opened together on an empty tank, find the time to fill it.', '90 min', '95 min', '100 min', '110 min', 'c', 'Net rate = 1/20-1/25 = 1/100; time = 100 minutes.', 'medium'),
  ('Three taps A, B, and C fill a tank in 12, 15, and 20 hours respectively. All three are opened together, but C is closed after 4 hours. Find the total time to fill the tank.', '5 hr', '5.33 hr', '5.5 hr', '6 hr', 'b', 'In 4 hr, 4/5 is done; the remaining 1/5 is filled by A+B at 3/20 per hour, taking 4/3 more hours -- total ~5.33 hr.', 'hard'),
  ('A pipe fills a tank in 15 minutes and another fills it in 20 minutes. If both pipes are opened simultaneously, how much of the tank is filled in 5 minutes?', '1/2', '7/12', '2/3', '3/4', 'b', 'Combined rate = 7/60 per minute; in 5 minutes, 35/60 = 7/12 is filled.', 'medium'),
  ('A leak empties a full tank in 6 hours. An inlet pipe adds 4 liters/minute. With the inlet open, the leak empties the tank in 8 hours. Find the tank''s capacity.', '5000 L', '5400 L', '5760 L', '6000 L', 'c', 'capacity/6 - 240 = capacity/8 gives capacity = 5760 liters.', 'hard'),
  ('Two pipes fill a tank in 10 and 12 hours, while a third empties it in 25 hours. If all are opened simultaneously, find the time to fill the tank.', '6.5 hr', '6.98 hr', '7.2 hr', '7.5 hr', 'b', 'Net rate = 1/10+1/12-1/25 = 43/300; time = 300/43 ~ 6.98 hr.', 'hard'),
  ('Pipe A fills a tank in 12 hours. Pipe B fills 1.5 times faster than A. If both pipes are opened together, find the time to fill the tank.', '4 hr', '4.5 hr', '4.8 hr', '5 hr', 'c', 'B''s rate = 1.5/12 = 1/8; combined rate = 1/12+1/8 = 5/24; time = 4.8 hr.', 'medium'),
  ('A tank has 3 pipes filling at 8 L/min each and 2 pipes emptying at 5 L/min each. If all pipes are opened together, find the net rate of filling.', '10 L/min', '12 L/min', '14 L/min', '16 L/min', 'c', 'Fill rate = 24 L/min, empty rate = 10 L/min; net = 14 L/min.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'pipes-and-cisterns';

-- ============================================================
-- Quantitative Aptitude > Boats and Streams (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A boat covers 32 km downstream in 4 hours. Find the downstream speed.', '6 km/hr', '7 km/hr', '8 km/hr', '9 km/hr', 'c', 'Speed = 32/4 = 8 km/hr.', 'easy'),
  ('A boat covers 24 km upstream in 6 hours. Find the upstream speed.', '3 km/hr', '3.5 km/hr', '4 km/hr', '4.5 km/hr', 'c', 'Speed = 24/6 = 4 km/hr.', 'easy'),
  ('The speed of a boat in still water is 10 km/hr and the stream speed is 2 km/hr. Find the time to cover 36 km downstream.', '2.5 hr', '3 hr', '3.5 hr', '4 hr', 'b', 'Downstream speed = 12 km/hr; time = 36/12 = 3 hr.', 'medium'),
  ('The speed of a boat in still water is 15 km/hr and the stream speed is 3 km/hr. Find the time to cover 24 km upstream.', '1.5 hr', '2 hr', '2.5 hr', '3 hr', 'b', 'Upstream speed = 12 km/hr; time = 24/12 = 2 hr.', 'medium'),
  ('A man rows downstream 16 km in 2 hours and upstream 12 km in 3 hours. Find the speed of the stream.', '1 km/hr', '1.5 km/hr', '2 km/hr', '2.5 km/hr', 'c', 'Downstream speed = 8, upstream speed = 4; stream = (8-4)/2 = 2 km/hr.', 'medium'),
  ('A man can row 6 km/hr in still water. If the stream speed is 1.5 km/hr, find the time to row 7.5 km and back.', '2.33 hr', '2.5 hr', '2.67 hr', '2.8 hr', 'c', 'Downstream = 7.5 km/hr, upstream = 4.5 km/hr; total time ~ 2.67 hr.', 'hard'),
  ('A boat takes 4 hours to travel 20 km upstream and returns the same distance downstream in 2 hours. Find the speed of the boat in still water.', '7 km/hr', '7.5 km/hr', '8 km/hr', '8.5 km/hr', 'b', 'Upstream = 5, downstream = 10; still water speed = (5+10)/2 = 7.5 km/hr.', 'medium'),
  ('A boat''s downstream speed is 3 times its upstream speed. If the boat''s speed in still water is 20 km/hr, find the speed of the stream.', '8 km/hr', '9 km/hr', '10 km/hr', '12 km/hr', 'c', 'With upstream x and downstream 3x, still water = 2x = 20 gives x = 10; stream = (30-10)/2 = 10 km/hr.', 'hard'),
  ('A man rows a distance downstream in 4 hours and returns upstream in 6 hours. If the stream speed is 2 km/hr, find the speed of the boat in still water.', '8 km/hr', '9 km/hr', '10 km/hr', '11 km/hr', 'c', 'Solving with distance d gives downstream = 12, upstream = 8; still water = 10 km/hr.', 'hard'),
  ('A boat covers a distance downstream in 3 hours and returns upstream in 4 hours. If the stream speed is 3 km/hr, find the speed of the boat in still water.', '18 km/hr', '20 km/hr', '21 km/hr', '22 km/hr', 'c', 'Solving gives downstream = 24, upstream = 18; still water = 21 km/hr.', 'hard'),
  ('A man rows 15 km upstream in 5 hours and the same distance downstream in 3 hours. Find the speed of the stream.', '0.5 km/hr', '1 km/hr', '1.5 km/hr', '2 km/hr', 'b', 'Upstream = 3 km/hr, downstream = 5 km/hr; stream = (5-3)/2 = 1 km/hr.', 'medium'),
  ('A boat can travel 30 km downstream in 2 hours and returns in 3 hours. Find the speed of the current.', '2 km/hr', '2.5 km/hr', '3 km/hr', '3.5 km/hr', 'b', 'Downstream = 15, upstream = 10; current = (15-10)/2 = 2.5 km/hr.', 'medium'),
  ('A man can row at 5 km/hr in still water. In a river running at 1 km/hr, it takes him 75 minutes to row to a place and back. How far is the place?', '2.5 km', '3 km', '3.5 km', '4 km', 'b', 'Downstream = 6, upstream = 4; solving d/6+d/4 = 1.25 gives d = 3 km.', 'hard'),
  ('The speed of a boat in still water is 12 km/hr and the current''s speed is 4 km/hr. Find the ratio of time taken upstream to time taken downstream, for the same distance.', '1:2', '2:1', '3:1', '1:3', 'b', 'Upstream speed = 8, downstream = 16; time ratio (inverse of speed) = 16:8 = 2:1.', 'medium'),
  ('A boat goes 12 km upstream and 12 km downstream in a total of 5 hours. If the boat''s speed in still water is 5 km/hr, find the speed of the stream.', '0.5 km/hr', '1 km/hr', '1.5 km/hr', '2 km/hr', 'b', 'Solving 12/(5-x)+12/(5+x) = 5 gives x = 1 km/hr.', 'hard'),
  ('A man can row 10 km/hr in still water. It takes him twice as long to row upstream as downstream for the same distance. Find the speed of the stream.', '3 km/hr', '3.33 km/hr', '3.5 km/hr', '4 km/hr', 'b', 'Solving 10+x = 2(10-x) gives x ~ 3.33 km/hr.', 'hard'),
  ('A boat''s downstream speed to upstream speed ratio is 5:4. If the speed of the stream is 2 km/hr, find the speed of the boat in still water.', '16 km/hr', '17 km/hr', '18 km/hr', '20 km/hr', 'c', 'With downstream 5k and upstream 4k, stream = k/2 = 2 gives k=4; still water = (20+16)/2 = 18 km/hr.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'boats-and-streams';

-- ============================================================
-- Quantitative Aptitude > Average (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the average of 10, 20, 30, 40, 50.', '25', '28', '30', '32', 'c', 'Sum = 150; average = 150/5 = 30.', 'easy'),
  ('The average of 5 consecutive numbers is 20. Find the largest number.', '20', '21', '22', '24', 'c', 'The numbers are 18,19,20,21,22; the largest is 22.', 'easy'),
  ('The average weight of 10 students is 45 kg. If a new student weighing 56 kg joins, find the new average.', '45.5 kg', '46 kg', '46.5 kg', '47 kg', 'b', 'New total = 450+56 = 506; new average = 506/11 = 46 kg.', 'medium'),
  ('Find the average of the first 15 multiples of 3.', '22', '23', '24', '25', 'c', 'The multiples run from 3 to 45; average = (3+45)/2 = 24.', 'medium'),
  ('The average of 6 numbers is 25. If one number is removed, the average becomes 24. Find the removed number.', '25', '28', '30', '32', 'c', 'Sum of 6 = 150, sum of 5 = 120; removed number = 30.', 'medium'),
  ('The average height of 30 students is 150 cm. If the average height of 18 boys is 155 cm, find the average height of the 12 girls.', '140 cm', '141 cm', '142.5 cm', '144 cm', 'c', 'Total = 4500, boys total = 2790, girls total = 1710; girls average = 142.5 cm.', 'hard'),
  ('Find the average of the squares of the first 5 natural numbers.', '9', '10', '11', '12', 'c', 'Squares: 1,4,9,16,25, sum = 55; average = 11.', 'medium'),
  ('The average of 4 numbers is 60. The average of the first three is 55. Find the fourth number.', '70', '72', '75', '78', 'c', 'Sum of 4 = 240, sum of 3 = 165; fourth number = 75.', 'medium'),
  ('A batsman scores 50, 70, 82, 93, and 60 runs in 5 innings. Find his average score.', '68', '70', '71', '72', 'c', 'Sum = 355; average = 355/5 = 71.', 'easy'),
  ('The average of 9 numbers is 18. If the average of the first 5 is 16, find the average of the remaining 4.', '19', '20', '20.5', '21', 'c', 'Sum of 9 = 162, sum of 5 = 80; remaining sum = 82, average = 20.5.', 'medium'),
  ('The average marks of 40 students is 65. If the average marks of 25 students is 70, find the average marks of the remaining 15.', '55', '56.67', '58', '60', 'b', 'Total = 2600, 25 students total = 1750; remaining total = 850, average ~ 56.67.', 'hard'),
  ('A man travels 150 km per day on average for the first 2 days and 200 km on the third day. Find his average distance per day.', '160 km', '163 km', '166.67 km', '170 km', 'c', 'Total = 500 km over 3 days; average ~ 166.67 km.', 'medium'),
  ('The average of 7 numbers is 30. If each number is increased by 5, find the new average.', '30', '32', '35', '40', 'c', 'The average increases by exactly 5: new average = 35.', 'easy'),
  ('The average of 5 numbers is 40. If each number is multiplied by 3, find the new average.', '100', '110', '120', '130', 'c', 'The average scales by 3: new average = 120.', 'easy'),
  ('The average age of a group of 12 persons is 30 years. If 3 more persons with an average age of 26 years join, find the new average age.', '28', '28.5', '29.2', '29.5', 'c', 'Total = 360+78 = 438; new average = 438/15 = 29.2.', 'medium'),
  ('The average of three numbers is 21. The first is twice the second, and the second is twice the third. Find the third number.', '7', '8', '9', '10', 'c', 'With third = x, second = 2x, first = 4x: 7x = 63 gives x = 9.', 'hard'),
  ('Find the average of the first 100 natural numbers.', '49.5', '50', '50.5', '51', 'c', 'Sum = 100x101/2 = 5050; average = 50.5.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'average';

-- ============================================================
-- Quantitative Aptitude > Probability (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A die is thrown once. Find the probability of getting an even number.', '1/3', '1/2', '2/3', '5/6', 'b', 'Even numbers 2,4,6 give P = 3/6 = 1/2.', 'easy'),
  ('A bag contains 3 red, 4 green, and 5 blue balls. Find the probability of drawing a green ball.', '1/4', '1/3', '5/12', '1/2', 'b', 'P(green) = 4/12 = 1/3.', 'easy'),
  ('Two dice are rolled. Find the probability of getting a total of 9.', '1/12', '1/9', '1/6', '1/4', 'b', 'Favorable outcomes: (3,6)(4,5)(5,4)(6,3) = 4; P = 4/36 = 1/9.', 'medium'),
  ('A card is drawn from a deck of 52. Find the probability that it is a face card (jack, queen, or king).', '1/4', '3/13', '4/13', '1/13', 'b', 'There are 12 face cards; P = 12/52 = 3/13.', 'medium'),
  ('Three coins are tossed together. Find the probability of getting all heads.', '1/8', '1/4', '3/8', '1/2', 'a', 'Only 1 of 8 outcomes is all heads; P = 1/8.', 'medium'),
  ('Three coins are tossed together. Find the probability of getting exactly two heads.', '1/8', '1/4', '3/8', '1/2', 'c', '3 of 8 outcomes have exactly two heads; P = 3/8.', 'medium'),
  ('A bag contains 6 white and 4 black balls. One ball is drawn. Find the probability it is black.', '1/3', '2/5', '1/2', '3/5', 'b', 'P(black) = 4/10 = 2/5.', 'easy'),
  ('A bag contains 4 red and 5 blue balls. Two balls are drawn at random. Find the probability that both are red.', '1/9', '1/6', '1/4', '2/9', 'b', 'Total ways = C(9,2) = 36; favorable = C(4,2) = 6; P = 6/36 = 1/6.', 'hard'),
  ('From a pack of 52 cards, one card is drawn. Find the probability that it is either a king or a queen.', '1/13', '2/13', '3/13', '4/13', 'b', 'There are 8 kings and queens; P = 8/52 = 2/13.', 'medium'),
  ('A bag has 5 red and 3 black balls. One ball is drawn at random. Find the probability it is NOT black.', '3/8', '1/2', '5/8', '3/4', 'c', 'P(not black) = P(red) = 5/8.', 'easy'),
  ('Two unbiased coins are tossed. Find the probability of getting at least one head.', '1/2', '3/4', '1/4', '1', 'b', 'P(at least one head) = 1 - P(no head) = 1-1/4 = 3/4.', 'medium'),
  ('A number is selected at random from 1 to 25. Find the probability that it is a multiple of 4.', '5/25', '6/25', '7/25', '8/25', 'b', 'Multiples of 4 up to 25: 4,8,12,16,20,24 = 6; P = 6/25.', 'medium'),
  ('A bag contains 7 red and 3 white balls. Two balls are drawn without replacement. Find the probability that both are white.', '1/15', '1/10', '1/9', '1/5', 'a', 'Total ways = C(10,2) = 45; favorable = C(3,2) = 3; P = 3/45 = 1/15.', 'hard'),
  ('From a group of 4 men and 3 women, a committee of 2 is formed at random. Find the probability that both are women.', '1/7', '2/7', '1/3', '3/7', 'a', 'Total ways = C(7,2) = 21; favorable = C(3,2) = 3; P = 3/21 = 1/7.', 'hard'),
  ('A die is thrown twice. Find the probability of getting the same number both times.', '1/9', '1/6', '1/4', '1/3', 'b', 'There are 6 favorable outcomes out of 36; P = 6/36 = 1/6.', 'medium'),
  ('A bag contains 2 red, 3 green, and 4 blue balls. One ball is drawn at random. Find the probability that it is either red or blue.', '1/3', '1/2', '2/3', '5/9', 'c', 'P(red or blue) = (2+4)/9 = 6/9 = 2/3.', 'medium'),
  ('The probability of an event occurring is 0.3. Find the probability of the event NOT occurring.', '0.3', '0.5', '0.7', '0.9', 'c', 'P(not occurring) = 1-0.3 = 0.7.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'probability';

-- ============================================================
-- Quantitative Aptitude > Problems on Ages (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A father is 4 times as old as his son. After 20 years, the father will be twice as old as his son. Find the son''s present age.', '8', '10', '12', '15', 'b', 'f=4s and f+20=2(s+20) gives s = 10.', 'medium'),
  ('The ratio of the present ages of A and B is 5:6. Ten years hence, the ratio will be 6:7. Find A''s present age.', '40', '45', '50', '55', 'c', 'Solving (5x+10)/(6x+10)=6/7 gives x=10, so A = 50.', 'medium'),
  ('A mother is 25 years older than her son. After 5 years, the mother''s age will be twice the son''s age. Find the son''s present age.', '15', '18', '20', '22', 'c', 'm=s+25 and m+5=2(s+5) gives s = 20.', 'medium'),
  ('Six years ago, the ratio of ages of A and B was 3:4. Six years hence, the ratio will be 5:6. Find A''s present age.', '20', '22', '24', '26', 'c', 'Solving gives x=6, so A''s present age = 3x+6 = 24.', 'hard'),
  ('The sum of ages of a father and his two sons is 70. Five years ago, the sum of their ages was 55. In how many years will the sum of their ages be 100?', '8', '9', '10', '12', 'c', 'The sum increases by 3 per year (one per person); 30 more is needed, taking 10 years.', 'medium'),
  ('A is twice as old as B was 10 years ago. If the difference in their present ages is 12 years, find A''s present age.', '40', '42', '44', '46', 'c', 'Solving gives B 10 years ago = 22, so A = 2x22 = 44.', 'hard'),
  ('The present age of a man is 3 times the age of his daughter. 15 years hence, the man''s age will be twice his daughter''s age. Find the daughter''s present age.', '12', '14', '15', '16', 'c', 'm=3d and m+15=2(d+15) gives d = 15.', 'medium'),
  ('The ratio of ages of P and Q is 2:3. Eight years later, the ratio will be 3:4. Find P''s present age.', '12', '14', '16', '18', 'c', 'Solving (2x+8)/(3x+8)=3/4 gives x=8, so P = 16.', 'hard'),
  ('A mother''s age is 3 times her son''s age. 12 years hence, she will be twice his age. Find the son''s present age.', '10', '11', '12', '14', 'c', 'm=3s and m+12=2(s+12) gives s = 12.', 'medium'),
  ('Present ages of X and Y are in the ratio 3:4. Six years hence, the ratio will be 4:5. Find the difference in their present ages.', '4', '5', '6', '8', 'c', 'Solving gives x=6; ages 18 and 24, difference = 6.', 'medium'),
  ('A father says to his son, "I was as old as you are now when you were born." If the father is 38, find the son''s present age.', '17', '18', '19', '20', 'c', 'The father''s age at the son''s birth equals the son''s current age: 38-s=s gives s=19.', 'medium'),
  ('The ages of two friends differ by 4 years. 20 years ago, the elder was 5 times as old as the younger. Find the elder friend''s present age.', '22', '24', '25', '26', 'c', 'Solving gives younger = 21, elder = 25.', 'hard'),
  ('Ravi''s age after 15 years will be 5 times his age 5 years ago. Find Ravi''s present age.', '8', '9', '10', '12', 'c', 'r+15=5(r-5) gives r = 10.', 'medium'),
  ('The sum of the present ages of a father and son is 45. Five years ago, the product of their ages was 4 times the father''s age at that time. Find the son''s age 5 years ago.', '3', '4', '5', '6', 'b', 'FS=4F simplifies to S=4, so the son was 4 five years ago.', 'hard'),
  ('A is as old as B and C together. If the difference between A and C''s age is 16 years, find B''s age.', '12', '14', '16', '18', 'c', 'A=B+C, so A-C=B=16.', 'medium'),
  ('The present ages of a father and son are in the ratio 7:3. After 10 years, the ratio will be 2:1. Find the father''s present age.', '60', '65', '70', '75', 'c', 'Solving (7x+10)/(3x+10)=2 gives x=10, so father = 70.', 'medium'),
  ('Two brothers X and Y have ages in the ratio 5:3. Eight years ago, the ratio of their ages was 3:1. Find X''s present age.', '16', '18', '20', '22', 'c', 'Solving (5x-8)/(3x-8)=3 gives x=4, so X = 20.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'problems-on-ages';
