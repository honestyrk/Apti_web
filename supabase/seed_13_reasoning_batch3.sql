-- seed_13_reasoning_batch3.sql
-- Continues the topic-expansion pass for Logical Reasoning. Tops up
-- Analogy and Classification (each originally seeded with 8 questions
-- in seed_02) with 17 more each to reach 25.
-- Additive only; safe to run once after seed_12_reasoning_batch2.sql.

-- ============================================================
-- Logical Reasoning > Analogy (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Key is to Lock as Password is to ____?', 'Computer', 'Security', 'Account', 'Login', 'c', 'A key opens a lock; a password grants access to an account.', 'medium'),
  ('Book is to Library as Painting is to ____?', 'Gallery', 'Wall', 'Frame', 'Artist', 'a', 'Books are housed in a library; paintings are housed in a gallery.', 'easy'),
  ('Chef is to Kitchen as Farmer is to ____?', 'Field', 'Crop', 'Barn', 'Farm', 'd', 'A chef works in a kitchen; a farmer works on a farm.', 'medium'),
  ('Wolf is to Pack as Fish is to ____?', 'Herd', 'School', 'Flock', 'Pod', 'b', 'A group of wolves is a pack; a group of fish is a school.', 'medium'),
  ('Sculptor is to Chisel as Painter is to ____?', 'Canvas', 'Palette', 'Brush', 'Easel', 'c', 'A sculptor works with a chisel; a painter works with a brush.', 'medium'),
  ('Novel is to Chapters as House is to ____?', 'Rooms', 'Walls', 'Roof', 'Doors', 'a', 'A novel is divided into chapters; a house is divided into rooms.', 'easy'),
  ('Caterpillar is to Butterfly as Tadpole is to ____?', 'Toad', 'Fish', 'Newt', 'Frog', 'd', 'A caterpillar matures into a butterfly; a tadpole matures into a frog.', 'medium'),
  ('Doctor is to Patient as Teacher is to ____?', 'School', 'Student', 'Book', 'Class', 'b', 'A doctor treats a patient; a teacher instructs a student.', 'easy'),
  ('Sun is to Solar System as Nucleus is to ____?', 'Electron', 'Molecule', 'Atom', 'Proton', 'c', 'The sun is the center of the solar system; the nucleus is the center of an atom.', 'medium'),
  ('Envelope is to Letter as Bottle is to ____?', 'Water', 'Cap', 'Glass', 'Cork', 'a', 'An envelope contains a letter; a bottle contains water.', 'easy'),
  ('Bee is to Honey as Cow is to ____?', 'Grass', 'Farm', 'Horn', 'Milk', 'd', 'A bee produces honey; a cow produces milk.', 'easy'),
  ('Warm is to Hot as Cool is to ____?', 'Ice', 'Cold', 'Freeze', 'Wet', 'b', 'Warm is a lesser degree of hot; cool is a lesser degree of cold.', 'easy'),
  ('Actor is to Stage as Athlete is to ____?', 'Ball', 'Team', 'Stadium', 'Coach', 'c', 'An actor performs on a stage; an athlete performs in a stadium.', 'medium'),
  ('Library is to Books as Zoo is to ____?', 'Animals', 'Cages', 'Visitors', 'Trees', 'a', 'A library houses books; a zoo houses animals.', 'easy'),
  ('Composer is to Symphony as Architect is to ____?', 'Blueprint', 'Bricks', 'City', 'Building', 'd', 'A composer creates a symphony; an architect creates a building.', 'medium'),
  ('Tailor is to Clothes as Carpenter is to ____?', 'Wood', 'Furniture', 'Nails', 'Tools', 'b', 'A tailor makes clothes; a carpenter makes furniture.', 'medium'),
  ('Petal is to Flower as Leaf is to ____?', 'Branch', 'Root', 'Tree', 'Stem', 'c', 'A petal is part of a flower; a leaf is part of a tree.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'analogy';

-- ============================================================
-- Logical Reasoning > Classification (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Which word does not belong with the others?', 'Sphere', 'Circle', 'Square', 'Rectangle', 'a', 'Circle, Square, and Rectangle are 2D shapes; Sphere is a 3D shape.', 'easy'),
  ('Which word does not belong with the others?', 'Violin', 'Trumpet', 'Guitar', 'Sitar', 'b', 'Violin, Guitar, and Sitar are string instruments; Trumpet is a wind instrument.', 'medium'),
  ('Which word does not belong with the others?', 'Whale', 'Dolphin', 'Shark', 'Porpoise', 'c', 'Whale, Dolphin, and Porpoise are mammals; Shark is a fish.', 'medium'),
  ('Which word does not belong with the others?', 'Copper', 'Bronze', 'Iron', 'Aluminium', 'b', 'Copper, Iron, and Aluminium are pure metals; Bronze is an alloy.', 'medium'),
  ('Which word does not belong with the others?', 'Cactus', 'Rose', 'Tulip', 'Sunflower', 'a', 'Rose, Tulip, and Sunflower are flowers; Cactus is not primarily classified as one.', 'medium'),
  ('Which word does not belong with the others?', 'Novel', 'Poem', 'Newspaper', 'Essay', 'c', 'Novel, Poem, and Essay are literary forms; Newspaper is a periodical publication.', 'medium'),
  ('Which word does not belong with the others?', 'Square', 'Cube', 'Rhombus', 'Trapezium', 'b', 'Square, Rhombus, and Trapezium are 2D quadrilaterals; Cube is a 3D shape.', 'medium'),
  ('Which word does not belong with the others?', 'School', 'Teacher', 'Doctor', 'Engineer', 'a', 'Teacher, Doctor, and Engineer are professions; School is a place.', 'easy'),
  ('Which word does not belong with the others?', 'Mumbai', 'Chennai', 'Maharashtra', 'Bangalore', 'c', 'Mumbai, Chennai, and Bangalore are cities; Maharashtra is a state.', 'easy'),
  ('Which word does not belong with the others?', 'Hockey', 'Referee', 'Basketball', 'Badminton', 'b', 'Hockey, Basketball, and Badminton are sports; Referee is a person.', 'easy'),
  ('Which word does not belong with the others?', 'Water', 'Oxygen', 'Hydrogen', 'Nitrogen', 'a', 'Oxygen, Hydrogen, and Nitrogen are elements; Water is a compound.', 'medium'),
  ('Which word does not belong with the others?', 'Cow', 'Goat', 'Lion', 'Sheep', 'c', 'Cow, Goat, and Sheep are domestic herbivores; Lion is a wild carnivore.', 'easy'),
  ('Which word does not belong with the others?', 'January', 'March', 'Monday', 'July', 'c', 'January, March, and July are months; Monday is a day of the week.', 'easy'),
  ('Which word does not belong with the others?', 'Kilogram', 'Inch', 'Foot', 'Yard', 'a', 'Inch, Foot, and Yard are units of length; Kilogram is a unit of mass.', 'medium'),
  ('Which word does not belong with the others?', 'Rectangle', 'Sphere', 'Triangle', 'Pentagon', 'b', 'Rectangle, Triangle, and Pentagon are 2D shapes; Sphere is a 3D shape.', 'medium'),
  ('Which word does not belong with the others?', 'Saturn', 'Jupiter', 'Sun', 'Mars', 'c', 'Saturn, Jupiter, and Mars are planets; the Sun is a star.', 'medium'),
  ('Which word does not belong with the others?', 'Bank', 'Rupee', 'Dollar', 'Euro', 'a', 'Rupee, Dollar, and Euro are currencies; Bank is an institution.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'classification';
