-- seed_02_expanded_topics.sql
-- Additive content expansion: a new Data Interpretation category, plus a
-- broader Quantitative Aptitude and Logical Reasoning topic list matching
-- common placement-portal coverage. Safe to run once against a database
-- that already has seed.sql applied -- it only inserts NEW rows (new
-- category, new topic slugs not present in seed.sql, and sample questions
-- for a subset of the new topics). Do not run this twice.
--
-- Image-based Nonverbal Reasoning (mirror images, paper folding, figure
-- series, etc.) is intentionally not included: this schema's questions
-- are text-only (question_text + 4 text options), which nonverbal
-- reasoning items generally cannot express meaningfully. "Verbal
-- Reasoning" topics (Analogy, Classification, Cause & Effect, etc.) are
-- added into the existing Logical Reasoning category instead of a new
-- category, since they'd otherwise duplicate topics already seeded there
-- (Blood Relations, Coding-Decoding, Series Completion, ...).

-- ============================================================
-- New category: Data Interpretation
-- ============================================================
insert into public.categories (name, slug, description, display_order, has_branches) values
  ('Data Interpretation', 'data-interpretation', 'Reading and analyzing tables, bar charts, and other data sets.', 5, false)
on conflict (slug) do nothing;

insert into public.topics (category_id, name, slug, display_order)
select id, t.name, t.slug, t.display_order
from public.categories, (values
  ('Tables', 'tables', 1),
  ('Bar Charts', 'bar-charts', 2),
  ('Pie Charts', 'pie-charts', 3),
  ('Line Charts', 'line-charts', 4)
) as t(name, slug, display_order)
where categories.slug = 'data-interpretation'
on conflict (category_id, slug) where branch_id is null do nothing;

-- ============================================================
-- Additional Quantitative Aptitude topics
-- ============================================================
insert into public.topics (category_id, name, slug, display_order)
select id, t.name, t.slug, t.display_order
from public.categories, (values
  ('Problems on Trains', 'problems-on-trains', 8),
  ('Height and Distance', 'height-and-distance', 9),
  ('Problems on Ages', 'problems-on-ages', 10),
  ('Calendar', 'calendars', 11),
  ('Clock', 'clocks', 12),
  ('Average', 'average', 13),
  ('Area', 'area', 14),
  ('Volume and Surface Area', 'volume-and-surface-area', 15),
  ('Permutation and Combination', 'permutations-and-combinations', 16),
  ('Problems on H.C.F and L.C.M', 'problems-on-hcf-lcm', 17),
  ('Decimal Fraction', 'decimal-fraction', 18),
  ('Simplification', 'simplification', 19),
  ('Square Root and Cube Root', 'square-root-cube-root', 20),
  ('Surds and Indices', 'surds-and-indices', 21),
  ('Chain Rule', 'chain-rule', 22),
  ('Pipes and Cistern', 'pipes-and-cisterns', 23),
  ('Boats and Streams', 'boats-and-streams', 24),
  ('Alligation or Mixture', 'alligation-or-mixture', 25),
  ('Logarithm', 'logarithms', 26),
  ('Races and Games', 'races-and-games', 27),
  ('Stocks and Shares', 'stocks-and-shares', 28),
  ('Probability', 'probability', 29),
  ('True Discount', 'true-discount', 30),
  ('Banker''s Discount', 'bankers-discount', 31),
  ('Odd Man Out and Series', 'odd-man-out-and-series', 32)
) as t(name, slug, display_order)
where categories.slug = 'quantitative-aptitude'
on conflict (category_id, slug) where branch_id is null do nothing;

-- ============================================================
-- Additional Logical Reasoning topics
-- ============================================================
insert into public.topics (category_id, name, slug, display_order)
select id, t.name, t.slug, t.display_order
from public.categories, (values
  ('Analogy', 'analogy', 7),
  ('Classification', 'classification', 8),
  ('Statement and Argument', 'statement-and-argument', 9),
  ('Statement and Conclusion', 'statement-and-conclusion', 10),
  ('Cause and Effect', 'cause-and-effect', 11),
  ('Puzzle Test', 'puzzle-test', 12)
) as t(name, slug, display_order)
where categories.slug = 'logical-reasoning'
on conflict (category_id, slug) where branch_id is null do nothing;

-- ============================================================
-- Sample questions: Quantitative Aptitude > Problems on Trains
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A train 120 m long passes a pole in 12 seconds. Find its speed in km/hr.', '30', '33', '36', '40', 'c', 'Speed = 120/12 = 10 m/s = 10 x 18/5 = 36 km/hr.', 'easy'),
  ('A train 150 m long running at 90 km/hr crosses a platform 300 m long. How long does it take?', '15 sec', '16 sec', '18 sec', '20 sec', 'c', 'Speed = 90 x 5/18 = 25 m/s. Distance = 150+300 = 450 m. Time = 450/25 = 18 sec.', 'medium'),
  ('Two trains 120 m and 180 m long run at 54 km/hr and 36 km/hr respectively in opposite directions. Find the time taken to cross each other.', '10 sec', '11 sec', '12 sec', '14 sec', 'c', 'Relative speed = 90 km/hr = 25 m/s. Total length = 300 m. Time = 300/25 = 12 sec.', 'hard'),
  ('A train running at 54 km/hr takes 20 seconds to cross a man standing on a platform. Find the length of the train.', '250 m', '275 m', '300 m', '320 m', 'c', 'Speed = 54 x 5/18 = 15 m/s. Length = 15 x 20 = 300 m.', 'medium'),
  ('A 210 m long train crosses a platform of equal length in 24 seconds. Find the speed of the train in km/hr.', '54', '60', '63', '66', 'c', 'Total distance = 420 m. Speed = 420/24 = 17.5 m/s = 63 km/hr.', 'medium'),
  ('Two trains of equal length 100 m each run in the same direction at 54 km/hr and 36 km/hr. Find the time taken by the faster train to cross the slower one.', '30 sec', '36 sec', '40 sec', '45 sec', 'c', 'Relative speed = 18 km/hr = 5 m/s. Total length = 200 m. Time = 200/5 = 40 sec.', 'medium'),
  ('A train crosses a stationary pole in 15 seconds and a 100 m platform in 25 seconds. Find the length of the train.', '120 m', '140 m', '150 m', '160 m', 'c', 'Let length = L, speed = v. L = 15v and L+100 = 25v, so 15v+100 = 25v, v = 10 m/s, L = 150 m.', 'hard'),
  ('A train travels at a speed of 72 km/hr. Convert this speed to m/s.', '18', '20', '22', '25', 'b', '72 x 5/18 = 20 m/s.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'problems-on-trains';

-- ============================================================
-- Sample questions: Quantitative Aptitude > Pipes and Cistern
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Pipe A fills a tank in 12 hours and pipe B fills it in 18 hours. How long will both pipes take to fill the tank together?', '6 hr', '7 hr', '7.2 hr', '8 hr', 'c', 'Rate = 1/12 + 1/18 = 5/36. Time = 36/5 = 7.2 hours.', 'easy'),
  ('Pipe A fills a tank in 10 hours, pipe B empties it in 15 hours. If both are opened together, how long to fill the tank?', '20 hr', '25 hr', '30 hr', '35 hr', 'c', 'Rate = 1/10 - 1/15 = 1/30. Time = 30 hours.', 'medium'),
  ('Two pipes can fill a tank in 20 and 30 minutes. A third pipe empties it in 15 minutes. If all three are opened together, how long to fill the tank?', '45 min', '50 min', '60 min', '70 min', 'c', 'Rate = 1/20 + 1/30 - 1/15 = 1/60. Time = 60 minutes.', 'hard'),
  ('Pipe A alone fills a tank in 6 hours, but due to a leak it takes 8 hours. How long would the leak alone take to empty a full tank?', '20 hr', '22 hr', '24 hr', '28 hr', 'c', 'Leak rate = 1/6 - 1/8 = 1/24. Leak alone empties the tank in 24 hours.', 'medium'),
  ('Pipe A fills a tank in 4 hours and pipe B fills it in 6 hours. Both are opened together, but B is closed after 2 hours. How long will A take to fill the rest?', '30 min', '40 min', '45 min', '50 min', 'b', 'Combined rate = 5/12/hr; in 2 hr, 5/6 is done, 1/6 remains. A alone takes (1/6)/(1/4) = 2/3 hr = 40 min.', 'hard'),
  ('Three pipes A, B, C fill a tank in 6, 8, and 12 hours respectively. Find the time to fill the tank if all three are opened together.', '2 hr', '2.4 hr', '2.67 hr', '3 hr', 'c', 'Rate = 1/6 + 1/8 + 1/12 = 9/24 = 3/8. Time = 8/3 ~ 2.67 hours.', 'hard'),
  ('Two inlet pipes fill a cistern in 15 and 20 hours; an outlet pipe empties it in 30 hours. If all three are opened together, how long to fill the cistern?', '10 hr', '11 hr', '12 hr', '14 hr', 'c', 'Rate = 1/15 + 1/20 - 1/30 = 5/60 = 1/12. Time = 12 hours.', 'medium'),
  ('A pipe fills a tank in 5 hours, but because of a leak it takes 1 extra hour. How long will the leak alone take to empty the full tank?', '24 hr', '28 hr', '30 hr', '32 hr', 'c', 'Leak rate = 1/5 - 1/6 = 1/30. Leak alone empties the tank in 30 hours.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'pipes-and-cisterns';

-- ============================================================
-- Sample questions: Quantitative Aptitude > Boats and Streams
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A boat''s speed in still water is 15 km/hr and the stream speed is 5 km/hr. Find the boat''s downstream speed.', '15 km/hr', '18 km/hr', '20 km/hr', '25 km/hr', 'c', 'Downstream speed = 15 + 5 = 20 km/hr.', 'easy'),
  ('A boat''s speed in still water is 12 km/hr and the stream speed is 4 km/hr. Find the boat''s upstream speed.', '6 km/hr', '7 km/hr', '8 km/hr', '10 km/hr', 'c', 'Upstream speed = 12 - 4 = 8 km/hr.', 'easy'),
  ('A man rows 30 km downstream in 2 hours and 18 km upstream in 3 hours. Find his speed in still water.', '9 km/hr', '10 km/hr', '10.5 km/hr', '11 km/hr', 'c', 'Downstream speed = 15 km/hr, upstream speed = 6 km/hr. Still water speed = (15+6)/2 = 10.5 km/hr.', 'medium'),
  ('A man''s speed downstream is 20 km/hr and speed upstream is 10 km/hr. Find the speed of the stream.', '4 km/hr', '5 km/hr', '6 km/hr', '8 km/hr', 'b', 'Stream speed = (20-10)/2 = 5 km/hr.', 'easy'),
  ('A boat covers 24 km upstream in 6 hours and returns downstream in 4 hours. Find the boat''s speed in still water.', '4 km/hr', '4.5 km/hr', '5 km/hr', '5.5 km/hr', 'c', 'Upstream speed = 4 km/hr, downstream speed = 6 km/hr. Still water speed = (4+6)/2 = 5 km/hr.', 'medium'),
  ('A man rows at 10 km/hr in still water. If the river flows at 2 km/hr, it takes him 5 hours to row to a place and back. How far is the place?', '20 km', '22 km', '24 km', '26 km', 'c', 'Downstream = 12 km/hr, upstream = 8 km/hr. d/12 + d/8 = 5 gives d = 24 km.', 'hard'),
  ('A boatman rows 15 km downstream in 3 hours and returns upstream in 5 hours. Find the speed of the stream.', '1 km/hr', '1.5 km/hr', '2 km/hr', '2.5 km/hr', 'a', 'Downstream speed = 5 km/hr, upstream speed = 3 km/hr. Stream speed = (5-3)/2 = 1 km/hr.', 'medium'),
  ('A boat''s speed in still water is 18 km/hr and the current''s speed is 3 km/hr. Find the total time to travel 42 km downstream and back.', '4.2 hr', '4.5 hr', '4.8 hr', '5 hr', 'c', 'Downstream = 21 km/hr, upstream = 15 km/hr. Time = 42/21 + 42/15 = 2 + 2.8 = 4.8 hours.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'boats-and-streams';

-- ============================================================
-- Sample questions: Quantitative Aptitude > Average
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the average of the first 10 natural numbers.', '5', '5.5', '6', '6.5', 'b', 'Sum = 55, average = 55/10 = 5.5.', 'easy'),
  ('The average of 5 numbers is 20. If one number is excluded, the average becomes 15. Find the excluded number.', '35', '38', '40', '45', 'c', 'Sum of 5 = 100, sum of 4 = 60. Excluded number = 100-60 = 40.', 'medium'),
  ('The average weight of 8 persons increases by 2.5 kg when a new person replaces one weighing 65 kg. Find the weight of the new person.', '75 kg', '80 kg', '85 kg', '90 kg', 'c', 'Total increase = 8 x 2.5 = 20 kg. New person''s weight = 65+20 = 85 kg.', 'medium'),
  ('The average of 3 consecutive even numbers is 14. Find the largest number.', '12', '14', '16', '18', 'c', 'The numbers are 12, 14, 16 -- the largest is 16.', 'easy'),
  ('The average marks of 30 students is 60. One student''s marks were wrongly recorded as 60 instead of 96. Find the correct average.', '60.6', '61', '61.2', '62', 'c', 'Correct sum = 30x60 + 36 = 1836. Correct average = 1836/30 = 61.2.', 'hard'),
  ('The average age of a family of 5 members is 20 years. The youngest member is 10 years old. Find the average age of the family at the time of the youngest member''s birth.', '10', '11', '12.5', '15', 'c', 'Total age now = 100. Excluding the youngest, the other 4 totaled 90 now, and were 90-40=50 ten years ago. Average = 50/4 = 12.5.', 'hard'),
  ('The average of four numbers is 45. The average of the first two is 40. Find the average of the last two.', '45', '48', '50', '52', 'c', 'Sum of 4 = 180, sum of first two = 80, so sum of last two = 100, average = 50.', 'medium'),
  ('A cricketer''s average score in 10 innings is 42. In the 11th innings he scores 97. Find his new average.', '45', '46', '47', '48', 'c', 'Sum of 10 = 420, new total = 517. New average = 517/11 = 47.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'average';

-- ============================================================
-- Sample questions: Quantitative Aptitude > Probability
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A coin is tossed once. What is the probability of getting heads?', '1/4', '1/3', '1/2', '1', 'c', 'A coin has 2 equally likely outcomes, so P(heads) = 1/2.', 'easy'),
  ('A die is rolled once. What is the probability of getting a number greater than 4?', '1/6', '1/3', '1/2', '2/3', 'b', 'Favorable outcomes are 5 and 6, so P = 2/6 = 1/3.', 'easy'),
  ('A bag contains 4 red and 6 blue balls. One ball is drawn at random. Find the probability that it is red.', '1/3', '2/5', '1/2', '3/5', 'b', 'P(red) = 4/10 = 2/5.', 'easy'),
  ('Two coins are tossed simultaneously. Find the probability of getting exactly one head.', '1/4', '1/2', '3/4', '1', 'b', 'Outcomes: HH, HT, TH, TT. Exactly one head occurs in 2 of 4 outcomes, so P = 1/2.', 'medium'),
  ('A card is drawn from a well-shuffled deck of 52 cards. Find the probability that it is a king.', '1/13', '1/12', '1/4', '4/13', 'a', 'There are 4 kings in 52 cards, so P = 4/52 = 1/13.', 'easy'),
  ('A bag contains 5 white and 3 black balls. Two balls are drawn at random. Find the probability that both are white.', '5/14', '3/14', '1/2', '5/28', 'a', 'Total ways = C(8,2) = 28. Ways to choose 2 white = C(5,2) = 10. P = 10/28 = 5/14.', 'hard'),
  ('The probability that a student passes in Maths is 3/5 and in English is 2/3. Find the probability that the student passes in both (independent events).', '1/3', '2/5', '3/5', '4/5', 'b', 'P(both) = 3/5 x 2/3 = 6/15 = 2/5.', 'medium'),
  ('What is the probability of getting a sum of 7 when two dice are rolled?', '1/12', '1/9', '1/6', '1/4', 'c', 'There are 6 favorable outcomes out of 36, so P = 6/36 = 1/6.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'probability';

-- ============================================================
-- Sample questions: Quantitative Aptitude > Problems on Ages
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A father''s present age is 3 times his son''s age. After 5 years, the father''s age will be 2.5 times the son''s age. Find the son''s present age.', '12', '14', '15', '18', 'c', 'Let son = s, father = 3s. 3s+5 = 2.5(s+5) gives s = 15.', 'medium'),
  ('Five years ago, a man was 3 times as old as his son. Ten years hence, the man will be twice as old as his son. Find the son''s present age.', '15', '18', '20', '22', 'c', 'From the two conditions: m = 3s-10 and m = 2s+10, so s = 20.', 'hard'),
  ('The ratio of ages of A and B is 3:4. After 6 years, the ratio becomes 4:5. Find A''s present age.', '15', '18', '21', '24', 'b', 'Let ages be 3x and 4x. (3x+6)/(4x+6) = 4/5 gives x = 6, so A = 18.', 'medium'),
  ('A father''s age is 4 times his son''s age. 5 years ago, the father was 7 times as old as his son. Find the father''s present age.', '32', '36', '40', '44', 'c', 'f = 4s and f-5 = 7(s-5) gives s = 10, f = 40.', 'medium'),
  ('The sum of the ages of a father and son is 60 years. 6 years ago, the father''s age was 5 times the son''s age. Find the son''s present age.', '10', '12', '14', '16', 'c', 'f+s = 60 and f-6 = 5(s-6) gives s = 14.', 'hard'),
  ('Ten years ago, A was half of B''s age. The ratio of their present ages is 3:4. Find B''s present age.', '16', '18', '20', '24', 'c', 'Let ages be 3k and 4k. (3k-10) = (1/2)(4k-10) gives k = 5, so B = 20.', 'hard'),
  ('A is 6 years older than B. In 4 years, A''s age will be twice B''s age was 4 years ago. Find B''s present age.', '14', '16', '18', '20', 'c', 'a = b+6 and a+4 = 2(b-4) gives b = 18.', 'medium'),
  ('The present ages of two brothers are in the ratio 4:5. After 8 years, the ratio will be 6:7. Find the elder brother''s present age.', '16', '18', '20', '24', 'c', 'Let ages be 4x and 5x. (4x+8)/(5x+8) = 6/7 gives x = 4, elder = 5x = 20.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'problems-on-ages';

-- ============================================================
-- Sample questions: Logical Reasoning > Analogy
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Doctor is to Hospital as Teacher is to ____?', 'Book', 'School', 'Student', 'Class', 'b', 'A doctor works at a hospital; a teacher works at a school.', 'easy'),
  ('Pen is to Write as Knife is to ____?', 'Sharp', 'Kitchen', 'Cut', 'Blade', 'c', 'A pen is used to write; a knife is used to cut.', 'easy'),
  ('Bird is to Nest as Bee is to ____?', 'Hive', 'Sky', 'Flower', 'Wing', 'a', 'A bird lives in a nest; a bee lives in a hive.', 'easy'),
  ('Fish is to Water as Bird is to ____?', 'Nest', 'Tree', 'Sky', 'Air', 'd', 'A fish moves through water; a bird moves through air.', 'medium'),
  ('Author is to Book as Sculptor is to ____?', 'Chisel', 'Statue', 'Museum', 'Stone', 'b', 'An author creates a book; a sculptor creates a statue.', 'easy'),
  ('Puppy is to Dog as Kitten is to ____?', 'Kitten', 'Feline', 'Cat', 'Cub', 'c', 'A puppy is a young dog; a kitten is a young cat.', 'easy'),
  ('Thermometer is to Temperature as Speedometer is to ____?', 'Speed', 'Car', 'Distance', 'Engine', 'a', 'A thermometer measures temperature; a speedometer measures speed.', 'medium'),
  ('Ounce is to Weight as Inch is to ____?', 'Ruler', 'Distance', 'Size', 'Length', 'd', 'An ounce is a unit of weight; an inch is a unit of length.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'analogy';

-- ============================================================
-- Sample questions: Logical Reasoning > Classification
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Which word does not belong with the others?', 'Apple', 'Banana', 'Carrot', 'Mango', 'c', 'Apple, Banana, and Mango are fruits; Carrot is a vegetable.', 'easy'),
  ('Which word does not belong with the others?', 'Triangle', 'Square', 'Circle', 'Cube', 'd', 'Triangle, Square, and Circle are 2D shapes; Cube is a 3D shape.', 'easy'),
  ('Which word does not belong with the others?', 'Delhi', 'India', 'Mumbai', 'Kolkata', 'b', 'Delhi, Mumbai, and Kolkata are cities; India is a country.', 'easy'),
  ('Which word does not belong with the others?', 'Flute', 'Guitar', 'Violin', 'Sitar', 'a', 'Guitar, Violin, and Sitar are string instruments; Flute is a wind instrument.', 'medium'),
  ('Which word does not belong with the others?', 'Mango', 'Rose', 'Lotus', 'Jasmine', 'a', 'Rose, Lotus, and Jasmine are flowers; Mango is a fruit.', 'easy'),
  ('Which word does not belong with the others?', 'Eagle', 'Sparrow', 'Bat', 'Parrot', 'c', 'Eagle, Sparrow, and Parrot are birds; Bat is a mammal.', 'medium'),
  ('Which word does not belong with the others?', 'Cricket', 'Football', 'Chess', 'Hockey', 'c', 'Cricket, Football, and Hockey are outdoor team sports; Chess is a board game.', 'medium'),
  ('Which word does not belong with the others?', 'Diamond', 'Gold', 'Silver', 'Iron', 'a', 'Gold, Silver, and Iron are metals; Diamond is not a metal.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'classification';

-- ============================================================
-- Sample questions: Data Interpretation > Tables
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Marks scored by 5 students out of 100 -- Amit: 72, Bhavna: 85, Chetan: 64, Divya: 91, Esha: 78. Who scored the highest marks?', 'Amit', 'Bhavna', 'Chetan', 'Divya', 'd', 'Divya scored 91, the highest among the five.', 'easy'),
  ('Marks scored by 5 students out of 100 -- Amit: 72, Bhavna: 85, Chetan: 64, Divya: 91, Esha: 78. What is the average marks scored?', '76', '77', '78', '80', 'c', 'Sum = 72+85+64+91+78 = 390. Average = 390/5 = 78.', 'medium'),
  ('Marks scored by 5 students out of 100 -- Amit: 72, Bhavna: 85, Chetan: 64, Divya: 91, Esha: 78. What is the difference between the highest and lowest marks?', '21', '23', '25', '27', 'd', 'Highest (91) - Lowest (64) = 27.', 'easy'),
  ('Marks scored by 5 students out of 100 -- Amit: 72, Bhavna: 85, Chetan: 64, Divya: 91, Esha: 78. How many students scored above 75 marks?', '2', '3', '4', '5', 'b', 'Bhavna (85), Divya (91), and Esha (78) scored above 75 -- 3 students.', 'medium'),
  ('Marks scored by 5 students out of 100 -- Amit: 72, Bhavna: 85, Chetan: 64, Divya: 91, Esha: 78. What percentage of students scored below 70 marks?', '10%', '20%', '30%', '40%', 'b', 'Only Chetan (64) scored below 70, which is 1 of 5 students = 20%.', 'medium'),
  ('Marks scored by 5 students out of 100 -- Amit: 72, Bhavna: 85, Chetan: 64, Divya: 91, Esha: 78. Who scored the second-highest marks?', 'Amit', 'Bhavna', 'Esha', 'Divya', 'b', 'Sorted: Divya (91), Bhavna (85), Esha (78), Amit (72), Chetan (64) -- second-highest is Bhavna.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'tables';

-- ============================================================
-- Sample questions: Data Interpretation > Bar Charts
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A bar chart shows cars sold by a dealership over 5 months -- Jan: 40, Feb: 55, Mar: 35, Apr: 60, May: 50. In which month were the most cars sold?', 'Jan', 'Feb', 'Mar', 'Apr', 'd', 'April had the highest sales at 60 cars.', 'easy'),
  ('A bar chart shows cars sold by a dealership over 5 months -- Jan: 40, Feb: 55, Mar: 35, Apr: 60, May: 50. What is the total number of cars sold over the 5 months?', '220', '230', '240', '250', 'c', 'Total = 40+55+35+60+50 = 240.', 'medium'),
  ('A bar chart shows cars sold by a dealership over 5 months -- Jan: 40, Feb: 55, Mar: 35, Apr: 60, May: 50. What is the average number of cars sold per month?', '44', '46', '48', '50', 'c', 'Average = 240/5 = 48.', 'medium'),
  ('A bar chart shows cars sold by a dealership over 5 months -- Jan: 40, Feb: 55, Mar: 35, Apr: 60, May: 50. By how much did sales increase from March to April?', '20', '25', '30', '35', 'b', 'April (60) - March (35) = 25.', 'easy'),
  ('A bar chart shows cars sold by a dealership over 5 months -- Jan: 40, Feb: 55, Mar: 35, Apr: 60, May: 50. Approximately what percentage of total sales occurred in February?', '20.5%', '22.9%', '25%', '18%', 'b', 'Feb sales / total = 55/240 x 100 ~ 22.9%.', 'hard'),
  ('A bar chart shows cars sold by a dealership over 5 months -- Jan: 40, Feb: 55, Mar: 35, Apr: 60, May: 50. In how many months were more than 45 cars sold?', '2', '3', '4', '5', 'b', 'Feb (55), Apr (60), and May (50) each exceed 45 -- 3 months.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'bar-charts';
