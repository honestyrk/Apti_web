-- seed.sql
-- Full category/branch/topic tree, plus sample MCQs for a representative
-- subset of topics so the app is testable immediately after setup.
-- Safe to re-run against a fresh database (uses ON CONFLICT DO NOTHING on
-- the unique slugs).

-- ============================================================
-- Categories
-- ============================================================
insert into public.categories (name, slug, description, display_order, has_branches) values
  ('Quantitative Aptitude', 'quantitative-aptitude', 'Numerical ability and mathematical problem solving.', 1, false),
  ('Logical Reasoning', 'logical-reasoning', 'Analytical and logical thinking puzzles.', 2, false),
  ('Verbal Ability', 'verbal-ability', 'English language, grammar, and comprehension.', 3, false),
  ('Technical', 'technical', 'Core subject questions organized by engineering branch.', 4, true)
on conflict (slug) do nothing;

-- ============================================================
-- Branches (Technical only)
-- ============================================================
insert into public.branches (category_id, name, slug, display_order)
select id, b.name, b.slug, b.display_order
from public.categories, (values
  ('Computer Science / IT', 'cs-it', 1),
  ('Electronics & Communication', 'ece', 2),
  ('Mechanical Engineering', 'mechanical', 3),
  ('Civil Engineering', 'civil', 4),
  ('Electrical & Electronics', 'eee', 5)
) as b(name, slug, display_order)
where categories.slug = 'technical'
on conflict (category_id, slug) do nothing;

-- ============================================================
-- Topics: Quantitative Aptitude
-- ============================================================
insert into public.topics (category_id, name, slug, display_order)
select id, t.name, t.slug, t.display_order
from public.categories, (values
  ('Percentages', 'percentages', 1),
  ('Time and Work', 'time-and-work', 2),
  ('Time, Speed and Distance', 'time-speed-distance', 3),
  ('Profit and Loss', 'profit-and-loss', 4),
  ('Simple and Compound Interest', 'simple-compound-interest', 5),
  ('Number System', 'number-system', 6),
  ('Ratio and Proportion', 'ratio-and-proportion', 7)
) as t(name, slug, display_order)
where categories.slug = 'quantitative-aptitude'
on conflict (category_id, slug) where branch_id is null do nothing;

-- ============================================================
-- Topics: Logical Reasoning
-- ============================================================
insert into public.topics (category_id, name, slug, display_order)
select id, t.name, t.slug, t.display_order
from public.categories, (values
  ('Blood Relations', 'blood-relations', 1),
  ('Coding-Decoding', 'coding-decoding', 2),
  ('Syllogisms', 'syllogisms', 3),
  ('Seating Arrangement', 'seating-arrangement', 4),
  ('Direction Sense', 'direction-sense', 5),
  ('Series Completion', 'series-completion', 6)
) as t(name, slug, display_order)
where categories.slug = 'logical-reasoning'
on conflict (category_id, slug) where branch_id is null do nothing;

-- ============================================================
-- Topics: Verbal Ability
-- ============================================================
insert into public.topics (category_id, name, slug, display_order)
select id, t.name, t.slug, t.display_order
from public.categories, (values
  ('Synonyms and Antonyms', 'synonyms-antonyms', 1),
  ('Sentence Correction', 'sentence-correction', 2),
  ('Para Jumbles', 'para-jumbles', 3),
  ('Reading Comprehension', 'reading-comprehension', 4),
  ('Fill in the Blanks', 'fill-in-the-blanks', 5)
) as t(name, slug, display_order)
where categories.slug = 'verbal-ability'
on conflict (category_id, slug) where branch_id is null do nothing;

-- ============================================================
-- Topics: Technical > CS/IT
-- ============================================================
insert into public.topics (category_id, branch_id, name, slug, display_order)
select c.id, b.id, t.name, t.slug, t.display_order
from public.categories c
join public.branches b on b.category_id = c.id and b.slug = 'cs-it',
(values
  ('OOP Concepts', 'oop-concepts', 1),
  ('DBMS', 'dbms', 2),
  ('Operating Systems', 'operating-systems', 3),
  ('Computer Networks', 'computer-networks', 4),
  ('Data Structures', 'data-structures', 5)
) as t(name, slug, display_order)
where c.slug = 'technical'
on conflict (category_id, branch_id, slug) where branch_id is not null do nothing;

-- ============================================================
-- Topics: Technical > ECE
-- ============================================================
insert into public.topics (category_id, branch_id, name, slug, display_order)
select c.id, b.id, t.name, t.slug, t.display_order
from public.categories c
join public.branches b on b.category_id = c.id and b.slug = 'ece',
(values
  ('Digital Electronics', 'digital-electronics', 1),
  ('Analog Electronics', 'analog-electronics', 2),
  ('Communication Systems', 'communication-systems', 3)
) as t(name, slug, display_order)
where c.slug = 'technical'
on conflict (category_id, branch_id, slug) where branch_id is not null do nothing;

-- ============================================================
-- Topics: Technical > Mechanical
-- ============================================================
insert into public.topics (category_id, branch_id, name, slug, display_order)
select c.id, b.id, t.name, t.slug, t.display_order
from public.categories c
join public.branches b on b.category_id = c.id and b.slug = 'mechanical',
(values
  ('Thermodynamics', 'thermodynamics', 1),
  ('Strength of Materials', 'strength-of-materials', 2),
  ('Fluid Mechanics', 'fluid-mechanics', 3)
) as t(name, slug, display_order)
where c.slug = 'technical'
on conflict (category_id, branch_id, slug) where branch_id is not null do nothing;

-- ============================================================
-- Topics: Technical > Civil
-- ============================================================
insert into public.topics (category_id, branch_id, name, slug, display_order)
select c.id, b.id, t.name, t.slug, t.display_order
from public.categories c
join public.branches b on b.category_id = c.id and b.slug = 'civil',
(values
  ('Structural Analysis', 'structural-analysis', 1),
  ('Surveying', 'surveying', 2),
  ('Building Materials', 'building-materials', 3)
) as t(name, slug, display_order)
where c.slug = 'technical'
on conflict (category_id, branch_id, slug) where branch_id is not null do nothing;

-- ============================================================
-- Topics: Technical > EEE
-- ============================================================
insert into public.topics (category_id, branch_id, name, slug, display_order)
select c.id, b.id, t.name, t.slug, t.display_order
from public.categories c
join public.branches b on b.category_id = c.id and b.slug = 'eee',
(values
  ('Electrical Machines', 'electrical-machines', 1),
  ('Power Systems', 'power-systems', 2),
  ('Control Systems', 'control-systems', 3)
) as t(name, slug, display_order)
where c.slug = 'technical'
on conflict (category_id, branch_id, slug) where branch_id is not null do nothing;

-- ============================================================
-- Sample questions: Quantitative Aptitude > Percentages
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('What is 25% of 480?', '100', '110', '120', '130', 'c', '25% of 480 = 480 x 25/100 = 120.', 'easy'),
  ('If 40% of a number is 200, what is the number?', '400', '450', '500', '550', 'c', 'Number = 200 / 0.40 = 500.', 'easy'),
  ('A number is increased by 20% and then decreased by 20%. What is the net change?', 'No change', '-4%', '+4%', '-20%', 'b', 'Net change = ((100+20)(100-20)/100) - 100 = (120x80/100) - 100 = 96 - 100 = -4%.', 'medium'),
  ('A student scored 65% and failed by 10 marks. Another scored 75% and got 20 marks more than the passing marks. Find the passing marks.', '195', '200', '205', '210', 'c', 'Let total = T. 0.65T + 10 = 0.75T - 20 => 0.10T = 30 => T = 300. Passing marks = 0.65(300)+10 = 205.', 'hard'),
  ('What percentage of 2 hours is 45 minutes?', '30%', '35%', '37.5%', '40%', 'c', '45/120 x 100 = 37.5%.', 'easy'),
  ('If the price of an item is increased by 25%, by what percentage should the new price be decreased to restore the original price?', '25%', '20%', '15%', '30%', 'b', 'Required decrease = 25/(100+25) x 100 = 20%.', 'medium'),
  ('60% of a number is 50 more than 20% of the same number. Find the number.', '100', '110', '125', '130', 'c', '0.6x - 0.2x = 50 => 0.4x = 50 => x = 125.', 'medium'),
  ('In a class of 60 students, 40% are girls. How many boys are there?', '30', '34', '36', '38', 'c', 'Girls = 40% of 60 = 24. Boys = 60 - 24 = 36.', 'easy'),
  ('A shopkeeper marks up goods by 40% and gives a discount of 10%. What is his profit percentage?', '20%', '24%', '26%', '30%', 'c', 'Effective price factor = 1.40 x 0.90 = 1.26, so profit = 26%.', 'medium'),
  ('If x is 20% more than y, then y is what percent less than x?', '16.67%', '20%', '25%', '15%', 'a', 'y = x/1.2, so y is less than x by (1 - 1/1.2) x 100 = 16.67%.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'percentages';

-- ============================================================
-- Sample questions: Quantitative Aptitude > Time and Work
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A can do a work in 10 days, B in 15 days. Working together, how many days will they take?', '5', '6', '7', '8', 'b', 'Combined rate = 1/10 + 1/15 = 1/6, so 6 days.', 'easy'),
  ('A does a work in 12 days, B in 18 days. They work together for 4 days, then A leaves. In how many more days will B finish the remaining work?', '6', '7', '8', '9', 'c', 'Combined rate = 5/36/day; in 4 days, 5/9 done, 4/9 remains. B alone takes (4/9)/(1/18) = 8 days.', 'hard'),
  ('6 men can complete a work in 12 days. How many men are needed to complete it in 8 days?', '8', '9', '10', '12', 'b', 'Men x days is constant: 6x12 = 72, so 72/8 = 9 men.', 'easy'),
  ('A is twice as efficient as B. Together they finish a work in 6 days. In how many days can A alone finish it?', '8', '9', '10', '12', 'b', 'B rate = x, A rate = 2x, combined = 3x = 1/6 => x = 1/18. A rate = 2/18 = 1/9, so 9 days.', 'medium'),
  ('Pipes A and B can fill a tank in 20 and 30 minutes. Pipe C can empty it in 15 minutes. If all three are opened together, how long to fill the tank?', '40', '50', '60', '72', 'c', 'Rate = 1/20 + 1/30 - 1/15 = 1/60, so 60 minutes.', 'hard'),
  ('15 workers can complete a task in 10 days. After 4 days, 5 workers leave. How many total days will the work take?', '12', '13', '14', '15', 'b', 'Total work = 150 units. In 4 days, 60 done, 90 remain. 10 workers remain: 9 more days. Total = 4+9 = 13.', 'hard'),
  ('A and B together can do a job in 8 days. A alone can do it in 12 days. How long would B alone take?', '20', '22', '24', '26', 'c', '1/12 + 1/B = 1/8 => 1/B = 1/24, so B takes 24 days.', 'medium'),
  ('12 men can complete a work in 8 days. How many men are required to complete the work in 6 days?', '14', '15', '16', '18', 'c', 'Men x days constant: 12x8 = 96, so 96/6 = 16 men.', 'easy'),
  ('A can finish a work in 18 days and B in 15 days. B worked for 10 days and left. How many days will A alone take to finish the remaining work?', '4', '5', '6', '7', 'c', 'B completes 10/15 = 2/3 of the work; 1/3 remains. A takes (1/3)/(1/18) = 6 days.', 'medium'),
  ('Efficiency of A is 25% more than B. If B can complete a work in 25 days, in how many days can A complete it?', '18', '20', '22', '24', 'b', 'A rate = 1.25 x B rate, so A time = 25/1.25 = 20 days.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'time-and-work';

-- ============================================================
-- Sample questions: Logical Reasoning > Blood Relations
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Pointing to a man, a woman said, "His mother is the only daughter of my mother." How is the woman related to the man?', 'Sister', 'Mother', 'Aunt', 'Grandmother', 'b', 'The only daughter of the woman''s mother is the woman herself, so the man''s mother is the woman -- she is his mother.', 'medium'),
  ('A is B''s sister. C is B''s mother. D is C''s father. E is D''s mother. How is A related to D?', 'Daughter', 'Granddaughter', 'Mother', 'Sister', 'b', 'D is C''s father, C is A''s mother, so D is A''s grandfather and A is his granddaughter.', 'medium'),
  ('Introducing a boy, a girl said, "He is the son of my grandfather''s only son." How is the girl related to the boy?', 'Cousin', 'Sister', 'Niece', 'Mother', 'b', 'The grandfather''s only son is the girl''s father, so the boy is the girl''s brother -- she is his sister.', 'medium'),
  ('P is Q''s brother. R is Q''s mother. S is R''s father. T is S''s mother. How is P related to S?', 'Son', 'Grandson', 'Father', 'Grandfather', 'b', 'S is R''s father, R is P''s mother, so S is P''s grandfather and P is his grandson.', 'medium'),
  ('Deepak said, "This girl is the wife of the grandson of my mother." How is Deepak related to the girl?', 'Father', 'Father-in-law', 'Grandfather', 'Uncle', 'b', 'The grandson of Deepak''s mother is Deepak''s son (or nephew); as the wife of Deepak''s son, the girl is his daughter-in-law, so Deepak is her father-in-law.', 'hard'),
  ('A man said to a woman, "Your mother''s husband''s sister is my aunt." How is the woman related to the man?', 'Sister', 'Cousin', 'Niece', 'Daughter', 'b', 'The woman''s mother''s husband is her father, and his sister is the man''s aunt too, making them cousins.', 'medium'),
  ('X and Y are sisters. R is X''s mother. S is R''s father. T is S''s mother. How is Y related to S?', 'Daughter', 'Granddaughter', 'Sister', 'Niece', 'b', 'S is R''s father, R is Y''s mother, so S is Y''s grandfather and Y is his granddaughter.', 'medium'),
  ('Introducing a man, a woman said, "He is the only son of my mother''s mother." How is the woman related to the man?', 'Sister', 'Niece', 'Daughter', 'Mother', 'b', 'The only son of the woman''s grandmother is her mother''s brother, i.e., her maternal uncle -- she is his niece.', 'hard'),
  ('A is the father of B. B is the sister of C. C is the son of D. How is D related to A?', 'Wife', 'Sister', 'Daughter', 'Mother', 'a', 'B and C are children of A, and D is C''s mother, so D is A''s wife.', 'medium'),
  ('Ram introduces Sita as the daughter of the only son of his grandfather. How is Sita related to Ram?', 'Sister', 'Cousin', 'Niece', 'Daughter', 'a', 'The only son of Ram''s grandfather is Ram''s father, so Sita, his daughter, is Ram''s sister.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'blood-relations';

-- ============================================================
-- Sample questions: Logical Reasoning > Coding-Decoding
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('If CAT is coded as DBU, how is DOG coded?', 'EPH', 'EPG', 'FQH', 'EQI', 'a', 'Each letter is shifted forward by 1: D->E, O->P, G->H, giving EPH.', 'easy'),
  ('In a code language, ROSE is written as URVH. How is CHAIR written in that code?', 'FKDLU', 'FKDLV', 'EKDLU', 'FKELU', 'a', 'Each letter is shifted forward by 3: C->F, H->K, A->D, I->L, R->U, giving FKDLU.', 'medium'),
  ('If MONEY is written as NPOFZ, how is SILVER written?', 'TJMWFS', 'TJNWFS', 'TJMWFT', 'SJMWFS', 'a', 'Each letter is shifted forward by 1: S->T, I->J, L->M, V->W, E->F, R->S, giving TJMWFS.', 'easy'),
  ('If PAPER is coded as QBQFS, how is PENCIL coded?', 'QFODJM', 'QFODJN', 'PFODJM', 'QFOCJM', 'a', 'Each letter is shifted forward by 1: P->Q, E->F, N->O, C->D, I->J, L->M, giving QFODJM.', 'medium'),
  ('If each letter is replaced by its opposite letter in the alphabet (A<->Z, B<->Y, ...) so that GARDEN becomes TZIWVM, how would FRUIT be written?', 'UIFRG', 'UIRFG', 'IUFRG', 'UIFGR', 'a', 'F<->U, R<->I, U<->F, I<->R, T<->G, giving UIFRG.', 'hard'),
  ('If 1=A, 2=B, 3=C ... 26=Z, what word does 19-9-12-5-14-20 spell?', 'SILENT', 'SALIENT', 'SIGNAL', 'SILVER', 'a', '19=S, 9=I, 12=L, 5=E, 14=N, 20=T, spelling SILENT.', 'easy'),
  ('In a certain code, BOOK is written as CPPL. How is PAGE written?', 'QBHF', 'QBGF', 'PBHF', 'QCHF', 'a', 'Each letter is shifted forward by 1: P->Q, A->B, G->H, E->F, giving QBHF.', 'easy'),
  ('If WATER is coded as YCVGT, how is EARTH coded?', 'GCTVJ', 'GCTVK', 'GCUVJ', 'FCTVJ', 'a', 'Each letter is shifted forward by 2: E->G, A->C, R->T, T->V, H->J, giving GCTVJ.', 'medium'),
  ('If FLOWER is coded as HNQYGT, how is GARDEN coded?', 'ICTFGP', 'ICTFGO', 'ICSFGP', 'ICTEGP', 'a', 'Each letter is shifted forward by 2: G->I, A->C, R->T, D->F, E->G, N->P, giving ICTFGP.', 'medium'),
  ('In a certain code, BLUE is written as 2-12-21-5. How would GREEN be written?', '7-18-5-5-14', '7-19-5-5-14', '7-18-5-4-14', '8-18-5-5-14', 'a', 'Each letter maps to its position in the alphabet: G=7, R=18, E=5, E=5, N=14.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'coding-decoding';

-- ============================================================
-- Sample questions: Verbal Ability > Synonyms and Antonyms
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Choose the synonym of "Benevolent".', 'Cruel', 'Kind', 'Selfish', 'Timid', 'b', 'Benevolent means well-meaning and kindly, so the closest synonym is "Kind".', 'easy'),
  ('Choose the antonym of "Meticulous".', 'Careful', 'Precise', 'Careless', 'Thorough', 'c', 'Meticulous means showing great attention to detail; its opposite is "Careless".', 'easy'),
  ('Choose the synonym of "Candid".', 'Frank', 'Secretive', 'Rude', 'Shy', 'a', 'Candid means truthful and straightforward, closest to "Frank".', 'easy'),
  ('Choose the antonym of "Abundant".', 'Plentiful', 'Scarce', 'Generous', 'Ample', 'b', 'Abundant means existing in large quantities; its opposite is "Scarce".', 'easy'),
  ('Choose the synonym of "Ephemeral".', 'Eternal', 'Short-lived', 'Ancient', 'Solid', 'b', 'Ephemeral means lasting for a very short time, matching "Short-lived".', 'medium'),
  ('Choose the antonym of "Diligent".', 'Hardworking', 'Careful', 'Lazy', 'Sincere', 'c', 'Diligent means showing care in one''s work; its opposite is "Lazy".', 'easy'),
  ('Choose the synonym of "Pragmatic".', 'Idealistic', 'Practical', 'Emotional', 'Naive', 'b', 'Pragmatic means dealing with things sensibly and realistically, matching "Practical".', 'medium'),
  ('Choose the antonym of "Verbose".', 'Wordy', 'Lengthy', 'Concise', 'Talkative', 'c', 'Verbose means using more words than needed; its opposite is "Concise".', 'medium'),
  ('Choose the synonym of "Austere".', 'Strict', 'Lenient', 'Luxurious', 'Kind', 'a', 'Austere means severe or strict in manner, matching "Strict".', 'medium'),
  ('Choose the antonym of "Optimistic".', 'Hopeful', 'Positive', 'Pessimistic', 'Confident', 'c', 'Optimistic means hopeful about the future; its opposite is "Pessimistic".', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'synonyms-antonyms';

-- ============================================================
-- Sample questions: Verbal Ability > Sentence Correction
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Choose the grammatically correct sentence.', 'She don''t like coffee.', 'She doesn''t likes coffee.', 'She doesn''t like coffee.', 'She not like coffee.', 'c', 'With a third-person singular subject, the correct auxiliary is "doesn''t" followed by the base verb "like".', 'easy'),
  ('Choose the grammatically correct sentence.', 'Neither of the boys were present.', 'Neither of the boys was present.', 'Neither of the boys are present.', 'Neither of the boys have present.', 'b', '"Neither" takes a singular verb, so "was present" is correct.', 'medium'),
  ('Choose the grammatically correct sentence.', 'He is one of the best player in the team.', 'He is one of the best players in the team.', 'He is one of best player in team.', 'He are one of the best players.', 'b', '"One of the" is followed by a plural noun: "best players".', 'easy'),
  ('Choose the grammatically correct sentence.', 'Each of the students have submitted their assignment.', 'Each of the students has submitted his assignment.', 'Each of the students has submit their assignment.', 'Each of the student have submitted assignment.', 'b', '"Each" takes a singular verb: "has submitted".', 'medium'),
  ('Choose the grammatically correct sentence.', 'The number of accidents have increased.', 'The number of accidents has increased.', 'The numbers of accident has increased.', 'A number of accident has increase.', 'b', '"The number of" takes a singular verb: "has increased".', 'medium'),
  ('Choose the grammatically correct sentence.', 'She is senior than me.', 'She is senior to me.', 'She is more senior than me.', 'She is more senior to me.', 'b', '"Senior" is followed by "to", not "than": "senior to me".', 'medium'),
  ('Choose the grammatically correct sentence.', 'I have been living here since five years.', 'I have been living here for five years.', 'I am living here since five years.', 'I live here since five years.', 'b', 'A duration like "five years" takes "for", not "since".', 'medium'),
  ('Choose the grammatically correct sentence.', 'He is capable to do this work.', 'He is capable of doing this work.', 'He is capable for this work.', 'He is capable doing this work.', 'b', '"Capable" is followed by "of" plus a gerund: "capable of doing".', 'medium'),
  ('Choose the grammatically correct sentence.', 'Please explain me this problem.', 'Please explain this problem to me.', 'Please explain me about this problem.', 'Please explain to me problem.', 'b', '"Explain" takes the object after "to": "explain this problem to me".', 'medium'),
  ('Choose the grammatically correct sentence.', 'He insisted to go there.', 'He insisted on going there.', 'He insisted for going there.', 'He insisted going there.', 'b', '"Insist" is followed by "on" plus a gerund: "insisted on going".', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'sentence-correction';

-- ============================================================
-- Sample questions: Technical > CS/IT > OOP Concepts
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Which OOP concept allows a class to inherit properties from another class?', 'Encapsulation', 'Inheritance', 'Polymorphism', 'Abstraction', 'b', 'Inheritance lets a class (subclass) acquire properties and behavior from another class (superclass).', 'easy'),
  ('Which concept refers to bundling data and the methods that operate on it within a single unit?', 'Abstraction', 'Encapsulation', 'Inheritance', 'Polymorphism', 'b', 'Encapsulation wraps data and methods together and restricts direct access to internal state.', 'easy'),
  ('What is method overriding?', 'Same method name with different parameters in the same class', 'Redefining a parent class method in a child class with the same signature', 'Declaring a method as static', 'Hiding a variable', 'b', 'Overriding lets a subclass provide a specific implementation of a method already defined in its superclass, with the same signature.', 'medium'),
  ('What is method overloading?', 'Same method name with different parameter lists in the same class', 'Overriding a parent class method', 'Using multiple classes together', 'Declaring multiple constructors only', 'a', 'Overloading allows multiple methods with the same name but different parameter lists within the same class.', 'medium'),
  ('Which OOP principle hides implementation details and shows only essential functionality to the user?', 'Encapsulation', 'Abstraction', 'Polymorphism', 'Inheritance', 'b', 'Abstraction focuses on exposing only relevant details while hiding the complex implementation.', 'medium'),
  ('Which of the following is NOT a pillar of OOP?', 'Encapsulation', 'Polymorphism', 'Compilation', 'Inheritance', 'c', 'The four pillars of OOP are Encapsulation, Abstraction, Inheritance, and Polymorphism -- compilation is not one of them.', 'easy'),
  ('A class that cannot be instantiated on its own is called?', 'Final class', 'Abstract class', 'Static class', 'Sealed class', 'b', 'An abstract class cannot be instantiated directly and is meant to be subclassed.', 'medium'),
  ('What is a constructor?', 'A method to destroy objects', 'A special method automatically called when an object is created', 'A static utility method', 'An interface method', 'b', 'A constructor initializes a new object and is invoked automatically at creation time.', 'easy'),
  ('Which type of polymorphism is resolved at compile time?', 'Dynamic polymorphism', 'Static polymorphism', 'Runtime polymorphism', 'None of the above', 'b', 'Method overloading is resolved at compile time and is known as static (or compile-time) polymorphism.', 'medium'),
  ('Which keyword is commonly used to prevent a class from being inherited (e.g., in Java)?', 'static', 'final', 'private', 'abstract', 'b', 'Marking a class as "final" prevents any other class from extending it.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'oop-concepts';

-- ============================================================
-- Sample questions: Technical > CS/IT > DBMS
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Which normal form removes partial dependency on a composite primary key?', '1NF', '2NF', '3NF', 'BCNF', 'b', 'Second Normal Form (2NF) eliminates partial dependency of non-key attributes on part of a composite key.', 'medium'),
  ('What does ACID stand for in database transactions?', 'Atomicity, Consistency, Isolation, Durability', 'Association, Consistency, Integrity, Durability', 'Atomicity, Concurrency, Isolation, Durability', 'Atomicity, Consistency, Independence, Durability', 'a', 'ACID properties -- Atomicity, Consistency, Isolation, Durability -- guarantee reliable transaction processing.', 'easy'),
  ('Which key is used to uniquely identify a record in a table?', 'Foreign key', 'Candidate key', 'Primary key', 'Composite key', 'c', 'A primary key uniquely identifies each record in a table and cannot contain NULL values.', 'easy'),
  ('Which SQL command removes a table''s structure along with its data?', 'DELETE', 'TRUNCATE', 'DROP', 'REMOVE', 'c', 'DROP TABLE removes the table definition and all its data permanently.', 'easy'),
  ('Which join returns all rows from both tables, with matching rows combined and non-matching rows filled with NULLs?', 'INNER JOIN', 'LEFT JOIN', 'FULL OUTER JOIN', 'CROSS JOIN', 'c', 'A FULL OUTER JOIN returns all rows from both tables, matching where possible and using NULLs otherwise.', 'medium'),
  ('What is a deadlock in a DBMS?', 'A transaction failure due to a syntax error', 'A situation where two or more transactions wait indefinitely for each other', 'A data redundancy issue', 'An index corruption issue', 'b', 'A deadlock occurs when transactions hold locks the others need, causing all of them to wait forever.', 'medium'),
  ('Which normal form deals with removing transitive dependency?', '1NF', '2NF', '3NF', 'BCNF', 'c', 'Third Normal Form (3NF) removes transitive dependencies of non-key attributes on the primary key.', 'medium'),
  ('What does the SQL GROUP BY clause do?', 'Sorts rows in ascending order', 'Groups rows sharing a property so aggregate functions can be applied', 'Filters rows based on a condition', 'Joins two or more tables', 'b', 'GROUP BY groups rows with the same values so aggregate functions like COUNT, SUM, or AVG can operate per group.', 'medium'),
  ('Which of the following is a DDL (Data Definition Language) command?', 'SELECT', 'INSERT', 'CREATE', 'UPDATE', 'c', 'CREATE defines database structures and belongs to DDL, while SELECT, INSERT, and UPDATE are DML commands.', 'easy'),
  ('A foreign key is used to:', 'Uniquely identify rows within the same table', 'Establish a relationship between two tables', 'Encrypt sensitive data', 'Automatically index a table', 'b', 'A foreign key references a primary key in another table, enforcing referential integrity between them.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'dbms';
