-- seed_12_reasoning_batch2.sql
-- Continues the topic-expansion pass for Logical Reasoning. Tops up
-- Blood Relations and Coding-Decoding (each originally seeded with 10
-- questions in seed.sql) with 15 more each to reach 25.
-- Additive only; safe to run once after seed_11_reasoning_batch1.sql.

-- ============================================================
-- Logical Reasoning > Blood Relations (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('A is the brother of B. C is the mother of A. D is the father of C. How is B related to D?', 'Son', 'Daughter', 'Grandchild', 'Nephew', 'c', 'C is the mother of both A and B, and D is C''s father, so D is the grandparent of both -- B is his grandchild.', 'medium'),
  ('Pointing to a photograph, a man says, "She is the daughter of my grandfather''s only son." How is the girl related to the man?', 'Daughter', 'Sister', 'Wife', 'Niece', 'b', 'The grandfather''s only son is the man''s father, so the girl -- his father''s daughter -- is his sister.', 'medium'),
  ('A''s father is B. B has only one sibling C. C has a son D. How is D related to A?', 'Brother', 'Cousin', 'Nephew', 'Uncle', 'b', 'C is B''s sibling, making C A''s uncle/aunt; D, C''s son, is therefore A''s cousin.', 'medium'),
  ('Introducing a man, a woman said, "His wife is the only daughter of my father." How is the woman related to the man?', 'Sister', 'Wife', 'Mother', 'Daughter', 'b', 'The only daughter of the woman''s father is the woman herself, so she is the man''s wife.', 'medium'),
  ('P is the son of Q. Q is the mother of R. S is the father of P. How is S related to Q?', 'Father', 'Husband', 'Brother', 'Son', 'b', 'S is P''s father and Q is P''s mother, so S is Q''s husband.', 'medium'),
  ('A woman introduces a man as "the son of the brother of my mother." How is the man related to the woman?', 'Brother', 'Cousin', 'Nephew', 'Uncle', 'b', 'The brother of the woman''s mother is her maternal uncle; his son is her cousin.', 'medium'),
  ('If A is B''s sister, C is B''s mother, D is C''s father, and E is D''s mother, how is A related to E?', 'Grandmother', 'Great-grandmother', 'Aunt', 'Mother', 'b', 'E is D''s mother and D is C''s father, so E is C''s grandmother -- making E A''s great-grandmother.', 'hard'),
  ('Sunil said, "Kavita''s mother is the only daughter of my mother." How is Sunil related to Kavita?', 'Father', 'Uncle', 'Brother', 'Grandfather', 'b', 'The only daughter of Sunil''s mother is Sunil''s sister, who is Kavita''s mother -- so Sunil is Kavita''s maternal uncle.', 'medium'),
  ('A is the son of B''s father''s only daughter. How is A related to B, if B is male?', 'Nephew', 'Son', 'Cousin', 'Brother', 'a', 'B''s father''s only daughter is B''s sister; her son A is therefore B''s nephew.', 'medium'),
  ('If X is the husband of Y, and Z is the mother of X, how is Y related to Z?', 'Daughter', 'Daughter-in-law', 'Sister', 'Niece', 'b', 'Y, married to Z''s son, is Z''s daughter-in-law.', 'easy'),
  ('A man introduces his wife''s brother''s only sister. Who is she to him?', 'Sister', 'Wife', 'Cousin', 'Sister-in-law', 'b', 'The wife''s brother''s only sister is the wife herself.', 'medium'),
  ('P is Q''s daughter. R is P''s mother. S is R''s father. How is Q related to S?', 'Son', 'Father-in-law', 'Brother', 'Uncle', 'b', 'R and Q are P''s parents (spouses), and S is R''s father, making S the father-in-law of Q.', 'hard'),
  ('Introducing a boy, a man said, "He is the son of my wife''s mother''s only son." How is the boy related to the man?', 'Son', 'Nephew', 'Brother', 'Cousin', 'b', 'The wife''s mother''s only son is the wife''s brother; his son is the man''s nephew by marriage.', 'hard'),
  ('A and B are siblings. C is A''s mother. D is C''s husband. How is D related to B?', 'Father', 'Uncle', 'Brother', 'Grandfather', 'a', 'C is the mother of both A and B, and D is C''s husband, making D B''s father.', 'easy'),
  ('Pointing to a girl, Rakesh (who has no brothers) said, "She is the daughter of my father''s only son." How is the girl related to Rakesh?', 'Sister', 'Daughter', 'Niece', 'Cousin', 'b', 'Since Rakesh has no brothers, his father''s only son is Rakesh himself, so the girl is his daughter.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'blood-relations';

-- ============================================================
-- Logical Reasoning > Coding-Decoding (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('If TIGER is coded as UJHFS (each letter shifted forward by 1), how is LION coded?', 'MJPO', 'MJPP', 'NJPO', 'MJQO', 'a', 'Each letter shifts forward by 1: L->M, I->J, O->P, N->O, giving MJPO.', 'medium'),
  ('In a certain code, HELLO is written as IFMMP (shift +1). How is WORLD coded?', 'XPSME', 'XPSMD', 'XPSNE', 'YPSME', 'a', 'Each letter shifts forward by 1: W->X, O->P, R->S, L->M, D->E, giving XPSME.', 'medium'),
  ('If INDIA is coded as JOEJB (shift +1), how is NEPAL coded?', 'OFQBM', 'OFQBN', 'OFPBM', 'OFQCM', 'a', 'Each letter shifts forward by 1: N->O, E->F, P->Q, A->B, L->M, giving OFQBM.', 'medium'),
  ('If CHAIR is coded as DIBJS (shift +1), how is TABLE coded?', 'UBCMG', 'UBCMF', 'VBCMF', 'UBDMF', 'b', 'Each letter shifts forward by 1: T->U, A->B, B->C, L->M, E->F, giving UBCMF.', 'medium'),
  ('If A=1, B=2, C=3, ..., Z=26, what is the code for the word "DOG"?', '4-15-7', '4-14-7', '4-15-8', '5-15-7', 'a', 'D=4, O=15, G=7, giving 4-15-7.', 'easy'),
  ('If FRIEND is coded as HTKGPF (each letter +2), how is CANDLE coded?', 'ECPFNG', 'ECPFNH', 'ECOFNG', 'EDPFNG', 'a', 'Each letter shifts forward by 2: C->E, A->C, N->P, D->F, L->N, E->G, giving ECPFNG.', 'medium'),
  ('If letters are coded by their reverse-alphabet counterpart (A=Z, B=Y, ...), how is "CAT" coded?', 'XZH', 'XZG', 'YZG', 'XYG', 'b', 'C<->X, A<->Z, T<->G, giving XZG.', 'hard'),
  ('If 1=A, 2=B, 3=C, and so on, what does "3-15-4-5" spell?', 'CODE', 'COVE', 'CORE', 'CODA', 'a', '3=C, 15=O, 4=D, 5=E, spelling CODE.', 'easy'),
  ('If PENCIL is coded as QFODJM (shift +1), how is ERASER coded?', 'FSBTFS', 'FSBTFT', 'FSBSFT', 'FSATFS', 'a', 'Each letter shifts forward by 1: E->F, R->S, A->B, S->T, E->F, R->S, giving FSBTFS.', 'medium'),
  ('If MANGO is coded as OCPIQ (each letter +2), how is APPLE coded?', 'CRRNH', 'CRRNG', 'CRSNG', 'CRRMG', 'b', 'Each letter shifts forward by 2: A->C, P->R, P->R, L->N, E->G, giving CRRNG.', 'medium'),
  ('If the code for BOOK is 2-15-15-11 (A=1...Z=26), what is the code for PEN?', '16-5-14', '15-5-14', '16-4-14', '16-5-13', 'a', 'P=16, E=5, N=14, giving 16-5-14.', 'easy'),
  ('If SUN is coded as TVO (shift +1), how is MOON coded?', 'NPPO', 'NPPN', 'MPPO', 'NPQO', 'a', 'Each letter shifts forward by 1: M->N, O->P, O->P, N->O, giving NPPO.', 'medium'),
  ('If RIVER is coded as TKXGT (each letter +2), how is OCEAN coded?', 'QEGCQ', 'QEGCP', 'QFGCP', 'QEHCP', 'b', 'Each letter shifts forward by 2: O->Q, C->E, E->G, A->C, N->P, giving QEGCP.', 'medium'),
  ('If GARDEN is coded as FZQCDM (each letter -1), how is FOREST coded?', 'ENQDRS', 'ENQDRT', 'EMQDRS', 'ENQERS', 'a', 'Each letter shifts back by 1: F->E, O->N, R->Q, E->D, S->R, T->S, giving ENQDRS.', 'medium'),
  ('If APPLE is coded as 1-16-16-12-5 (A=1...Z=26), how is MANGO coded?', '13-1-14-7-15', '13-1-14-7-14', '13-2-14-7-15', '13-1-13-7-15', 'a', 'M=13, A=1, N=14, G=7, O=15, giving 13-1-14-7-15.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'coding-decoding';
