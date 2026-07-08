-- seed_05_quant_batch2.sql
-- Continues the "every topic gets at least 25 questions" expansion.
-- Tops up Percentages and Time and Work (originally seeded with 10
-- questions each in seed.sql) with 15 more each to reach 25.
-- Additive only; safe to run once after seed_04_quant_batch1.sql.

-- ============================================================
-- Quantitative Aptitude > Percentages (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('What is 15% of 200?', '25', '28', '30', '32', 'c', '15% of 200 = 30.', 'easy'),
  ('If 20% of a number is 50, find the number.', '200', '225', '250', '275', 'c', 'Number = 50/0.20 = 250.', 'easy'),
  ('A number increased by 10% becomes 220. Find the original number.', '190', '195', '200', '205', 'c', 'Original = 220/1.1 = 200.', 'easy'),
  ('Express 3/8 as a percentage.', '35%', '37.5%', '40%', '42.5%', 'b', '3/8 = 0.375 = 37.5%.', 'easy'),
  ('If the price of sugar increases by 25%, by what percent should consumption be reduced to keep expenditure unchanged?', '15%', '18%', '20%', '25%', 'c', 'Reduction% = 25/125 x 100 = 20%.', 'medium'),
  ('30% of 30% of a number is 45. Find the number.', '450', '480', '500', '520', 'c', '0.3 x 0.3 x x = 45 gives x = 500.', 'medium'),
  ('A''s salary is 20% more than B''s. By what percent is B''s salary less than A''s?', '15%', '16.67%', '18%', '20%', 'b', 'B is less by 20/120 x 100 ~ 16.67%.', 'medium'),
  ('In an election, a candidate got 60% of votes and won by 4000 votes. Find the total votes cast.', '18000', '19000', '20000', '22000', 'c', 'The winning margin is 20% of total votes = 4000, so total = 20000.', 'medium'),
  ('What percentage of 5 kg is 800 gm?', '14%', '15%', '16%', '18%', 'c', '800/5000 x 100 = 16%.', 'easy'),
  ('If the numerator of a fraction is increased by 20% and the denominator decreased by 10%, the fraction becomes 4/5. Find the original fraction.', '1/2', '3/5', '2/3', '3/4', 'b', '(1.2x)/(0.9y) = 4/5 gives x/y = 3/5.', 'hard'),
  ('A student needs 40% marks to pass. He scored 178 marks and failed by 22 marks. Find the maximum marks.', '450', '480', '500', '520', 'c', 'Passing marks = 200; maximum marks = 200/0.4 = 500.', 'medium'),
  ('If 60% of students in a class are boys and there are 24 girls, find the total number of students.', '50', '55', '60', '65', 'c', 'Girls are 40% of the class: 24/0.4 = 60.', 'easy'),
  ('The price of an item is first increased by 10% and then decreased by 10%. Find the net percentage change.', 'No change', '1% decrease', '1% increase', '2% decrease', 'b', 'Net change = (1.1 x 0.9 - 1) x 100 = -1%.', 'medium'),
  ('A number is first increased by 25% and then decreased by 20%. Find the net percentage change.', 'No change', '5% increase', '5% decrease', '10% increase', 'a', 'Net change = (1.25 x 0.8 - 1) x 100 = 0%.', 'medium'),
  ('If A is 25% taller than B, by what percent is B shorter than A?', '15%', '18%', '20%', '25%', 'c', 'B is shorter by 25/125 x 100 = 20%.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'percentages';

-- ============================================================
-- Quantitative Aptitude > Time and Work (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A can complete a work in 20 days. What fraction of the work does he complete in 4 days?', '1/4', '1/5', '1/6', '1/8', 'b', '4/20 = 1/5.', 'easy'),
  ('A and B together can complete a work in 10 days. If A alone can do it in 15 days, in how many days can B alone do it?', '25', '28', '30', '32', 'c', '1/15 + 1/B = 1/10 gives 1/B = 1/30, so B = 30 days.', 'medium'),
  ('4 men can complete a work in 15 days. In how many days can 6 men complete it?', '8', '9', '10', '12', 'c', '4x15 = 60 man-days; 60/6 = 10 days.', 'easy'),
  ('A can do a piece of work in 8 days and B in 12 days. Working on alternate days starting with A, in how many days will the work be completed?', '9', '9.5', '10', '10.5', 'b', 'Every 2 days, 5/24 of the work is done; after 8 days, 5/6 is done, and the remaining 1/6 finishes 0.5 day into B''s turn -- 9.5 days total.', 'hard'),
  ('A is thrice as efficient as B. If B can complete a work in 24 days, in how many days can A and B together complete it?', '5', '6', '7', '8', 'b', 'A rate = 3/24, B rate = 1/24; combined = 4/24 = 1/6, so 6 days.', 'medium'),
  ('10 women can complete a work in 8 days. How many days will 4 women take?', '16', '18', '20', '22', 'c', '10x8 = 80 woman-days; 80/4 = 20 days.', 'easy'),
  ('A can do a work in 6 days, B in 9 days, and C in 18 days. Working together, how many days will they take?', '2', '3', '4', '5', 'b', 'Combined rate = 1/6+1/9+1/18 = 1/3, so 3 days.', 'medium'),
  ('If 15 men take 20 days to complete a work, how many men are needed to complete it in 12 days?', '20', '22', '25', '28', 'c', '15x20 = 300 man-days; 300/12 = 25 men.', 'medium'),
  ('A and B can do a work in 12 days, B and C in 15 days, and C and A in 20 days. Working together, how many days will A, B, and C take?', '8', '9', '10', '12', 'c', 'Sum of pair rates = 1/5, which is twice (A+B+C), so A+B+C = 1/10, giving 10 days.', 'hard'),
  ('A can complete a work in 10 days. He worked for 4 days and left; B completed the remaining work in 9 days. In how many days can B alone complete the whole work?', '12', '14', '15', '16', 'c', 'A does 2/5 in 4 days, leaving 3/5 for B in 9 days; B''s full time = 9/(3/5) = 15 days.', 'hard'),
  ('12 men can complete a work in 8 days. 8 men and 8 women together can complete the same work in 6 days. Find the time taken by 1 woman alone to complete the work.', '90', '93', '96', '100', 'c', 'Total work = 96 man-days; 8 men+8 women do 16 units/day, so 8 women = 8 units/day = 1 man''s rate, giving 96 days for 1 woman.', 'hard'),
  ('A works twice as fast as B. If together they complete a work in 12 days, find the number of days B alone will take.', '30', '33', '36', '40', 'c', 'Combined rate = 3B = 1/12, so B = 1/36, i.e., 36 days.', 'medium'),
  ('5 men and 3 women can complete a work in 10 days, while 3 men and 5 women can complete it in 12 days. Find the time taken by 1 man alone.', '60', '62', '64', '66', 'c', 'Solving the two rate equations gives a man''s rate as 1/64, i.e., 64 days.', 'hard'),
  ('If 6 men and 8 boys can do a work in 10 days, and 26 men and 48 boys can do the same work in 2 days, find the ratio of work done by a man to a boy.', '1:1', '2:1', '3:1', '3:2', 'b', 'Solving the two rate equations gives a man''s rate twice a boy''s rate, i.e., 2:1.', 'hard'),
  ('A can do a work in 15 days. B is 50% more efficient than A. In how many days can B alone do the work?', '8', '9', '10', '12', 'c', 'B''s rate = 1.5 x (1/15) = 1/10, so 10 days.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'time-and-work';
