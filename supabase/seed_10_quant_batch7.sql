-- seed_10_quant_batch7.sql
-- Continues the "every topic gets at least 25 questions" expansion.
-- Tops up the final 6 Quantitative Aptitude topics (each originally
-- seeded with 6 questions in seed_03) with 19 more each to reach 25:
-- Logarithm, Races and Games, Stocks and Shares, True Discount,
-- Banker's Discount, Odd Man Out and Series. This completes all 32
-- Quantitative Aptitude topics at 25+ questions.
-- Additive only; safe to run once after seed_09_quant_batch6.sql.

-- ============================================================
-- Quantitative Aptitude > Logarithm (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find log base 10 of 10000.', '3', '4', '5', '10', 'b', '10^4 = 10000, so log10(10000) = 4.', 'easy'),
  ('Find log base 2 of 32.', '4', '5', '6', '8', 'b', '2^5 = 32, so log2(32) = 5.', 'easy'),
  ('Find log base 10 of 1.', '0', '1', '10', 'undefined', 'a', 'log of 1 to any base is 0.', 'easy'),
  ('Simplify: log(a) + log(b).', 'a+b', 'ab', 'a/b', 'a-b', 'b', 'log(a) + log(b) = log(ab).', 'medium'),
  ('Simplify: log(a) - log(b).', 'a-b', 'ab', 'a/b', 'a+b', 'c', 'log(a) - log(b) = log(a/b).', 'medium'),
  ('Find log base 3 of 81.', '3', '4', '5', '6', 'b', '3^4 = 81, so log3(81) = 4.', 'easy'),
  ('Simplify log(x^3) in terms of log(x).', 'log(x)/3', '3log(x)', 'log(3x)', 'log(x)^3', 'b', 'log(x^3) = 3 log(x).', 'medium'),
  ('Find log base 10 of 0.1.', '-2', '-1', '0', '1', 'b', '10^-1 = 0.1, so log10(0.1) = -1.', 'medium'),
  ('If log 2 = 0.301 and log 3 = 0.477, find log 6.', '0.678', '0.748', '0.778', '0.808', 'c', 'log 6 = log 2 + log 3 = 0.301+0.477 = 0.778.', 'medium'),
  ('Find log base 5 of 125.', '2', '3', '4', '5', 'b', '5^3 = 125, so log5(125) = 3.', 'easy'),
  ('Simplify: log base a of a.', '0', '1', 'a', 'undefined', 'b', 'log base a of a is always 1.', 'easy'),
  ('If log10(2) = 0.301, find log10(4).', '0.301', '0.602', '0.903', '1.204', 'b', 'log10(4) = 2 x log10(2) = 0.602.', 'medium'),
  ('Find log base 10 of 100000.', '4', '5', '6', '10', 'b', '10^5 = 100000, so log10(100000) = 5.', 'easy'),
  ('Simplify: 2 log(5) + log(4).', 'log(20)', 'log(40)', 'log(100)', 'log(200)', 'c', '2log(5)+log(4) = log(25x4) = log(100).', 'medium'),
  ('Find log base 4 of 64.', '2', '3', '4', '6', 'b', '4^3 = 64, so log4(64) = 3.', 'medium'),
  ('If log10(3) = 0.477, find log10(9).', '0.477', '0.699', '0.954', '1.431', 'c', 'log10(9) = 2 x log10(3) = 0.954.', 'medium'),
  ('Find log base 10 of 1000000.', '5', '6', '7', '8', 'b', '10^6 = 1000000, so log10(1000000) = 6.', 'easy'),
  ('Simplify log(1/x) in terms of log(x).', 'log(x)', '-log(x)', '1/log(x)', 'log(-x)', 'b', 'log(1/x) = -log(x).', 'medium'),
  ('Find log base 2 of 1.', '0', '1', '2', 'undefined', 'a', 'log of 1 to any base is 0.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'logarithms';

-- ============================================================
-- Quantitative Aptitude > Races and Games (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('In a 200 m race, A runs at 10 m/s. Find the time A takes to finish.', '15 sec', '18 sec', '20 sec', '25 sec', 'c', 'Time = 200/10 = 20 seconds.', 'easy'),
  ('A can give B a start of 20 m in a 200 m race and both finish together. Find the ratio of A''s speed to B''s speed.', '9:10', '10:9', '11:10', '10:11', 'b', 'When A runs 200, B runs 180; speed ratio = 200:180 = 10:9.', 'medium'),
  ('A runs 25% faster than B. A gives B a start of 8 seconds and both finish together. Find A''s time.', '28 sec', '30 sec', '32 sec', '35 sec', 'c', 'Solving t-8 = 0.8t gives t=40 (B''s time), so A''s time = 32 seconds.', 'hard'),
  ('In a 100 m race, A beats B by 10 m and beats C by 20 m. By how many meters does B beat C in a 100 m race?', '10 m', '11.1 m', '12 m', '15 m', 'b', 'B:C speed ratio = 90:80 = 9:8; when B runs 100, C runs 88.9, so B beats C by ~11.1 m.', 'hard'),
  ('A runs at 8 m/s and B at 6 m/s. If A gives B a 40 m head start, find the distance from the start at which A catches up with B.', '140 m', '150 m', '160 m', '170 m', 'c', 'Solving 8t = 6t+40 gives t=20 sec, so distance = 8x20 = 160 m.', 'hard'),
  ('In a 500 m race, the speed ratio of A to B is 3:4, and A has a 140 m head start. Find by how many meters A wins.', '15 m', '18 m', '20 m', '25 m', 'c', 'Computing the finishing times for each shows A wins by 20 m.', 'hard'),
  ('A and B run a 1 km race. A wins by 1 minute, finishing in 5 minutes. Find B''s speed.', '8 km/hr', '9 km/hr', '10 km/hr', '12 km/hr', 'c', 'B''s time = 6 min = 0.1 hr; speed = 1/0.1 = 10 km/hr.', 'medium'),
  ('In a race of 800 m, A beats B by 100 m and B beats C by 80 m. By how much can A beat C?', '150 m', '160 m', '170 m', '180 m', 'c', 'Chaining the ratios shows C covers 630 m when A covers 800 m, so A beats C by 170 m.', 'hard'),
  ('A runs 1.5 times as fast as B and gives B a 60 m start. Find the length of the race so both finish together.', '150 m', '160 m', '180 m', '200 m', 'c', 'Solving d/1.5 = d-60 gives d = 180 m.', 'hard'),
  ('In a 1 km race, A beats B by 40 seconds and by 100 m. Find A''s time to complete the race.', '5.5 min', '6 min', '6.5 min', '7 min', 'b', 'B''s speed = 100m/40s = 2.5 m/s; B''s total time = 400s; A''s time = 400-40 = 360s = 6 min.', 'hard'),
  ('A and B run a 2000 m race. A gives B a 200 m start and still beats him by 30 seconds. If A''s speed is 8 m/s, find B''s speed.', '6 m/s', '6.43 m/s', '6.67 m/s', '7 m/s', 'b', 'A''s time = 250s; B covers 1800m in 280s, giving speed ~6.43 m/s.', 'hard'),
  ('A can complete a race in 40 seconds and B in 50 seconds. By how many seconds does A beat B?', '8', '9', '10', '12', 'c', '50-40 = 10 seconds.', 'easy'),
  ('Two athletes run a 1500 m race; the winner finishes 3 minutes ahead at a speed of 5 m/s. Find the loser''s time.', '420 sec', '450 sec', '480 sec', '500 sec', 'c', 'Winner''s time = 300s = 5 min; loser''s time = 5+3 = 8 min = 480 sec.', 'medium'),
  ('In a race of 1000 m, A beats B by 50 m or 10 seconds. Find A''s time to complete the race.', '180 sec', '185 sec', '190 sec', '195 sec', 'c', 'B''s speed = 5 m/s; B''s total time = 200s; A''s time = 200-10 = 190 sec.', 'hard'),
  ('A runs at 5 m/s in a 100 m race. A gives B an 8 m start and still wins by 2 seconds. Find B''s speed.', '4 m/s', '4.18 m/s', '4.5 m/s', '5 m/s', 'b', 'A''s time = 20s; B covers 92m in 22s, giving speed ~4.18 m/s.', 'hard'),
  ('A beats B by 10 m in a 100 m race, and B beats C by 10 m in a 100 m race. By how many meters does A beat C in a 100 m race?', '15 m', '17 m', '19 m', '20 m', 'c', 'Chaining the ratios shows C covers 81 m when A covers 100 m, so A beats C by 19 m.', 'hard'),
  ('In a 400 m race, A beats B by 5 seconds, finishing in 50 seconds. Find B''s speed.', '6.5 m/s', '7 m/s', '7.27 m/s', '7.5 m/s', 'c', 'B''s time = 55s; speed = 400/55 ~ 7.27 m/s.', 'medium'),
  ('A runs twice as fast as B and gives B a 60 m start. Find the race length so both finish together.', '100 m', '110 m', '120 m', '130 m', 'c', 'Solving d/2 = d-60 gives d = 120 m.', 'hard'),
  ('Two runners cover 3600 m; the first in 12 minutes and the second in 15 minutes. By how much does the first beat the second?', '650 m', '700 m', '720 m', '750 m', 'c', 'In 12 minutes, the second covers 2880 m; the first beats them by 720 m.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'races-and-games';

-- ============================================================
-- Quantitative Aptitude > Stocks and Shares (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the cost of a Rs. 50 share at a discount of Rs. 5.', 'Rs. 40', 'Rs. 42', 'Rs. 45', 'Rs. 48', 'c', 'Cost = 50-5 = Rs. 45.', 'easy'),
  ('A person buys a Rs. 100 share at a premium of Rs. 15. Find the cost.', 'Rs. 105', 'Rs. 110', 'Rs. 115', 'Rs. 120', 'c', 'Cost = 100+15 = Rs. 115.', 'easy'),
  ('If a Rs. 100 share pays an 8% dividend, find the annual income from 100 shares.', 'Rs. 700', 'Rs. 750', 'Rs. 800', 'Rs. 850', 'c', 'Income = 8% x 100 x 100 = Rs. 800.', 'easy'),
  ('A man invests Rs. 3600 in Rs. 100 shares at a discount of Rs. 10. Find the number of shares purchased.', '35', '38', '40', '42', 'c', 'Price/share = Rs. 90; shares = 3600/90 = 40.', 'medium'),
  ('Find the income from investing Rs. 6000 in an 8% stock at 96.', 'Rs. 450', 'Rs. 480', 'Rs. 500', 'Rs. 520', 'c', 'Face value bought = 6250; income = 8% of 6250 = Rs. 500.', 'medium'),
  ('A person buys 15 shares of face value Rs. 100 at a premium of Rs. 20 each. Find the total investment.', 'Rs. 1600', 'Rs. 1700', 'Rs. 1800', 'Rs. 1900', 'c', 'Price/share = Rs. 120; total = 15x120 = Rs. 1800.', 'easy'),
  ('Find the dividend rate if a Rs. 100 share purchased at Rs. 120 gives an income of Rs. 12 per share.', '10%', '12%', '14%', '15%', 'b', 'Dividend rate on face value = 12/100 x 100 = 12%.', 'medium'),
  ('A man buys a Rs. 100 share for Rs. 80 and receives a Rs. 10 dividend. Find his return percentage on investment.', '10%', '12.5%', '15%', '20%', 'b', 'Return = 10/80 x 100 = 12.5%.', 'medium'),
  ('Find the market value of a Rs. 100 share if the dividend is 10% and the yield is 8%.', 'Rs. 110', 'Rs. 120', 'Rs. 125', 'Rs. 130', 'c', 'Market value = 100 x 10/8 = Rs. 125.', 'hard'),
  ('A man sells 50 shares of face value Rs. 10 at a premium of Rs. 2 each. Find his total receipt.', 'Rs. 500', 'Rs. 550', 'Rs. 600', 'Rs. 650', 'c', 'Price/share = Rs. 12; total = 50x12 = Rs. 600.', 'easy'),
  ('Rs. 8000 is invested in shares at a premium of 60% on Rs. 100 shares. Find the number of shares purchased.', '40', '45', '50', '55', 'c', 'Price/share = Rs. 160; shares = 8000/160 = 50.', 'medium'),
  ('Find the annual income from Rs. 4800 invested in a 6% stock at 96.', 'Rs. 250', 'Rs. 280', 'Rs. 300', 'Rs. 320', 'c', 'Face value = 5000; income = 6% of 5000 = Rs. 300.', 'medium'),
  ('A man buys shares of face value Rs. 25 at Rs. 30 each. With a dividend rate of 12%, find his income from 40 shares.', 'Rs. 100', 'Rs. 110', 'Rs. 120', 'Rs. 130', 'c', 'Dividend/share = 12% of 25 = Rs. 3; income = 40x3 = Rs. 120.', 'medium'),
  ('Find the cost price of a Rs. 100 share at a discount of Rs. 8 with a brokerage of Rs. 2.', 'Rs. 90', 'Rs. 92', 'Rs. 94', 'Rs. 96', 'c', 'Cost = 100-8+2 = Rs. 94.', 'medium'),
  ('A person buys Rs. 5000 (face value) worth of shares at a discount of 10%. Find the amount he pays.', 'Rs. 4200', 'Rs. 4400', 'Rs. 4500', 'Rs. 4600', 'c', 'Amount = 5000 x 0.9 = Rs. 4500.', 'easy'),
  ('A Rs. 100 share quoted at Rs. 125 pays a 15% dividend. Find the yield percentage.', '10%', '12%', '14%', '15%', 'b', 'Yield = 15/125 x 100 = 12%.', 'medium'),
  ('A man invests Rs. 10000 in a 5% stock at 125. Find his annual income.', 'Rs. 350', 'Rs. 380', 'Rs. 400', 'Rs. 420', 'c', 'Face value = 8000; income = 5% of 8000 = Rs. 400.', 'medium'),
  ('Find the number of shares that can be bought with Rs. 6600 if each Rs. 100 share is priced at Rs. 110.', '55', '58', '60', '62', 'c', 'Shares = 6600/110 = 60.', 'easy'),
  ('A person buys a Rs. 100 share at Rs. 80 and later sells it at Rs. 95. Find his profit percentage.', '15%', '17.5%', '18.75%', '20%', 'c', 'Profit = 15/80 x 100 = 18.75%.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'stocks-and-shares';

-- ============================================================
-- Quantitative Aptitude > True Discount (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the true discount on Rs. 550 due 1 year hence at 10% per annum.', 'Rs. 40', 'Rs. 45', 'Rs. 50', 'Rs. 55', 'c', 'TD = (550x10)/110 = Rs. 50.', 'medium'),
  ('Find the present worth of Rs. 660 due 1 year hence at 10% simple interest.', 'Rs. 580', 'Rs. 590', 'Rs. 600', 'Rs. 610', 'c', 'PW = 660/1.1 = Rs. 600.', 'medium'),
  ('The true discount on a sum due 3 years hence at 8% per annum is Rs. 120. Find the sum.', 'Rs. 580', 'Rs. 600', 'Rs. 620', 'Rs. 640', 'c', 'Sum = 120x124/24 = Rs. 620.', 'hard'),
  ('Find the true discount on Rs. 1400 due 2 years hence at 5% per annum.', 'Rs. 120', 'Rs. 124', 'Rs. 127.27', 'Rs. 130', 'c', 'TD = (1400x10)/110 ~ Rs. 127.27.', 'medium'),
  ('A sum of Rs. 800 is due in 2 years at 5% per annum. Find its present worth.', 'Rs. 700', 'Rs. 715', 'Rs. 727.27', 'Rs. 740', 'c', 'PW = 800/1.1 ~ Rs. 727.27.', 'medium'),
  ('The present worth of a sum due 4 years hence at 5% per annum is Rs. 1200. Find the sum due.', 'Rs. 1380', 'Rs. 1400', 'Rs. 1440', 'Rs. 1460', 'c', 'Amount = 1200x1.2 = Rs. 1440.', 'medium'),
  ('Find the true discount on Rs. 2400 due 4 years hence at 6% per annum.', 'Rs. 440', 'Rs. 450', 'Rs. 464.5', 'Rs. 480', 'c', 'TD = (2400x24)/124 ~ Rs. 464.5.', 'hard'),
  ('The true discount on Rs. 1050 due in 6 months is Rs. 50. Find the rate percent.', '8%', '9%', '10%', '12%', 'c', 'Solving the true discount equation gives R = 10%.', 'hard'),
  ('Find the sum due if the true discount on it, due 1 year hence at 5%, is Rs. 25.', 'Rs. 500', 'Rs. 510', 'Rs. 525', 'Rs. 540', 'c', 'Sum = 25x105/5 = Rs. 525.', 'medium'),
  ('The true discount on Rs. 1860 due after a certain time at 5% per annum is Rs. 60. Find the time.', '6 months', '8 months', '9 months', '12 months', 'b', 'Solving the true discount equation gives T = 2/3 year = 8 months.', 'hard'),
  ('Find the true discount on Rs. 3660 due 8 months hence at 10% per annum.', 'Rs. 200', 'Rs. 215', 'Rs. 228.9', 'Rs. 240', 'c', 'RT ~ 6.67; TD ~ Rs. 228.9.', 'hard'),
  ('Find the present worth of Rs. 2200 due 2 years hence at 10% per annum.', 'Rs. 1750', 'Rs. 1800', 'Rs. 1833.33', 'Rs. 1850', 'c', 'PW = 2200/1.2 ~ Rs. 1833.33.', 'medium'),
  ('A bill of Rs. 1250 is due in 9 months at 4% per annum. Find the true discount.', 'Rs. 32', 'Rs. 34', 'Rs. 36.4', 'Rs. 38', 'c', 'RT = 3; TD = (1250x3)/103 ~ Rs. 36.4.', 'medium'),
  ('Find the sum due 3 years hence at 5% per annum whose true discount is Rs. 150.', 'Rs. 1100', 'Rs. 1120', 'Rs. 1150', 'Rs. 1180', 'c', 'Sum = 150x115/15 = Rs. 1150.', 'medium'),
  ('Find the true discount on Rs. 1600 due 2.5 years hence at 4% per annum.', 'Rs. 130', 'Rs. 140', 'Rs. 145.45', 'Rs. 150', 'c', 'RT = 10; TD = (1600x10)/110 ~ Rs. 145.45.', 'hard'),
  ('The present worth of a sum due 6 months hence at 8% per annum is Rs. 4808. Find the sum.', 'Rs. 4900', 'Rs. 4950', 'Rs. 5000', 'Rs. 5050', 'c', 'Sum = 4808x1.04 ~ Rs. 5000.', 'hard'),
  ('Find the true discount on Rs. 2540 due 6 months hence at 4% per annum.', 'Rs. 45', 'Rs. 48', 'Rs. 49.8', 'Rs. 52', 'c', 'RT = 2; TD = (2540x2)/102 ~ Rs. 49.8.', 'medium'),
  ('A sum of Rs. 1200 is due in 3 years at 4% simple interest. Find the true discount.', 'Rs. 120', 'Rs. 124', 'Rs. 128.57', 'Rs. 132', 'c', 'TD = (1200x12)/112 ~ Rs. 128.57.', 'medium'),
  ('Find the present worth of Rs. 3600 due 4 years hence at 6.25% per annum simple interest.', 'Rs. 2800', 'Rs. 2850', 'Rs. 2880', 'Rs. 2900', 'c', 'RT = 25; PW = 3600/1.25 = Rs. 2880.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'true-discount';

-- ============================================================
-- Quantitative Aptitude > Banker's Discount (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the banker''s discount on Rs. 2000 due 2 years hence at 6% per annum.', 'Rs. 220', 'Rs. 230', 'Rs. 240', 'Rs. 250', 'c', 'BD = (2000x6x2)/100 = Rs. 240.', 'easy'),
  ('The banker''s discount on a bill due 1 year hence at 5% per annum is Rs. 100. Find the face value.', 'Rs. 1800', 'Rs. 1900', 'Rs. 2000', 'Rs. 2100', 'c', 'FV = (100x100)/5 = Rs. 2000.', 'medium'),
  ('Find the banker''s discount on Rs. 5400 due 8 months hence at 10% per annum.', 'Rs. 340', 'Rs. 350', 'Rs. 360.18', 'Rs. 370', 'c', 'RT ~ 6.67; BD ~ Rs. 360.18.', 'hard'),
  ('If the banker''s discount on a sum due 2 years hence at 5% per annum is Rs. 250, find the sum.', 'Rs. 2300', 'Rs. 2400', 'Rs. 2500', 'Rs. 2600', 'c', 'Sum = (250x100)/10 = Rs. 2500.', 'medium'),
  ('The banker''s gain on a bill due 6 months hence at 12% per annum is Rs. 6. Find the true discount.', 'Rs. 90', 'Rs. 95', 'Rs. 100', 'Rs. 110', 'c', 'Solving BG = (TDxRxT)/100 gives TD = Rs. 100.', 'hard'),
  ('Find the banker''s discount on Rs. 8000 due 1 year hence at 6% per annum.', 'Rs. 440', 'Rs. 460', 'Rs. 480', 'Rs. 500', 'c', 'BD = (8000x6)/100 = Rs. 480.', 'easy'),
  ('A bill of Rs. 3050 is due 9 months hence. Find the banker''s discount at 8% per annum.', 'Rs. 170', 'Rs. 178', 'Rs. 183', 'Rs. 190', 'c', 'RT = 6; BD = (3050x6)/100 = Rs. 183.', 'medium'),
  ('The banker''s discount and true discount on a sum due 1 year hence at 10% are Rs. 55 and Rs. 50. Find the sum.', 'Rs. 500', 'Rs. 525', 'Rs. 550', 'Rs. 575', 'c', 'Sum = TDx(100+RT)/RT = 50x110/10 = Rs. 550.', 'hard'),
  ('Find the banker''s discount on Rs. 6300 due 4 months hence at 15% per annum.', 'Rs. 290', 'Rs. 300', 'Rs. 315', 'Rs. 330', 'c', 'RT = 5; BD = (6300x5)/100 = Rs. 315.', 'medium'),
  ('If the true discount on a sum due 8 months hence at 12% is Rs. 480, find the banker''s discount.', 'Rs. 500', 'Rs. 510', 'Rs. 518.4', 'Rs. 525', 'c', 'BG = (480x12x8/12)/100 = 38.4; BD = 480+38.4 = Rs. 518.4.', 'hard'),
  ('Find the present worth of a bill of Rs. 1755 due 1 year hence, at 5% per annum for banker''s discount purposes.', 'Rs. 1650', 'Rs. 1660', 'Rs. 1671.43', 'Rs. 1680', 'c', 'TD = (1755x5)/105 ~ 83.57; PW = 1755-83.57 ~ Rs. 1671.43.', 'hard'),
  ('The banker''s discount on a sum due 3 years hence at 4% per annum is Rs. 360. Find the sum.', 'Rs. 2800', 'Rs. 2900', 'Rs. 3000', 'Rs. 3100', 'c', 'Sum = (360x100)/12 = Rs. 3000.', 'medium'),
  ('Find the banker''s gain on Rs. 4000 due 2 years hence at 5% per annum.', 'Rs. 30', 'Rs. 33', 'Rs. 36.36', 'Rs. 40', 'c', 'TD ~ 363.64; BD = 400; BG ~ Rs. 36.36.', 'hard'),
  ('A bill for Rs. 6000 is drawn at 6 months. If the banker''s discount is Rs. 180, find the rate of interest.', '5%', '6%', '7%', '8%', 'b', 'Solving (6000xRx0.5)/100 = 180 gives R = 6%.', 'medium'),
  ('Find the banker''s discount on Rs. 7200 due 1.5 years hence at 8% per annum.', 'Rs. 800', 'Rs. 830', 'Rs. 864', 'Rs. 880', 'c', 'BD = (7200x8x1.5)/100 = Rs. 864.', 'medium'),
  ('The true discount on a bill due 1 year hence at 6% per annum is Rs. 90. Find the banker''s gain.', 'Rs. 4.5', 'Rs. 5', 'Rs. 5.4', 'Rs. 6', 'c', 'BG = (90x6x1)/100 = Rs. 5.4.', 'medium'),
  ('Find the sum due if the banker''s discount on it, at 5% for 4 years, is Rs. 400.', 'Rs. 1800', 'Rs. 1900', 'Rs. 2000', 'Rs. 2100', 'c', 'Sum = (400x100)/20 = Rs. 2000.', 'medium'),
  ('A bill is discounted at 10% and the banker''s discount is Rs. 250 for 1 year. Find the face value.', 'Rs. 2300', 'Rs. 2400', 'Rs. 2500', 'Rs. 2600', 'c', 'FV = (250x100)/10 = Rs. 2500.', 'medium'),
  ('Find the banker''s discount on Rs. 12500 due 9 months hence at 8% per annum.', 'Rs. 700', 'Rs. 720', 'Rs. 750', 'Rs. 780', 'c', 'RT = 6; BD = (12500x6)/100 = Rs. 750.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'bankers-discount';

-- ============================================================
-- Quantitative Aptitude > Odd Man Out and Series (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the odd one out: 3, 6, 9, 12, 15, 20.', '9', '12', '15', '20', 'd', 'All others are multiples of 3; 20 is not.', 'easy'),
  ('Find the odd one out: 11, 13, 17, 19, 21, 23.', '17', '19', '21', '23', 'c', 'All others are prime; 21 = 3x7 is not.', 'medium'),
  ('Find the next term: 1, 2, 4, 8, 16, ?', '24', '28', '30', '32', 'd', 'Each term doubles the previous: 32.', 'easy'),
  ('Find the odd one out: 121, 144, 169, 180, 196.', '144', '169', '180', '196', 'c', 'All others are perfect squares; 180 is not.', 'medium'),
  ('Find the next term: 3, 7, 11, 15, 19, ?', '21', '22', '23', '24', 'c', 'The series increases by 4 each time: 23.', 'easy'),
  ('Find the odd one out: 10, 15, 21, 28, 35, 45.', '21', '28', '35', '45', 'c', 'These follow the triangular number pattern except 35, which should be 36.', 'hard'),
  ('Find the next term: 2, 5, 10, 17, 26, ?', '35', '36', '37', '38', 'c', 'Differences increase by 2 each time (3,5,7,9,11): 26+11 = 37.', 'medium'),
  ('Find the odd one out: 6, 11, 21, 36, 56, 82.', '21', '36', '56', '82', 'd', 'Differences increase by 5 each time; 82 should be 81.', 'hard'),
  ('Find the odd one out: 2, 3, 5, 7, 9, 11.', '5', '7', '9', '11', 'c', 'All others are prime; 9 = 3x3 is not.', 'medium'),
  ('Find the next term: 1, 4, 9, 16, 25, ?', '30', '32', '34', '36', 'd', 'These are perfect squares: 36.', 'easy'),
  ('Find the odd one out: 16, 25, 36, 49, 64, 90.', '36', '49', '64', '90', 'd', 'All others are perfect squares; 90 is not.', 'medium'),
  ('Find the next term: 5, 11, 23, 47, ?', '90', '92', '94', '95', 'd', 'Each term follows x2+1: 47x2+1 = 95.', 'medium'),
  ('Find the odd one out: 100, 81, 64, 49, 35, 25.', '64', '49', '35', '25', 'c', 'These are descending perfect squares except 35, which should be 36.', 'hard'),
  ('Find the next term: 4, 8, 16, 32, ?', '48', '56', '60', '64', 'd', 'Each term doubles: 64.', 'easy'),
  ('Find the odd one out: 7, 14, 28, 56, 112, 220.', '28', '56', '112', '220', 'd', 'Each term doubles except 220, which should be 224.', 'medium'),
  ('Find the next term: 100, 90, 81, 73, ?', '64', '65', '66', '68', 'c', 'Differences decrease by 1 each time (-10,-9,-8,-7): 73-7 = 66.', 'medium'),
  ('Find the odd one out: 15, 30, 45, 60, 80, 90.', '45', '60', '80', '90', 'c', 'All others are multiples of 15; 80 is not.', 'easy'),
  ('Find the next term: 2, 4, 8, 14, 22, ?', '28', '30', '32', '34', 'c', 'Differences increase by 2 each time (2,4,6,8,10): 22+10 = 32.', 'medium'),
  ('Find the odd one out: 12, 24, 48, 96, 200, 384.', '48', '96', '200', '384', 'c', 'Each term doubles except 200, which should be 192.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'odd-man-out-and-series';
