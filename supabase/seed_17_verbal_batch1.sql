-- seed_17_verbal_batch1.sql
-- Begins the Verbal Ability portion of the "every topic gets at least
-- 25 questions" expansion. Tops up Synonyms and Antonyms and Sentence
-- Correction (each originally seeded with 10 questions in seed.sql)
-- with 15 more each to reach 25.
-- Additive only; safe to run once after seed_16_reasoning_batch6.sql.

-- ============================================================
-- Verbal Ability > Synonyms and Antonyms (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Choose the synonym of "Abundant".', 'Scarce', 'Plentiful', 'Meager', 'Rare', 'b', 'Abundant means existing in large quantities, matching "Plentiful".', 'easy'),
  ('Choose the antonym of "Genuine".', 'Real', 'Authentic', 'Fake', 'True', 'c', 'Genuine means authentic; its opposite is "Fake".', 'easy'),
  ('Choose the synonym of "Reluctant".', 'Eager', 'Unwilling', 'Willing', 'Keen', 'b', 'Reluctant means hesitant or unwilling, matching "Unwilling".', 'easy'),
  ('Choose the antonym of "Ancient".', 'Old', 'Antique', 'Modern', 'Historic', 'c', 'Ancient means very old; its opposite is "Modern".', 'easy'),
  ('Choose the synonym of "Meticulous".', 'Careless', 'Careful', 'Sloppy', 'Hasty', 'b', 'Meticulous means showing great attention to detail, matching "Careful".', 'medium'),
  ('Choose the antonym of "Generous".', 'Kind', 'Giving', 'Stingy', 'Charitable', 'c', 'Generous means willing to give; its opposite is "Stingy".', 'easy'),
  ('Choose the synonym of "Concise".', 'Lengthy', 'Brief', 'Wordy', 'Detailed', 'b', 'Concise means giving information clearly in few words, matching "Brief".', 'medium'),
  ('Choose the antonym of "Humble".', 'Modest', 'Meek', 'Arrogant', 'Shy', 'c', 'Humble means modest; its opposite is "Arrogant".', 'medium'),
  ('Choose the synonym of "Vivid".', 'Dull', 'Bright', 'Faded', 'Pale', 'b', 'Vivid means producing powerful, clear images, matching "Bright".', 'medium'),
  ('Choose the antonym of "Fragile".', 'Delicate', 'Weak', 'Sturdy', 'Brittle', 'c', 'Fragile means easily broken; its opposite is "Sturdy".', 'easy'),
  ('Choose the synonym of "Persuade".', 'Discourage', 'Convince', 'Deter', 'Prevent', 'b', 'Persuade means to convince someone to do something, matching "Convince".', 'easy'),
  ('Choose the antonym of "Expand".', 'Grow', 'Enlarge', 'Contract', 'Increase', 'c', 'Expand means to grow larger; its opposite is "Contract".', 'easy'),
  ('Choose the synonym of "Obsolete".', 'Modern', 'Outdated', 'Current', 'New', 'b', 'Obsolete means no longer in use, matching "Outdated".', 'medium'),
  ('Choose the antonym of "Transparent".', 'Clear', 'Visible', 'Opaque', 'Sheer', 'c', 'Transparent means see-through; its opposite is "Opaque".', 'medium'),
  ('Choose the synonym of "Diligent".', 'Lazy', 'Hardworking', 'Idle', 'Careless', 'b', 'Diligent means showing care and effort, matching "Hardworking".', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'synonyms-antonyms';

-- ============================================================
-- Verbal Ability > Sentence Correction (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Choose the grammatically correct sentence.', 'He doesn''t knows the answer.', 'He not know the answer.', 'He doesn''t know the answer.', 'He don''t know the answer.', 'c', 'With a third-person singular subject, "doesn''t" is followed by the base verb "know".', 'easy'),
  ('Choose the grammatically correct sentence.', 'She has been working here since five years.', 'She has been working here for five years.', 'She is working here since five years.', 'She works here since five years.', 'b', 'A duration like "five years" takes "for", not "since".', 'medium'),
  ('Choose the grammatically correct sentence.', 'Each of the girls have brought her lunch.', 'Each of the girl has brought her lunch.', 'Each of the girls has brought her lunch.', 'Each of the girls has brought their lunch.', 'c', '"Each" takes a singular verb and a singular possessive: "has brought her lunch".', 'medium'),
  ('Choose the grammatically correct sentence.', 'Neither of them are wrong.', 'Neither of them is wrong.', 'Neither of them were wrong.', 'Neither of them being wrong.', 'b', '"Neither" takes a singular verb: "is wrong".', 'medium'),
  ('Choose the grammatically correct sentence.', 'The committee are deciding to postpone the meeting.', 'The committee decide to postpone the meeting.', 'The committee has decided to postpone the meeting.', 'The committee have decided to postpone the meeting.', 'c', 'When treated as a single unit, "committee" takes a singular verb: "has decided".', 'medium'),
  ('Choose the grammatically correct sentence.', 'He is junior than me in the company.', 'He is junior to me in the company.', 'He is more junior than me.', 'He is junior from me.', 'b', '"Junior" is followed by "to", not "than": "junior to me".', 'medium'),
  ('Choose the grammatically correct sentence.', 'I would rather to go than stay.', 'I would rather going than stay.', 'I would rather go than stay.', 'I would rather to going than stay.', 'c', '"Would rather" is followed by the base verb: "would rather go".', 'medium'),
  ('Choose the grammatically correct sentence.', 'She is good in mathematics.', 'She is good at mathematics.', 'She is good on mathematics.', 'She is good with mathematics.', 'b', '"Good" is followed by "at" for skills: "good at mathematics".', 'easy'),
  ('Choose the grammatically correct sentence.', 'He prevented me to go there.', 'He prevented me going there.', 'He prevented me from going there.', 'He prevented me to going there.', 'c', '"Prevent" is followed by "from" plus a gerund: "prevented me from going".', 'medium'),
  ('Choose the grammatically correct sentence.', 'They congratulated me for my success.', 'They congratulated me on my success.', 'They congratulated me at my success.', 'They congratulated me about my success.', 'b', '"Congratulate" is followed by "on": "congratulated me on my success".', 'medium'),
  ('Choose the grammatically correct sentence.', 'He is married with a doctor.', 'He is married at a doctor.', 'He is married to a doctor.', 'He is married for a doctor.', 'c', '"Married" is followed by "to": "married to a doctor".', 'medium'),
  ('Choose the grammatically correct sentence.', 'I am agree with you.', 'I agree with you.', 'I am agreeing with you.', 'I do agree you.', 'b', '"Agree" is a simple verb and does not take "am" before it: "I agree with you".', 'easy'),
  ('Choose the grammatically correct sentence.', 'She was accompanied with her sister.', 'She was accompanied to her sister.', 'She was accompanied by her sister.', 'She was accompanied from her sister.', 'c', '"Accompanied" is followed by "by": "accompanied by her sister".', 'medium'),
  ('Choose the grammatically correct sentence.', 'He succeeded to complete the task.', 'He succeeded in completing the task.', 'He succeeded at completing the task.', 'He succeeded on completing the task.', 'b', '"Succeed" is followed by "in" plus a gerund: "succeeded in completing".', 'medium'),
  ('Choose the grammatically correct sentence.', 'The news are surprising.', 'The news were surprising.', 'The news is surprising.', 'The news have surprised.', 'c', '"News" is treated as a singular noun: "The news is surprising".', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'sentence-correction';
