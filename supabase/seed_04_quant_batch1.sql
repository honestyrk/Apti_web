-- seed_04_quant_batch1.sql
-- Part of the "every topic gets at least 25 questions" content expansion.
-- This batch covers the 5 Quantitative Aptitude topics that currently have
-- zero questions (they were created by seed.sql but never seeded):
-- Time-Speed-Distance, Profit and Loss, Simple/Compound Interest,
-- Number System, Ratio and Proportion -- 25 hand-verified questions each.
-- Additive only; safe to run once after seed_03_remaining_topics.sql.

-- ============================================================
-- Quantitative Aptitude > Time, Speed and Distance
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A car covers 150 km in 3 hours. Find its speed.', '40 km/hr', '45 km/hr', '50 km/hr', '55 km/hr', 'c', 'Speed = distance/time = 150/3 = 50 km/hr.', 'easy'),
  ('A man walks at 5 km/hr. How long will he take to cover 20 km?', '3 hr', '3.5 hr', '4 hr', '4.5 hr', 'c', 'Time = distance/speed = 20/5 = 4 hours.', 'easy'),
  ('A train travels at 80 km/hr. How far will it travel in 2.5 hours?', '180 km', '190 km', '200 km', '210 km', 'c', 'Distance = speed x time = 80 x 2.5 = 200 km.', 'easy'),
  ('Convert 36 km/hr to m/s.', '8', '9', '10', '12', 'c', '36 x 5/18 = 10 m/s.', 'easy'),
  ('Convert 25 m/s to km/hr.', '80', '85', '90', '95', 'c', '25 x 18/5 = 90 km/hr.', 'easy'),
  ('A cyclist covers 45 km in 3 hours. Find his speed in m/s.', '3.5', '4.17', '4.5', '5', 'b', 'Speed = 15 km/hr = 15 x 5/18 ~ 4.17 m/s.', 'medium'),
  ('Two cars start from the same point and travel in opposite directions at 40 km/hr and 60 km/hr. How far apart will they be after 2 hours?', '180 km', '190 km', '200 km', '220 km', 'c', 'Relative speed = 100 km/hr; distance in 2 hr = 200 km.', 'easy'),
  ('A man covers a distance in 40 minutes at 6 km/hr. What is the distance?', '3 km', '3.5 km', '4 km', '4.5 km', 'c', 'Distance = 6 x (40/60) = 4 km.', 'medium'),
  ('A bus travels 300 km at a uniform speed. If the speed had been 5 km/hr more, it would have taken 2 hours less. Find the original speed.', '20 km/hr', '22 km/hr', '25 km/hr', '28 km/hr', 'c', 'Solving st = 300 and (s+5)(t-2) = 300 gives s = 25 km/hr.', 'hard'),
  ('A man travels from A to B at 30 km/hr and returns at 20 km/hr. Find his average speed for the whole journey.', '22 km/hr', '24 km/hr', '25 km/hr', '26 km/hr', 'b', 'Average speed = 2xy/(x+y) = 2x30x20/50 = 24 km/hr.', 'medium'),
  ('A train 100 m long is running at 50 km/hr. Find the time it takes to pass a stationary point.', '6 sec', '6.5 sec', '7.2 sec', '8 sec', 'c', 'Speed = 50 x 5/18 ~ 13.89 m/s. Time = 100/13.89 ~ 7.2 sec.', 'medium'),
  ('Excluding stoppages, a train travels at 60 km/hr; including stoppages, it travels at 50 km/hr. For how many minutes does the train stop per hour?', '8 min', '9 min', '10 min', '12 min', 'c', 'Speed loss = 10 km/hr, so stoppage time = (10/60) x 60 = 10 minutes.', 'medium'),
  ('A man covers half of his journey at 20 km/hr and the other half at 30 km/hr. Find his average speed.', '23 km/hr', '24 km/hr', '25 km/hr', '26 km/hr', 'b', 'Average speed = 2x20x30/50 = 24 km/hr.', 'medium'),
  ('A boy runs 500 m in 100 seconds. Find his speed in km/hr.', '15', '16', '18', '20', 'c', 'Speed = 5 m/s = 5 x 18/5 = 18 km/hr.', 'easy'),
  ('A car travels the first 100 km at 50 km/hr and the next 100 km at 100 km/hr. Find the average speed for the entire journey.', '60 km/hr', '65 km/hr', '66.67 km/hr', '70 km/hr', 'c', 'Average speed = 2x50x100/150 ~ 66.67 km/hr.', 'medium'),
  ('A man can walk at 4 km/hr. How much time will he take to walk a distance of 12 km?', '2.5 hr', '3 hr', '3.5 hr', '4 hr', 'b', 'Time = 12/4 = 3 hours.', 'easy'),
  ('Two trains start at the same time from stations 300 km apart and move towards each other at 40 km/hr and 60 km/hr. After how many hours will they meet?', '2 hr', '2.5 hr', '3 hr', '3.5 hr', 'c', 'Relative speed = 100 km/hr. Time = 300/100 = 3 hours.', 'medium'),
  ('A man walking at 3/4 of his usual speed takes 20 minutes more to cover a distance. Find his usual time to cover the distance.', '45 min', '50 min', '60 min', '70 min', 'c', '(3/4)(t+20) = t gives t = 60 minutes.', 'hard'),
  ('If a man walks at 14 km/hr instead of 10 km/hr, he would walk 20 km more in the same time. Find the actual distance traveled.', '40 km', '45 km', '50 km', '55 km', 'c', '4t = 20 gives t = 5 hr; actual distance = 10x5 = 50 km.', 'hard'),
  ('A car travels at 65 km/hr for 3 hours and then at 45 km/hr for 2 hours. Find the total distance covered.', '265 km', '275 km', '285 km', '295 km', 'c', 'Distance = 65x3 + 45x2 = 195+90 = 285 km.', 'easy'),
  ('The speed of a boat is 20 km/hr and the speed of a train is 60 km/hr. How many times faster is the train than the boat?', '2', '2.5', '3', '3.5', 'c', '60/20 = 3 times.', 'easy'),
  ('A man rows a boat at 10 km/hr in still water. Convert this speed to m/s.', '2.5', '2.78', '3', '3.2', 'b', '10 x 5/18 ~ 2.78 m/s.', 'easy'),
  ('A runner runs 400 m in 50 seconds. Find his speed in km/hr.', '25.2', '26.4', '28.8', '30', 'c', 'Speed = 8 m/s = 8 x 18/5 = 28.8 km/hr.', 'medium'),
  ('A cyclist covers a distance of 90 km in 4 hours 30 minutes. Find his speed.', '18 km/hr', '19 km/hr', '20 km/hr', '22 km/hr', 'c', 'Speed = 90/4.5 = 20 km/hr.', 'easy'),
  ('A train covers a distance of 12 km in 10 minutes. If it takes 8 hours to cover the distance between two stations, find that distance.', '560 km', '570 km', '576 km', '580 km', 'c', 'Speed = 12 km per 10 min = 72 km/hr. Distance = 72x8 = 576 km.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'time-speed-distance';

-- ============================================================
-- Quantitative Aptitude > Profit and Loss
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A shopkeeper buys an item for Rs. 200 and sells it for Rs. 250. Find his profit percentage.', '20%', '22%', '25%', '28%', 'c', 'Profit = Rs. 50; profit% = 50/200 x 100 = 25%.', 'easy'),
  ('An article is bought for Rs. 500 and sold at a loss of 10%. Find the selling price.', 'Rs. 430', 'Rs. 440', 'Rs. 450', 'Rs. 460', 'c', 'SP = 500 x 0.9 = Rs. 450.', 'easy'),
  ('A man sells an article for Rs. 720 at a profit of 20%. Find the cost price.', 'Rs. 560', 'Rs. 580', 'Rs. 600', 'Rs. 620', 'c', 'CP = 720/1.2 = Rs. 600.', 'easy'),
  ('A trader marks his goods 25% above cost price and allows a discount of 10%. Find his profit percentage.', '10%', '12.5%', '15%', '18%', 'b', 'SP factor = 1.25 x 0.9 = 1.125, so profit = 12.5%.', 'medium'),
  ('If the cost price of 10 articles equals the selling price of 8 articles, find the profit percentage.', '20%', '22%', '25%', '28%', 'c', '10 CP = 8 SP means SP = 1.25 CP, so profit = 25%.', 'medium'),
  ('A man sold an article at a loss of 15%. Had he sold it for Rs. 90 more, he would have gained 5%. Find the cost price.', 'Rs. 400', 'Rs. 420', 'Rs. 450', 'Rs. 480', 'c', '0.85x + 90 = 1.05x gives x = Rs. 450.', 'medium'),
  ('An article is sold for Rs. 990 after a discount of 10% on the marked price. Find the marked price.', 'Rs. 1050', 'Rs. 1080', 'Rs. 1100', 'Rs. 1150', 'c', 'MP = 990/0.9 = Rs. 1100.', 'easy'),
  ('A man buys an article and sells it at a gain of 5%. If he had bought it at 5% less and sold it for Rs. 2 less, he would have gained 10%. Find the cost price.', 'Rs. 350', 'Rs. 380', 'Rs. 400', 'Rs. 420', 'c', 'Solving 1.05x-2 = 1.10(0.95x) gives x = Rs. 400.', 'hard'),
  ('A man buys a table for Rs. 1200 and a chair for Rs. 800. He sells the table at a profit of 10% and the chair at a loss of 5%. Find his overall profit percentage.', '3%', '4%', '5%', '4% loss', 'b', 'Total CP = 2000, total SP = 1320+760 = 2080, profit = 80, i.e., 4%.', 'medium'),
  ('A dishonest dealer professes to sell his goods at cost price but uses a weight of 900 gm for a kg. Find his profit percentage.', '10%', '11.11%', '12%', '15%', 'b', 'Profit% = (1000-900)/900 x 100 ~ 11.11%.', 'medium'),
  ('If the selling price of an article is doubled, the profit triples. Find the original profit percentage.', '80%', '90%', '100%', '120%', 'c', 'Solving 2x-1 = 3(x-1) for CP=1 gives profit% = 100%.', 'hard'),
  ('A man sold two watches for Rs. 1000 each, one at a profit of 20% and the other at a loss of 20%. Find his overall profit or loss percentage.', 'No profit no loss', '4% loss', '4% profit', '5% loss', 'b', 'Total CP = 833.33+1250 = 2083.33, total SP = 2000, a loss of about 4%.', 'hard'),
  ('A shopkeeper allows a discount of 10% on the marked price and still makes a profit of 20%. If the cost price is Rs. 400, find the marked price.', 'Rs. 500', 'Rs. 520', 'Rs. 533.33', 'Rs. 550', 'c', 'SP = 400x1.2 = 480; MP = 480/0.9 ~ Rs. 533.33.', 'medium'),
  ('By selling an article for Rs. 261, a man loses 10%. Find the cost price.', 'Rs. 270', 'Rs. 280', 'Rs. 290', 'Rs. 300', 'c', 'CP = 261/0.9 = Rs. 290.', 'easy'),
  ('A man purchased 120 items at Rs. 10 each. He sold 100 of them at Rs. 12 each and the rest at Rs. 8 each. Find his overall profit percentage.', '10%', '12%', '13.33%', '15%', 'c', 'CP = 1200, SP = 1200+160 = 1360, profit = 160, i.e., 13.33%.', 'medium'),
  ('A trader sells goods at a 10% discount on the marked price and still gains 8%. If the marked price is Rs. 500, find the cost price.', 'Rs. 400', 'Rs. 410', 'Rs. 416.67', 'Rs. 420', 'c', 'SP = 500x0.9 = 450; CP = 450/1.08 ~ Rs. 416.67.', 'medium'),
  ('If the cost price is 80% of the selling price, find the profit percentage.', '20%', '22%', '25%', '28%', 'c', 'With SP=100, CP=80, profit=20, i.e., 25%.', 'medium'),
  ('A man loses 20% by selling an article for Rs. 400. Find the cost price.', 'Rs. 450', 'Rs. 480', 'Rs. 500', 'Rs. 520', 'c', 'CP = 400/0.8 = Rs. 500.', 'easy'),
  ('A shopkeeper sold an article for Rs. 2400, gaining 1/5 of its cost price. Find the cost price.', 'Rs. 1900', 'Rs. 1950', 'Rs. 2000', 'Rs. 2100', 'c', 'SP = 1.2 CP, so CP = 2400/1.2 = Rs. 2000.', 'medium'),
  ('Find the single discount equivalent to two successive discounts of 20% and 10%.', '25%', '28%', '30%', '32%', 'b', 'Equivalent discount = 1-(0.8x0.9) = 28%.', 'medium'),
  ('A man buys oranges at 6 for Rs. 10 and sells them at 4 for Rs. 8. Find his profit or loss percentage.', '15%', '18%', '20%', '22%', 'c', 'CP/orange = 1.667, SP/orange = 2, profit ~ 20%.', 'hard'),
  ('An article was sold at a loss of 5%. Had it been sold for Rs. 40 more, there would have been a gain of 5%. Find the cost price.', 'Rs. 350', 'Rs. 380', 'Rs. 400', 'Rs. 420', 'c', '0.95x+40 = 1.05x gives x = Rs. 400.', 'medium'),
  ('A man sells two horses for Rs. 1710 each, gaining 10% on one and losing 10% on the other. Find his overall gain or loss.', 'No profit no loss', 'About 1% loss', 'About 1% profit', 'About 2% loss', 'b', 'Total CP ~ 3454.55, total SP = 3420, a loss of about 1%.', 'hard'),
  ('A retailer buys 40 kg of rice at Rs. 25/kg and mixes it with 20 kg at Rs. 30/kg, then sells the mixture at Rs. 32/kg. Find his profit percentage.', '15%', '18%', '20%', '22%', 'c', 'Cost = 1600, revenue = 1920, profit = 320, i.e., 20%.', 'medium'),
  ('A man sells a watch at a 5% loss. If he had sold it for Rs. 56 more, he would have gained 3%. Find the cost price.', 'Rs. 650', 'Rs. 680', 'Rs. 700', 'Rs. 720', 'c', '0.95x+56 = 1.03x gives x = Rs. 700.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'profit-and-loss';

-- ============================================================
-- Quantitative Aptitude > Simple and Compound Interest
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the simple interest on Rs. 5000 at 8% per annum for 3 years.', 'Rs. 1000', 'Rs. 1100', 'Rs. 1200', 'Rs. 1300', 'c', 'SI = 5000x8x3/100 = Rs. 1200.', 'easy'),
  ('Find the simple interest on Rs. 10000 at 6% per annum for 2 years.', 'Rs. 1000', 'Rs. 1100', 'Rs. 1200', 'Rs. 1300', 'c', 'SI = 10000x6x2/100 = Rs. 1200.', 'easy'),
  ('Find the amount when Rs. 4000 is invested at 5% simple interest for 4 years.', 'Rs. 4600', 'Rs. 4700', 'Rs. 4800', 'Rs. 4900', 'c', 'SI = 800, amount = Rs. 4800.', 'easy'),
  ('Find the compound interest on Rs. 2000 at 10% per annum for 2 years, compounded annually.', 'Rs. 380', 'Rs. 400', 'Rs. 420', 'Rs. 440', 'c', 'A = 2000x1.1^2 = 2420; CI = Rs. 420.', 'medium'),
  ('Find the compound interest on Rs. 5000 at 10% per annum for 2 years.', 'Rs. 1000', 'Rs. 1020', 'Rs. 1050', 'Rs. 1080', 'c', 'A = 5000x1.21 = 6050; CI = Rs. 1050.', 'medium'),
  ('At what rate of simple interest will a sum double itself in 10 years?', '8%', '9%', '10%', '12%', 'c', '100 = PxRx10/100 gives R = 10%.', 'medium'),
  ('Find the simple interest on Rs. 15000 at 12% per annum for 3 years.', 'Rs. 5000', 'Rs. 5200', 'Rs. 5400', 'Rs. 5600', 'c', 'SI = 15000x12x3/100 = Rs. 5400.', 'easy'),
  ('A sum of money becomes Rs. 6200 in 2 years and Rs. 7400 in 3 years at simple interest. Find the sum.', 'Rs. 3600', 'Rs. 3700', 'Rs. 3800', 'Rs. 3900', 'c', 'Yearly SI = 1200; sum = 6200-2400 = Rs. 3800.', 'hard'),
  ('Find the compound interest on Rs. 8000 at 5% per annum for 2 years.', 'Rs. 780', 'Rs. 800', 'Rs. 820', 'Rs. 840', 'c', 'A = 8000x1.05^2 = 8820; CI = Rs. 820.', 'medium'),
  ('The simple interest on a sum for 2 years at 5% is Rs. 500. Find the sum.', 'Rs. 4500', 'Rs. 4800', 'Rs. 5000', 'Rs. 5200', 'c', 'Sum = 500x100/(5x2) = Rs. 5000.', 'easy'),
  ('Find the difference between simple interest and compound interest on Rs. 10000 for 2 years at 10% per annum.', 'Rs. 80', 'Rs. 90', 'Rs. 100', 'Rs. 110', 'c', 'SI = 2000, CI = 2100, difference = Rs. 100.', 'medium'),
  ('A sum of Rs. 1200 amounts to Rs. 1560 in 4 years at simple interest. Find the rate of interest.', '6%', '7%', '7.5%', '8%', 'c', 'SI = 360; R = 360x100/(1200x4) = 7.5%.', 'medium'),
  ('Find the compound interest on Rs. 12000 at 10% per annum for 3 years.', 'Rs. 3800', 'Rs. 3900', 'Rs. 3972', 'Rs. 4000', 'c', 'A = 12000x1.1^3 = 15972; CI = Rs. 3972.', 'hard'),
  ('A sum triples itself in 20 years at simple interest. Find the rate of interest.', '8%', '9%', '10%', '12%', 'c', 'SI = 2P over 20 years; R = 2x100/20 = 10%.', 'medium'),
  ('Find the amount on Rs. 3000 at 8% simple interest for 5 years.', 'Rs. 4000', 'Rs. 4100', 'Rs. 4200', 'Rs. 4300', 'c', 'SI = 1200; amount = Rs. 4200.', 'easy'),
  ('Find the compound interest on Rs. 15000 for 2 years at 8% per annum, compounded annually.', 'Rs. 2350', 'Rs. 2400', 'Rs. 2496', 'Rs. 2550', 'c', 'A = 15000x1.08^2 = 17496; CI = Rs. 2496.', 'medium'),
  ('A sum of Rs. 2500 is lent at 4% per annum simple interest. Find the interest earned in 6 years.', 'Rs. 500', 'Rs. 550', 'Rs. 600', 'Rs. 650', 'c', 'SI = 2500x4x6/100 = Rs. 600.', 'easy'),
  ('What principal will amount to Rs. 5600 in 4 years at 5% simple interest?', 'Rs. 4500', 'Rs. 4600', 'Rs. 4666.67', 'Rs. 4700', 'c', '5600 = 1.2P gives P ~ Rs. 4666.67.', 'medium'),
  ('Find the compound interest on Rs. 6000 at 10% per annum for 1.5 years, compounded half-yearly.', 'Rs. 900', 'Rs. 920', 'Rs. 945.75', 'Rs. 960', 'c', 'Rate/period = 5%, 3 periods: A = 6000x1.05^3 ~ 6945.75; CI ~ Rs. 945.75.', 'hard'),
  ('The simple interest on a certain sum at 5% per annum for 4 years is Rs. 2000 less than the sum itself. Find the sum.', 'Rs. 2300', 'Rs. 2400', 'Rs. 2500', 'Rs. 2600', 'c', 'P - 0.2P = 2000 gives P = Rs. 2500.', 'hard'),
  ('Find the rate percent per annum if Rs. 1000 becomes Rs. 1210 in 2 years at compound interest.', '8%', '9%', '10%', '12%', 'c', '(1+r)^2 = 1.21 gives r = 10%.', 'medium'),
  ('A sum of money at compound interest amounts to Rs. 4840 in 2 years and Rs. 5324 in 3 years. Find the rate of interest.', '8%', '9%', '10%', '12%', 'c', 'Ratio 5324/4840 = 1.1, so rate = 10%.', 'medium'),
  ('Find the simple interest on Rs. 7500 at 9% per annum for 8 months.', 'Rs. 400', 'Rs. 420', 'Rs. 450', 'Rs. 480', 'c', 'T = 2/3 yr; SI = 7500x9x(2/3)/100 = Rs. 450.', 'medium'),
  ('A man invests Rs. 5000 at 10% compound interest for 2 years. Find the difference between the interest of the 2nd year and the 1st year.', 'Rs. 40', 'Rs. 45', 'Rs. 50', 'Rs. 55', 'c', '1st year interest = 500; 2nd year interest = 550; difference = Rs. 50.', 'medium'),
  ('Find the amount of Rs. 20000 after 2 years at 15% per annum compound interest.', 'Rs. 26000', 'Rs. 26250', 'Rs. 26450', 'Rs. 26600', 'c', 'A = 20000x1.15^2 = Rs. 26450.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'simple-compound-interest';

-- ============================================================
-- Quantitative Aptitude > Number System
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the sum of the first 20 natural numbers.', '200', '205', '210', '215', 'c', 'Sum = n(n+1)/2 = 20x21/2 = 210.', 'easy'),
  ('Which of the following is a prime number?', '21', '27', '29', '33', 'c', '29 has no divisors other than 1 and itself.', 'easy'),
  ('Find the smallest 4-digit number divisible by 7.', '1000', '1001', '1003', '1005', 'b', '1000/7 ~ 142.86, so the next multiple is 143x7 = 1001.', 'medium'),
  ('What is the unit digit of 7^45?', '1', '3', '7', '9', 'c', 'The unit digit cycle of 7 is 7,9,3,1; 45 mod 4 = 1, so the unit digit is 7.', 'hard'),
  ('Find the number of prime numbers between 1 and 20.', '6', '7', '8', '9', 'c', 'They are 2,3,5,7,11,13,17,19 -- 8 primes.', 'medium'),
  ('Which of the following numbers is divisible by 11?', '121', '123', '125', '127', 'a', '121 = 11 x 11.', 'easy'),
  ('Find the largest 3-digit number divisible by 6.', '990', '993', '996', '999', 'c', '999/6 = 166.5, so 166x6 = 996.', 'medium'),
  ('If a number is divisible by both 3 and 4, it must be divisible by which of the following?', '6', '8', '12', '24', 'c', 'The LCM of 3 and 4 is 12.', 'easy'),
  ('Find the value of 25% expressed as a fraction.', '1/2', '1/3', '1/4', '1/5', 'c', '25% = 25/100 = 1/4.', 'easy'),
  ('What is the sum of the first 10 odd numbers?', '81', '90', '100', '110', 'c', 'Sum of first n odd numbers = n^2 = 100.', 'medium'),
  ('Find the HCF of 15 and 20 using prime factorization.', '3', '4', '5', '10', 'c', '15 = 3x5, 20 = 2^2x5; common factor = 5.', 'easy'),
  ('What is the remainder when 100 is divided by 7?', '1', '2', '3', '4', 'b', '100 = 14x7 + 2.', 'easy'),
  ('Find the number of factors of 36.', '6', '7', '8', '9', 'd', '36 = 2^2 x 3^2; number of factors = (2+1)(2+1) = 9.', 'medium'),
  ('Which of the following is NOT a perfect square?', '49', '64', '75', '81', 'c', '75 is not a perfect square; 49, 64, and 81 are.', 'easy'),
  ('Find the sum of the digits of 987654.', '35', '37', '39', '41', 'c', '9+8+7+6+5+4 = 39.', 'easy'),
  ('The difference between a positive number and its reciprocal is 24/5. Find the number.', '3', '4', '5', '6', 'c', 'Solving 5x^2-24x-5=0 gives x = 5 (the positive root).', 'hard'),
  ('Find the smallest number that must be added to 1000 to make it divisible by 17.', '2', '3', '4', '5', 'b', '1000/17 ~ 58.8; 59x17 = 1003, so add 3.', 'medium'),
  ('What is the unit digit of 3^100?', '1', '3', '7', '9', 'a', 'The unit digit cycle of 3 is 3,9,7,1; 100 mod 4 = 0, corresponding to the 4th term, 1.', 'hard'),
  ('Two numbers have a sum of 27 and a product of 182. Find the larger number.', '12', '13', '14', '15', 'c', 'Solving t^2-27t+182=0 gives the numbers 13 and 14.', 'medium'),
  ('Find the LCM of 18 and 24.', '60', '66', '72', '80', 'c', '18 = 2x3^2, 24 = 2^3x3; LCM = 2^3x3^2 = 72.', 'medium'),
  ('A number when divided by 5 leaves remainder 3. What is the remainder when its square is divided by 5?', '1', '2', '3', '4', 'd', '(5k+3)^2 = 25k^2+30k+9, and 9 mod 5 = 4.', 'hard'),
  ('Find the value of (2^3 x 3^2)/6.', '10', '11', '12', '14', 'c', '(8x9)/6 = 72/6 = 12.', 'easy'),
  ('How many two-digit numbers are divisible by 4?', '20', '21', '22', '23', 'c', 'From 12 to 96, count = (96-12)/4+1 = 22.', 'medium'),
  ('Find the sum of all factors of 12, excluding 12 itself.', '14', '15', '16', '18', 'c', 'Factors excluding 12: 1+2+3+4+6 = 16.', 'medium'),
  ('If x is even and y is odd, which of the following is always odd?', 'xy', 'x + y', 'x^2', 'y^2', 'b', 'An even number plus an odd number is always odd.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'number-system';

-- ============================================================
-- Quantitative Aptitude > Ratio and Proportion
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Simplify the ratio 24:36.', '1:2', '2:3', '3:4', '4:5', 'b', '24:36 simplifies by dividing both by 12 to give 2:3.', 'easy'),
  ('If a:b = 3:4 and b:c = 4:5, find a:b:c.', '3:4:5', '4:5:6', '2:3:4', '3:5:7', 'a', 'Since the b terms already match (4), a:b:c = 3:4:5.', 'easy'),
  ('Divide Rs. 900 between A and B in the ratio 4:5. Find A''s share.', 'Rs. 350', 'Rs. 380', 'Rs. 400', 'Rs. 420', 'c', 'A''s share = 900 x 4/9 = Rs. 400.', 'easy'),
  ('Two numbers are in the ratio 5:7. If their sum is 144, find the larger number.', '75', '80', '84', '90', 'c', 'Total parts = 12, each part = 12; larger number = 7x12 = 84.', 'easy'),
  ('If x:y = 2:3, find the value of (3x+2y):(2x+3y).', '11:13', '12:13', '13:12', '10:13', 'b', 'With x=2, y=3: numerator = 12, denominator = 13.', 'medium'),
  ('The ratio of the ages of A and B is 3:5. If the sum of their ages is 40, find B''s age.', '20', '22', '25', '28', 'c', 'Total parts = 8, each part = 5; B''s age = 5x5 = 25.', 'easy'),
  ('Find the fourth proportional to 3, 5, and 12.', '15', '18', '20', '22', 'c', '3:5 = 12:x gives x = 5x12/3 = 20.', 'medium'),
  ('Find the third proportional to 4 and 8.', '12', '14', '16', '18', 'c', '4:8 = 8:x gives x = 64/4 = 16.', 'medium'),
  ('Find the mean proportional between 9 and 16.', '10', '11', '12', '13', 'c', 'Mean proportional = sqrt(9x16) = sqrt(144) = 12.', 'medium'),
  ('If A:B = 2:3 and B:C = 5:7, find A:C.', '8:21', '10:21', '2:3', '5:7', 'b', 'Scaling B to 15: A:B = 10:15, B:C = 15:21, so A:C = 10:21.', 'hard'),
  ('The ratio of two numbers is 4:5 and their HCF is 6. Find their LCM.', '100', '110', '120', '130', 'c', 'Numbers = 24 and 30; LCM = 120.', 'medium'),
  ('If 2A = 3B = 4C, find A:B:C.', '6:4:3', '4:3:6', '3:4:6', '2:3:4', 'a', 'Using LCM 12: A=6k, B=4k, C=3k, giving A:B:C = 6:4:3.', 'hard'),
  ('Rs. 720 is divided among A, B, C in the ratio 2:3:4. Find C''s share.', 'Rs. 280', 'Rs. 300', 'Rs. 320', 'Rs. 340', 'c', 'C''s share = 720 x 4/9 = Rs. 320.', 'easy'),
  ('If a:b = 5:6, find (a+b):(a-b) using the magnitude of the difference.', '11:1', '6:5', '1:11', '5:6', 'a', 'With a=5, b=6: sum = 11, difference (magnitude) = 1.', 'medium'),
  ('Two numbers are in the ratio 3:4. If 10 is added to each, the ratio becomes 4:5. Find the smaller number.', '25', '28', '30', '32', 'c', 'Solving 5(3x+10) = 4(4x+10) gives x = 10; smaller number = 30.', 'hard'),
  ('If x:y = 3:2, find (2x+3y):(3x-2y).', '12:5', '5:12', '3:2', '2:3', 'a', 'With x=3, y=2: numerator = 12, denominator = 5.', 'medium'),
  ('A sum is divided among A, B, and C such that A gets 1/2, B gets 1/3, and C gets the rest. If C gets Rs. 200, find the total sum.', 'Rs. 1000', 'Rs. 1100', 'Rs. 1200', 'Rs. 1300', 'c', 'C''s share = 1/6 of total; total = 200x6 = Rs. 1200.', 'medium'),
  ('The ratio of boys to girls in a class is 3:2. If there are 30 boys, find the number of girls.', '15', '18', '20', '22', 'c', 'Each part = 10; girls = 2x10 = 20.', 'easy'),
  ('Find the ratio of 1.5 kg to 750 gm.', '3:1', '2:1', '3:2', '5:2', 'b', '1500 gm : 750 gm = 2:1.', 'easy'),
  ('If A:B = 1:2 and B:C = 3:4, find A:B:C.', '1:2:4', '3:6:8', '1:3:4', '2:3:4', 'b', 'Scaling B to 6: A:B = 3:6, B:C = 6:8, so A:B:C = 3:6:8.', 'medium'),
  ('Two quantities are in the ratio 7:9. If the first quantity is 63, find the second.', '72', '76', '81', '85', 'c', 'Each unit = 9; second quantity = 9x9 = 81.', 'easy'),
  ('The prices of a scooter and a television are in the ratio 3:2. If the scooter costs Rs. 6000 more than the television, find the price of the television.', 'Rs. 10000', 'Rs. 11000', 'Rs. 12000', 'Rs. 13000', 'c', 'Difference of 1 part = 6000; television = 2x6000 = Rs. 12000.', 'medium'),
  ('Divide 45 into two parts such that one part is 2/3 of the other. Find the smaller part.', '15', '16', '18', '20', 'c', 'Solving x + 2x/3 = 45 gives x = 27, so the smaller part is 45-27 = 18.', 'hard'),
  ('If 3 men or 5 women can do a piece of work in the same time, find the ratio of the efficiency of a man to a woman.', '5:3', '3:5', '2:1', '1:2', 'a', 'Since 3 men = 5 women in output, 1 man does the work of 5/3 women, giving ratio 5:3.', 'medium'),
  ('Coins in a bag are in the ratio 2:3:5 of Rs.1, Rs.2, and Rs.5 coins. If there are 20 Rs.1 coins, find the number of Rs.5 coins.', '40', '45', '50', '55', 'c', 'Each ratio unit = 10 coins; Rs.5 coins = 5x10 = 50.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'ratio-and-proportion';
