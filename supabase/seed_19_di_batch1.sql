-- seed_19_di_batch1.sql
-- Completes the Data Interpretation category. Tops up Tables, Bar
-- Charts, Pie Charts, and Line Charts (each originally seeded with 6
-- questions in seed_02/seed_03) with 19 more each to reach 25, using
-- fresh datasets for variety. Data is embedded directly in each
-- question_text since the schema has no separate shared-dataset table.
-- Additive only; safe to run once after seed_18_verbal_batch2.sql.

-- ============================================================
-- Data Interpretation > Tables (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Annual production (in units) of 4 companies: A: 2021-200, 2022-250, 2023-300. B: 2021-180, 2022-220, 2023-260. C: 2021-150, 2022-190, 2023-210. D: 2021-220, 2022-240, 2023-290. What was Company A''s production in 2023?', '280', '290', '300', '310', 'c', 'Company A produced 300 units in 2023 as given.', 'easy'),
  ('Using the same production table (A: 200/250/300, B: 180/220/260, C: 150/190/210, D: 220/240/290 for 2021/2022/2023), what was the total production of Company B over the three years?', '620', '640', '660', '680', 'c', '180+220+260 = 660.', 'medium'),
  ('Using the same production table, which company had the highest production in 2022?', 'A', 'B', 'C', 'D', 'a', 'In 2022: A=250, B=220, C=190, D=240 -- A is highest.', 'easy'),
  ('Using the same production table, what was the percentage increase in Company C''s production from 2021 to 2023?', '30%', '35%', '40%', '45%', 'c', '(210-150)/150 x 100 = 40%.', 'medium'),
  ('Using the same production table, what was the average production of Company D over the three years?', '230', '240', '250', '260', 'c', '(220+240+290)/3 = 250.', 'medium'),
  ('Using the same production table, which company showed the smallest increase in production from 2021 to 2023?', 'A', 'B', 'C', 'D', 'c', 'Increases: A=100, B=80, C=60, D=70 -- C is smallest.', 'medium'),
  ('Using the same production table, what was the combined production of all 4 companies in 2021?', '700', '725', '750', '775', 'c', '200+180+150+220 = 750.', 'medium'),
  ('Using the same production table, by how much did Company A''s production exceed Company C''s in 2023?', '80', '85', '90', '95', 'c', '300-210 = 90.', 'easy'),
  ('Using the same production table, what was the total production of all 4 companies in 2023?', '1020', '1040', '1060', '1080', 'c', '300+260+210+290 = 1060.', 'medium'),
  ('A student scored marks (out of 100) in 5 subjects: Maths-85, Science-78, English-72, History-65, Geography-90. What is the student''s total marks across all 5 subjects?', '370', '380', '390', '400', 'c', '85+78+72+65+90 = 390.', 'easy'),
  ('Using the same marks table, what is the student''s average marks?', '74', '76', '78', '80', 'c', '390/5 = 78.', 'easy'),
  ('Using the same marks table, in which subject did the student score the lowest?', 'Maths', 'Science', 'English', 'History', 'd', 'History has the lowest score at 65.', 'easy'),
  ('Using the same marks table, what percentage of marks did the student get overall (out of 500)?', '74%', '76%', '78%', '80%', 'c', '390/500 x 100 = 78%.', 'medium'),
  ('Using the same marks table, in how many subjects did the student score above 75?', '2', '3', '4', '5', 'b', 'Maths(85), Science(78), and Geography(90) exceed 75 -- 3 subjects.', 'medium'),
  ('Using the same marks table, what is the difference between the highest and lowest marks scored?', '20', '22', '25', '28', 'c', '90-65 = 25.', 'easy'),
  ('The population of 4 cities (in lakhs) is: P-25, Q-40, R-18, S-32. What is the total population of all 4 cities?', '105', '110', '115', '120', 'c', '25+40+18+32 = 115 lakhs.', 'easy'),
  ('Using the same population table, which city has the second-highest population?', 'P', 'Q', 'R', 'S', 'd', 'Sorted: Q(40), S(32), P(25), R(18) -- S is second-highest.', 'medium'),
  ('Using the same population table, what is the average population of the 4 cities?', '26.5', '27.75', '28.75', '29.5', 'c', '115/4 = 28.75 lakhs.', 'medium'),
  ('Using the same population table, by what percentage is City Q''s population greater than City R''s?', '100%', '110%', '122.2%', '130%', 'c', '(40-18)/18 x 100 ~ 122.2%.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'tables';

-- ============================================================
-- Data Interpretation > Bar Charts (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A bar chart shows books sold by a bookstore over 5 days: Mon-30, Tue-45, Wed-25, Thu-50, Fri-40. On which day were the most books sold?', 'Mon', 'Tue', 'Wed', 'Thu', 'd', 'Thursday had the highest sales at 50 books.', 'easy'),
  ('Using the same book sales chart, what is the total number of books sold over the 5 days?', '180', '185', '190', '195', 'c', '30+45+25+50+40 = 190.', 'medium'),
  ('Using the same book sales chart, what is the average number of books sold per day?', '35', '36', '38', '40', 'c', '190/5 = 38.', 'medium'),
  ('Using the same book sales chart, by how much did sales increase from Wednesday to Thursday?', '20', '22', '25', '28', 'c', '50-25 = 25.', 'easy'),
  ('Using the same book sales chart, on which day were the fewest books sold?', 'Mon', 'Tue', 'Wed', 'Fri', 'c', 'Wednesday had the fewest sales at 25 books.', 'easy'),
  ('Using the same book sales chart, approximately what percentage of total sales occurred on Tuesday?', '20%', '21.5%', '23.68%', '25%', 'c', '45/190 x 100 ~ 23.68%.', 'hard'),
  ('Using the same book sales chart, on how many days were more than 35 books sold?', '2', '3', '4', '5', 'b', 'Tuesday(45), Thursday(50), and Friday(40) exceed 35 -- 3 days.', 'medium'),
  ('A bar chart shows monthly rainfall (in mm): Jan-20, Feb-15, Mar-40, Apr-60, May-90. In which month was rainfall highest?', 'Feb', 'Mar', 'Apr', 'May', 'd', 'May had the highest rainfall at 90 mm.', 'easy'),
  ('Using the same rainfall chart, what is the total rainfall over the 5 months?', '215', '220', '225', '230', 'c', '20+15+40+60+90 = 225 mm.', 'medium'),
  ('Using the same rainfall chart, what is the average monthly rainfall?', '40', '42', '45', '48', 'c', '225/5 = 45 mm.', 'medium'),
  ('Using the same rainfall chart, by how much did rainfall increase from March to April?', '15', '18', '20', '22', 'c', '60-40 = 20 mm.', 'easy'),
  ('Using the same rainfall chart, what percentage of total rainfall occurred in May?', '35%', '38%', '40%', '42%', 'c', '90/225 x 100 = 40%.', 'medium'),
  ('Using the same rainfall chart, in how many months was rainfall below 30 mm?', '1', '2', '3', '4', 'b', 'January(20) and February(15) are below 30 mm -- 2 months.', 'easy'),
  ('A bar chart shows employees in 4 departments: HR-15, Sales-35, IT-50, Finance-20. Which department has the most employees?', 'HR', 'Sales', 'IT', 'Finance', 'c', 'IT has the most employees at 50.', 'easy'),
  ('Using the same employee chart, what is the total number of employees across all departments?', '110', '115', '120', '125', 'c', '15+35+50+20 = 120.', 'medium'),
  ('Using the same employee chart, approximately what percentage of employees work in Sales?', '25%', '27%', '29.17%', '32%', 'c', '35/120 x 100 ~ 29.17%.', 'hard'),
  ('Using the same employee chart, how many more employees does IT have than HR?', '30', '32', '35', '38', 'c', '50-15 = 35.', 'easy'),
  ('Using the same employee chart, what is the average number of employees per department?', '25', '28', '30', '32', 'c', '120/4 = 30.', 'medium'),
  ('Using the same employee chart, which department has the fewest employees?', 'HR', 'Sales', 'IT', 'Finance', 'a', 'HR has the fewest employees at 15.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'bar-charts';

-- ============================================================
-- Data Interpretation > Pie Charts (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A company''s annual expenses of Rs. 20,00,000 are split as: Salaries 40%, Rent 15%, Marketing 20%, Utilities 10%, Miscellaneous 15%. How much is spent on Salaries?', 'Rs. 7,50,000', 'Rs. 7,80,000', 'Rs. 8,00,000', 'Rs. 8,20,000', 'c', '40% of 20,00,000 = Rs. 8,00,000.', 'easy'),
  ('Using the same expense chart, how much is spent on Marketing?', 'Rs. 3,80,000', 'Rs. 3,90,000', 'Rs. 4,00,000', 'Rs. 4,10,000', 'c', '20% of 20,00,000 = Rs. 4,00,000.', 'easy'),
  ('Using the same expense chart, what is the combined amount spent on Rent and Utilities?', 'Rs. 4,50,000', 'Rs. 4,80,000', 'Rs. 5,00,000', 'Rs. 5,20,000', 'c', '(15%+10%) of 20,00,000 = Rs. 5,00,000.', 'medium'),
  ('Using the same expense chart, what angle represents Marketing in the pie chart?', '60 deg', '68 deg', '72 deg', '80 deg', 'c', '20% of 360 degrees = 72 degrees.', 'medium'),
  ('Using the same expense chart, how much more is spent on Salaries than Marketing?', 'Rs. 3,50,000', 'Rs. 3,80,000', 'Rs. 4,00,000', 'Rs. 4,20,000', 'c', '8,00,000 - 4,00,000 = Rs. 4,00,000.', 'medium'),
  ('If the company''s total expenses increase by 20% next year with the same percentage split, how much would be spent on Rent?', 'Rs. 3,40,000', 'Rs. 3,50,000', 'Rs. 3,60,000', 'Rs. 3,70,000', 'c', 'New total = 24,00,000; 15% of that = Rs. 3,60,000.', 'hard'),
  ('A survey of 500 people''s favorite fruit found: Apple 30%, Banana 25%, Mango 25%, Orange 20%. How many people prefer Apple?', '140', '145', '150', '155', 'c', '30% of 500 = 150.', 'easy'),
  ('Using the same fruit survey, how many people prefer Banana or Mango combined?', '230', '240', '250', '260', 'c', '(25%+25%) of 500 = 250.', 'medium'),
  ('Using the same fruit survey, what angle represents Orange in the pie chart?', '65 deg', '70 deg', '72 deg', '75 deg', 'c', '20% of 360 degrees = 72 degrees.', 'medium'),
  ('Using the same fruit survey, how many more people prefer Apple than Orange?', '40', '45', '50', '55', 'c', '(30%-20%) of 500 = 50.', 'easy'),
  ('Using the same fruit survey, what percentage of people do NOT prefer Mango?', '65%', '70%', '75%', '80%', 'c', '100% - 25% = 75%.', 'easy'),
  ('Using the same fruit survey, how many people prefer either Apple or Banana?', '250', '260', '275', '290', 'c', '(30%+25%) of 500 = 275.', 'medium'),
  ('A student''s monthly expenses of Rs. 8000 are split as: Food 35%, Transport 15%, Books 20%, Entertainment 10%, Savings 20%. How much does the student spend on Food?', 'Rs. 2600', 'Rs. 2700', 'Rs. 2800', 'Rs. 2900', 'c', '35% of 8000 = Rs. 2800.', 'easy'),
  ('Using the same student budget, how much does the student save monthly?', 'Rs. 1500', 'Rs. 1550', 'Rs. 1600', 'Rs. 1650', 'c', '20% of 8000 = Rs. 1600.', 'easy'),
  ('Using the same student budget, what is the combined spending on Books and Entertainment?', 'Rs. 2200', 'Rs. 2300', 'Rs. 2400', 'Rs. 2500', 'c', '(20%+10%) of 8000 = Rs. 2400.', 'medium'),
  ('Using the same student budget, what angle represents Savings in the pie chart?', '65 deg', '70 deg', '72 deg', '75 deg', 'c', '20% of 360 degrees = 72 degrees.', 'medium'),
  ('Using the same student budget, how much more is spent on Food than Transport?', 'Rs. 1500', 'Rs. 1550', 'Rs. 1600', 'Rs. 1650', 'c', '(35%-15%) of 8000 = Rs. 1600.', 'medium'),
  ('If the student''s total monthly budget increases to Rs. 10,000 with the same percentage split, how much would be spent on Books?', 'Rs. 1800', 'Rs. 1900', 'Rs. 2000', 'Rs. 2100', 'c', '20% of 10,000 = Rs. 2000.', 'medium'),
  ('Using the same student budget, what percentage of the budget is spent on non-Food items?', '60%', '62%', '65%', '68%', 'c', '100% - 35% = 65%.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'pie-charts';

-- ============================================================
-- Data Interpretation > Line Charts (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A line chart shows a website''s daily visitors (in thousands) over a week: Mon-12, Tue-15, Wed-10, Thu-18, Fri-20, Sat-25, Sun-22. On which day were visitors highest?', 'Thu', 'Fri', 'Sat', 'Sun', 'c', 'Saturday had the highest visitors at 25 thousand.', 'easy'),
  ('Using the same visitor chart, what is the total number of visitors over the week?', '115', '118', '122', '125', 'c', '12+15+10+18+20+25+22 = 122 thousand.', 'medium'),
  ('Using the same visitor chart, what is the average daily visitors?', '16', '16.5', '17.43', '18', 'c', '122/7 ~ 17.43 thousand.', 'medium'),
  ('Using the same visitor chart, by how much did visitors increase from Wednesday to Thursday?', '6', '7', '8', '9', 'c', '18-10 = 8 thousand.', 'easy'),
  ('Using the same visitor chart, on which day were visitors lowest?', 'Mon', 'Tue', 'Wed', 'Thu', 'c', 'Wednesday had the lowest visitors at 10 thousand.', 'easy'),
  ('Using the same visitor chart, what was the percentage increase in visitors from Monday to Saturday?', '95%', '100%', '108.3%', '115%', 'c', '(25-12)/12 x 100 ~ 108.3%.', 'hard'),
  ('Using the same visitor chart, on how many days were visitors above 15 thousand?', '3', '4', '5', '6', 'b', 'Thursday(18), Friday(20), Saturday(25), and Sunday(22) exceed 15 -- 4 days.', 'medium'),
  ('A line chart shows a factory''s monthly output (in tons): Jan-100, Feb-120, Mar-90, Apr-140, May-160, Jun-150. In which month was output highest?', 'Mar', 'Apr', 'May', 'Jun', 'c', 'May had the highest output at 160 tons.', 'easy'),
  ('Using the same output chart, what is the total output over the 6 months?', '740', '750', '760', '770', 'c', '100+120+90+140+160+150 = 760 tons.', 'medium'),
  ('Using the same output chart, what is the average monthly output?', '120', '123.33', '126.67', '130', 'c', '760/6 ~ 126.67 tons.', 'medium'),
  ('Using the same output chart, by how much did output decrease from May to June?', '5', '8', '10', '12', 'c', '160-150 = 10 tons.', 'easy'),
  ('Using the same output chart, what was the percentage increase in output from March to April?', '45%', '50%', '55.56%', '60%', 'c', '(140-90)/90 x 100 ~ 55.56%.', 'hard'),
  ('Using the same output chart, in how many months was output above 120 tons?', '2', '3', '4', '5', 'b', 'April(140), May(160), and June(150) exceed 120 -- 3 months.', 'medium'),
  ('A line chart shows a student''s test scores over 5 tests: Test1-60, Test2-68, Test3-75, Test4-70, Test5-85. In which test did the student score highest?', 'Test2', 'Test3', 'Test4', 'Test5', 'd', 'Test5 has the highest score at 85.', 'easy'),
  ('Using the same test score chart, what is the student''s average score across all 5 tests?', '68', '70', '71.6', '73', 'c', '(60+68+75+70+85)/5 = 71.6.', 'medium'),
  ('Using the same test score chart, by how much did the score improve from Test1 to Test5?', '20', '22', '25', '28', 'c', '85-60 = 25.', 'easy'),
  ('Using the same test score chart, between which two consecutive tests did the score decrease?', 'Test1 to Test2', 'Test2 to Test3', 'Test3 to Test4', 'Test4 to Test5', 'c', 'The score dropped from 75 (Test3) to 70 (Test4).', 'medium'),
  ('Using the same test score chart, what was the percentage improvement from Test1 to Test3?', '20%', '22%', '25%', '28%', 'c', '(75-60)/60 x 100 = 25%.', 'medium'),
  ('Using the same test score chart, what is the total of all 5 test scores?', '348', '353', '358', '363', 'c', '60+68+75+70+85 = 358.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'line-charts';
