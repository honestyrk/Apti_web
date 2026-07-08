-- seed_20_cs_batch1.sql
-- Completes the "every topic gets at least 25 questions" expansion.
-- This is the final batch: tops up OOP Concepts and DBMS (originally 10
-- questions each in seed.sql) with 15 more each, and adds 25 questions
-- each for Operating Systems, Computer Networks, and Data Structures
-- (previously empty). This completes ALL topics across the entire
-- platform at 25+ questions. Additive only; safe to run once after
-- seed_19_di_batch1.sql.

-- ============================================================
-- Technical > CS/IT > OOP Concepts (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Which OOP feature allows a subclass to provide a specific implementation of a method already defined in its superclass?', 'Overloading', 'Overriding', 'Encapsulation', 'Abstraction', 'b', 'This describes method overriding.', 'medium'),
  ('What is commonly used to achieve multiple inheritance in languages like Java that don''t allow multiple class inheritance?', 'Classes', 'Interfaces', 'Objects', 'Packages', 'b', 'Interfaces let a class implement multiple contracts, approximating multiple inheritance.', 'medium'),
  ('What is encapsulation primarily used for?', 'To increase code size', 'To hide internal implementation details and protect data', 'To slow down execution', 'To duplicate code', 'b', 'Encapsulation bundles data and restricts direct access to protect internal state.', 'easy'),
  ('Which access modifier restricts access to only within the same class?', 'Public', 'Protected', 'Private', 'Default', 'c', '"Private" members are accessible only within their own class.', 'easy'),
  ('What is a virtual function used for in C++?', 'To enable runtime polymorphism', 'To declare a constant', 'To create a static variable', 'To import a library', 'a', 'Virtual functions allow a call to be resolved at runtime based on the object''s actual type.', 'medium'),
  ('Which OOP concept is violated if a class exposes all its member variables as public?', 'Inheritance', 'Encapsulation', 'Polymorphism', 'Abstraction', 'b', 'Exposing all fields as public breaks the data-hiding principle of encapsulation.', 'medium'),
  ('What is method overloading primarily based on?', 'Different return types only', 'Different parameter lists', 'Different access modifiers', 'Different class names', 'b', 'Overloaded methods share a name but differ in their parameter lists.', 'medium'),
  ('In OOP, what is a "has-a" relationship also known as?', 'Inheritance', 'Composition', 'Polymorphism', 'Abstraction', 'b', 'A "has-a" relationship between objects is called composition.', 'medium'),
  ('What is the purpose of a destructor in a class?', 'To create an object', 'To release resources when an object is destroyed', 'To copy an object', 'To compare two objects', 'b', 'A destructor performs cleanup when an object goes out of scope or is deleted.', 'medium'),
  ('Which of the following best defines an interface in OOP?', 'A class with data members only', 'A contract defining methods a class must implement, without providing implementation', 'A type of loop', 'A variable declaration', 'b', 'An interface specifies a contract of methods without implementing them.', 'medium'),
  ('What is the term for creating multiple objects from a single class?', 'Inheritance', 'Instantiation', 'Abstraction', 'Overriding', 'b', 'Creating an object from a class is called instantiation.', 'easy'),
  ('Which OOP principle allows objects of different classes to be treated as objects of a common superclass?', 'Encapsulation', 'Inheritance', 'Polymorphism', 'Abstraction', 'c', 'This is the definition of polymorphism.', 'medium'),
  ('What is a static method in a class?', 'A method that belongs to the class rather than any instance', 'A method that can only be called once', 'A method with no return type', 'A method that overrides another method', 'a', 'Static methods belong to the class itself, not to any particular instance.', 'medium'),
  ('In OOP, what does "abstraction" primarily achieve?', 'Hiding complex implementation and showing only essential features', 'Combining data and methods', 'Creating multiple objects', 'Reusing code from a parent class', 'a', 'Abstraction focuses on exposing only relevant details while hiding complexity.', 'medium'),
  ('Which of the following is an example of runtime polymorphism?', 'Method overloading', 'Method overriding', 'Static binding', 'Variable declaration', 'b', 'Method overriding is resolved at runtime, making it runtime (dynamic) polymorphism.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'oop-concepts';

-- ============================================================
-- Technical > CS/IT > DBMS (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('What does SQL stand for?', 'Structured Query Language', 'Simple Query Language', 'Sequential Query Language', 'Standard Query Language', 'a', 'SQL stands for Structured Query Language.', 'easy'),
  ('Which SQL clause is used to filter groups after aggregation?', 'WHERE', 'HAVING', 'GROUP BY', 'ORDER BY', 'b', 'HAVING filters grouped results, unlike WHERE which filters rows before grouping.', 'medium'),
  ('What is a view in SQL?', 'A physical table', 'A virtual table based on the result of a query', 'An index', 'A stored procedure', 'b', 'A view is a virtual table defined by a stored query.', 'medium'),
  ('Which normal form deals with removing multi-valued dependencies?', '1NF', '2NF', '3NF', '4NF', 'd', 'Fourth Normal Form (4NF) addresses multi-valued dependencies.', 'hard'),
  ('What is the purpose of an index in a database?', 'To speed up data retrieval', 'To store backup data', 'To encrypt data', 'To delete records', 'a', 'Indexes speed up lookups at the cost of extra storage and write overhead.', 'easy'),
  ('What is a primary key?', 'A column that can have duplicate values', 'A column (or set of columns) that uniquely identifies each row', 'A column that stores foreign data', 'A column with no constraints', 'b', 'A primary key uniquely identifies each row and cannot contain duplicates or NULLs.', 'easy'),
  ('Which SQL command is used to modify existing data in a table?', 'SELECT', 'UPDATE', 'INSERT', 'DELETE', 'b', 'UPDATE modifies existing rows in a table.', 'easy'),
  ('What is a foreign key constraint used for?', 'To maintain referential integrity between two tables', 'To speed up queries', 'To encrypt sensitive data', 'To create indexes automatically', 'a', 'A foreign key enforces a valid reference to a row in another table.', 'medium'),
  ('What is normalization in DBMS?', 'The process of organizing data to reduce redundancy', 'The process of encrypting data', 'The process of backing up data', 'The process of deleting old data', 'a', 'Normalization structures data to minimize redundancy and dependency issues.', 'medium'),
  ('Which of the following is NOT a standard type of SQL JOIN?', 'INNER JOIN', 'LEFT JOIN', 'MIDDLE JOIN', 'RIGHT JOIN', 'c', '"MIDDLE JOIN" is not a real SQL join type.', 'easy'),
  ('What does the acronym CRUD stand for in database operations?', 'Create, Read, Update, Delete', 'Copy, Read, Undo, Delete', 'Create, Retrieve, Update, Drop', 'Combine, Read, Update, Delete', 'a', 'CRUD refers to the four basic operations: Create, Read, Update, Delete.', 'easy'),
  ('What is a transaction in DBMS?', 'A sequence of operations performed as a single logical unit of work', 'A single SQL query', 'A type of index', 'A backup process', 'a', 'A transaction groups operations so they succeed or fail together as one unit.', 'medium'),
  ('Which property of a transaction ensures that partial transactions are not allowed?', 'Atomicity', 'Consistency', 'Isolation', 'Durability', 'a', 'Atomicity guarantees a transaction is all-or-nothing.', 'medium'),
  ('What is a stored procedure?', 'A precompiled collection of SQL statements stored in the database', 'A type of table', 'A backup file', 'A network protocol', 'a', 'A stored procedure is a saved, reusable block of SQL logic.', 'medium'),
  ('What is the purpose of the SQL COMMIT command?', 'To permanently save changes made during a transaction', 'To undo changes', 'To delete a table', 'To create a new database', 'a', 'COMMIT finalizes and saves all changes made in the current transaction.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'dbms';

-- ============================================================
-- Technical > CS/IT > Operating Systems
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('What is the primary function of an operating system?', 'To manage hardware and software resources', 'To write application code', 'To design websites', 'To manufacture hardware', 'a', 'An OS manages a computer''s hardware and software resources.', 'easy'),
  ('What is a process in an operating system?', 'A file stored on disk', 'A network connection', 'A program in execution', 'A hardware device', 'c', 'A process is an instance of a program that is currently running.', 'easy'),
  ('What is the purpose of a scheduler in an OS?', 'To decide which process runs next on the CPU', 'To store files', 'To manage printers', 'To connect to the internet', 'a', 'The scheduler determines the order in which processes get CPU time.', 'medium'),
  ('What is a deadlock in an operating system?', 'A process that runs very fast', 'A situation where two or more processes are unable to proceed because each is waiting for the other', 'A type of memory leak', 'A file corruption issue', 'b', 'A deadlock occurs when processes are stuck waiting on each other indefinitely.', 'medium'),
  ('What is virtual memory?', 'A memory management technique that uses disk space to extend RAM', 'A type of cache memory', 'A backup memory device', 'A type of read-only memory', 'a', 'Virtual memory lets the OS use disk space to simulate additional RAM.', 'medium'),
  ('Which scheduling algorithm gives priority to the process with the shortest execution time?', 'First Come First Served', 'Shortest Job First', 'Round Robin', 'Priority Scheduling', 'b', 'Shortest Job First (SJF) selects the process with the smallest execution time next.', 'medium'),
  ('What is thrashing in an operating system?', 'A condition where the system spends more time swapping pages than executing processes', 'A type of virus', 'A network failure', 'A CPU overheating issue', 'a', 'Thrashing occurs when excessive paging severely degrades system performance.', 'hard'),
  ('A process is smaller than a thread.', 'A process is smaller than a thread', 'A thread is a lightweight unit of execution within a process', 'They are identical', 'A thread cannot share memory with other threads in the same process', 'b', 'A thread is a lightweight execution unit that exists within a process.', 'medium'),
  ('What is paging in memory management?', 'Dividing memory into fixed-size blocks to avoid fragmentation', 'Encrypting memory data', 'Deleting unused files', 'Compressing disk space', 'a', 'Paging divides memory into fixed-size pages to manage allocation efficiently.', 'medium'),
  ('What does the term "context switching" refer to?', 'Switching between two monitors', 'Saving the state of a process and loading the state of another', 'Changing the operating system', 'Restarting the computer', 'b', 'Context switching is the OS saving one process''s state and restoring another''s.', 'medium'),
  ('What is a semaphore used for in operating systems?', 'To control access to shared resources by multiple processes', 'To display graphics', 'To manage network traffic', 'To compile code', 'a', 'A semaphore is a synchronization tool that controls access to shared resources.', 'medium'),
  ('Which of the following is an example of a multi-user operating system?', 'MS-DOS', 'UNIX', 'Early single-PC versions of Windows', 'None of the above', 'b', 'UNIX was designed from the ground up to support multiple simultaneous users.', 'medium'),
  ('What is the purpose of a file system in an OS?', 'To organize and manage data storage on disk', 'To manage CPU scheduling', 'To manage network connections', 'To manage user interfaces only', 'a', 'A file system organizes how data is stored and retrieved on storage devices.', 'easy'),
  ('What is a kernel?', 'A type of application software', 'The core part of an operating system that manages system resources', 'A hardware component', 'A programming language', 'b', 'The kernel is the OS''s core, managing resources like CPU, memory, and devices.', 'easy'),
  ('The round robin scheduling algorithm is based on what?', 'Time slices allocated to each process in turn', 'Priority levels only', 'Process size', 'Memory usage', 'a', 'Round robin gives each process a fixed time slice (quantum) in rotation.', 'medium'),
  ('What is a race condition?', 'A fast processing technique', 'A situation where the outcome depends on the timing of uncontrollable events', 'A type of scheduling algorithm', 'A memory allocation method', 'b', 'A race condition occurs when the result depends on unpredictable timing of concurrent operations.', 'hard'),
  ('What is the purpose of an interrupt in an OS?', 'To signal the CPU to pause its current task and handle an event', 'To shut down the system', 'To increase CPU speed', 'To delete a process', 'a', 'An interrupt signals the CPU to handle a higher-priority event immediately.', 'medium'),
  ('What is fragmentation in memory management?', 'A type of virus', 'The inefficient use of memory due to scattered free space', 'A CPU scheduling method', 'A file compression technique', 'b', 'Fragmentation refers to memory being split into small, unusable free blocks.', 'medium'),
  ('What is the main advantage of multithreading?', 'It allows concurrent execution of multiple parts of a program, improving performance', 'It reduces the need for memory', 'It eliminates the need for an OS', 'It increases file size', 'a', 'Multithreading enables parallel execution within a single process, improving responsiveness and throughput.', 'medium'),
  ('What does "swapping" refer to in an operating system?', 'Exchanging data between two files', 'Moving processes between main memory and disk to free up RAM', 'Switching between two operating systems', 'Replacing a hardware component', 'b', 'Swapping moves entire processes between RAM and disk to manage memory.', 'medium'),
  ('What is a zombie process?', 'A process that has completed execution but still has an entry in the process table', 'A process that never starts', 'A process with a virus', 'A high-priority process', 'a', 'A zombie process has finished but its exit status hasn''t yet been read by its parent.', 'hard'),
  ('First Come First Served, Least Recently Used, Round Robin, and Shortest Job First -- which of these is a page replacement algorithm?', 'First Come First Served', 'Least Recently Used', 'Round Robin', 'Shortest Job First', 'b', 'Least Recently Used (LRU) is a classic page replacement algorithm.', 'medium'),
  ('What is the purpose of the "fork" system call in UNIX-like operating systems?', 'To create a new child process', 'To terminate a process', 'To allocate memory', 'To open a file', 'a', '"fork" creates a new process by duplicating the calling process.', 'medium'),
  ('What is a critical section in concurrent programming?', 'The main function of a program', 'A part of the program where shared resources are accessed and must not be executed by more than one process at a time', 'A section of code that always crashes', 'A type of loop', 'b', 'A critical section accesses shared resources and requires mutual exclusion.', 'medium'),
  ('What is the purpose of the "banker''s algorithm"?', 'To avoid deadlock by carefully allocating resources', 'To manage banking software', 'To speed up file access', 'To compress data', 'a', 'The banker''s algorithm is a deadlock-avoidance strategy for resource allocation.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'operating-systems';

-- ============================================================
-- Technical > CS/IT > Computer Networks
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('What does IP stand for in networking?', 'Internet Protocol', 'Internal Program', 'Interconnected Path', 'Internet Package', 'a', 'IP stands for Internet Protocol.', 'easy'),
  ('What is the purpose of a router?', 'To store files', 'To forward data packets between different networks', 'To display web pages', 'To compile programs', 'b', 'A router forwards packets between different networks.', 'easy'),
  ('What does DNS stand for?', 'Domain Name System', 'Data Network Service', 'Digital Naming Standard', 'Domain Network Server', 'a', 'DNS stands for Domain Name System, which resolves domain names to IP addresses.', 'easy'),
  ('Which layer of the OSI model is responsible for routing?', 'Physical layer', 'Data link layer', 'Network layer', 'Transport layer', 'c', 'The network layer handles routing of packets across networks.', 'medium'),
  ('What is the function of a firewall?', 'To monitor and control incoming and outgoing network traffic based on security rules', 'To speed up internet connection', 'To store website data', 'To compile code', 'a', 'A firewall filters traffic based on defined security rules.', 'easy'),
  ('What does TCP stand for?', 'Total Control Package', 'Transmission Control Protocol', 'Transfer Control Process', 'Transmission Connect Protocol', 'b', 'TCP stands for Transmission Control Protocol.', 'easy'),
  ('What is the default port number for HTTP?', '21', '25', '80', '443', 'c', 'HTTP uses port 80 by default.', 'medium'),
  ('What is the default port number for HTTPS?', '80', '443', '21', '25', 'b', 'HTTPS uses port 443 by default.', 'medium'),
  ('What is a MAC address?', 'A type of software license', 'A unique hardware identifier assigned to a network interface', 'An email address format', 'A type of IP address', 'b', 'A MAC address is a unique identifier burned into a network interface card.', 'medium'),
  ('What is the purpose of DHCP?', 'To automatically assign IP addresses to devices on a network', 'To encrypt network traffic', 'To block malicious websites', 'To compress network data', 'a', 'DHCP automatically assigns IP addresses and other network settings to devices.', 'medium'),
  ('What is the key difference between a hub and a switch?', 'A hub is faster than a switch', 'A switch sends data only to the intended recipient, while a hub broadcasts to all devices', 'They are identical devices', 'A switch cannot connect multiple devices', 'b', 'Switches use MAC addresses to send data only to the intended port, unlike hubs.', 'medium'),
  ('What does LAN stand for?', 'Local Area Network', 'Large Area Network', 'Linked Area Network', 'Long Access Network', 'a', 'LAN stands for Local Area Network.', 'easy'),
  ('What does WAN stand for?', 'Wireless Access Network', 'Wide Area Network', 'Web Area Network', 'Wide Access Node', 'b', 'WAN stands for Wide Area Network.', 'easy'),
  ('What is the purpose of a subnet mask?', 'To divide an IP network into smaller sub-networks', 'To encrypt data packets', 'To assign domain names', 'To block viruses', 'a', 'A subnet mask divides an IP address into network and host portions.', 'medium'),
  ('Which protocol is used to send emails?', 'FTP', 'SMTP', 'HTTP', 'DNS', 'b', 'SMTP (Simple Mail Transfer Protocol) is used for sending email.', 'medium'),
  ('What is bandwidth in networking?', 'The physical length of a cable', 'The maximum rate of data transfer across a network connection', 'The number of connected devices', 'The color of network cables', 'b', 'Bandwidth measures the maximum data transfer rate of a connection.', 'easy'),
  ('What is the purpose of an IP address?', 'To uniquely identify a device on a network', 'To store passwords', 'To display graphics', 'To manage file permissions', 'a', 'An IP address uniquely identifies a device on a network.', 'easy'),
  ('What does the term "latency" refer to in networking?', 'The total data transferred', 'The delay before data transfer begins following an instruction', 'The number of devices on a network', 'The speed of a CPU', 'b', 'Latency is the delay between a request and the start of a response.', 'medium'),
  ('Which network topology connects all devices to a single central hub?', 'Bus topology', 'Ring topology', 'Star topology', 'Mesh topology', 'c', 'In a star topology, all devices connect to a central hub or switch.', 'medium'),
  ('What is the purpose of a proxy server?', 'To act as an intermediary between a client and the internet', 'To store backup files', 'To manage printers', 'To compile software', 'a', 'A proxy server relays requests between clients and other servers.', 'medium'),
  ('What does VPN stand for?', 'Very Personal Network', 'Virtual Private Network', 'Virtual Public Node', 'Verified Private Node', 'b', 'VPN stands for Virtual Private Network.', 'easy'),
  ('What is packet switching?', 'A method of connecting two computers directly', 'A method of transmitting data by breaking it into smaller packets sent independently', 'A type of encryption', 'A type of firewall', 'b', 'Packet switching breaks data into packets transmitted independently across the network.', 'medium'),
  ('What is the function of the transport layer in the OSI model?', 'To manage physical cabling', 'To ensure reliable data transfer between end systems', 'To assign IP addresses', 'To render web pages', 'b', 'The transport layer (e.g., TCP) ensures reliable end-to-end data delivery.', 'medium'),
  ('What is a protocol in networking?', 'A set of rules governing data communication between devices', 'A type of hardware', 'A programming language', 'A type of virus', 'a', 'A protocol defines the rules for how data is communicated between devices.', 'easy'),
  ('Which protocol is used to transfer files between computers over a network?', 'SMTP', 'FTP', 'DNS', 'ARP', 'b', 'FTP (File Transfer Protocol) is used for transferring files over a network.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'computer-networks';

-- ============================================================
-- Technical > CS/IT > Data Structures
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('What is a stack?', 'A linear data structure that follows FIFO order', 'A linear data structure that follows LIFO (Last In First Out) order', 'A tree-based structure', 'A graph-based structure', 'b', 'A stack follows Last In First Out (LIFO) order.', 'easy'),
  ('What is a queue?', 'A linear data structure that follows LIFO order', 'A linear data structure that follows FIFO (First In First Out) order', 'A tree-based structure', 'A hash-based structure', 'b', 'A queue follows First In First Out (FIFO) order.', 'easy'),
  ('What is the time complexity of searching an element in a balanced binary search tree?', 'O(1)', 'O(n)', 'O(log n)', 'O(n^2)', 'c', 'A balanced BST allows search in O(log n) time.', 'medium'),
  ('Which data structure is used to implement recursion?', 'Queue', 'Stack', 'Array', 'Linked List', 'b', 'Function calls in recursion are managed using a call stack.', 'medium'),
  ('What is a linked list?', 'A collection of key-value pairs', 'A linear collection of nodes where each node points to the next', 'A tree with two children per node', 'A fixed-size array', 'b', 'A linked list is a sequence of nodes, each pointing to the next.', 'easy'),
  ('What is the time complexity of accessing an element in an array by index?', 'O(1)', 'O(n)', 'O(log n)', 'O(n^2)', 'a', 'Array indexing provides constant-time O(1) access.', 'easy'),
  ('What is a binary tree?', 'A tree with unlimited children', 'A tree data structure where each node has at most two children', 'A linear data structure', 'A hash table', 'b', 'A binary tree limits each node to at most two children.', 'easy'),
  ('What is the purpose of a hash table?', 'To store key-value pairs for fast lookup', 'To sort data', 'To traverse a tree', 'To reverse a list', 'a', 'Hash tables provide fast average-case lookup using key-value pairs.', 'medium'),
  ('What is the worst-case time complexity of bubble sort?', 'O(n)', 'O(n log n)', 'O(n^2)', 'O(log n)', 'c', 'Bubble sort has a worst-case time complexity of O(n^2).', 'medium'),
  ('What is a graph in data structures?', 'A linear sequence of elements', 'A collection of nodes (vertices) connected by edges', 'A type of sorting algorithm', 'A fixed-size table', 'b', 'A graph consists of vertices connected by edges.', 'easy'),
  ('What operation does "push" perform on a stack?', 'Adds an element to the top', 'Removes an element from the top', 'Removes an element from the bottom', 'Adds an element to the bottom', 'a', '"Push" adds a new element to the top of the stack.', 'easy'),
  ('What operation does "pop" perform on a stack?', 'Adds an element to the top', 'Removes an element from the top', 'Removes an element from the bottom', 'Adds an element to the bottom', 'b', '"Pop" removes the element at the top of the stack.', 'easy'),
  ('What is the time complexity of inserting an element at the beginning of an array of size n?', 'O(1)', 'O(n)', 'O(log n)', 'O(n^2)', 'b', 'Inserting at the start requires shifting all existing elements: O(n).', 'medium'),
  ('What is a doubly linked list?', 'A linked list with only forward pointers', 'A linked list where each node has pointers to both the next and previous nodes', 'A list with two heads', 'A circular list', 'b', 'A doubly linked list allows traversal in both directions via next and previous pointers.', 'medium'),
  ('Among common comparison sorts, which has the best average-case time complexity?', 'Bubble sort', 'Merge sort', 'Selection sort', 'Insertion sort', 'b', 'Merge sort has an average and worst-case time complexity of O(n log n).', 'medium'),
  ('What is a binary search tree (BST)?', 'A tree with only left children', 'A binary tree where the left subtree contains smaller values and the right subtree contains larger values', 'A tree with random ordering', 'A tree used only for sorting arrays', 'b', 'A BST maintains an ordering property between left and right subtrees.', 'medium'),
  ('What is the space complexity typically associated with an adjacency matrix representation of a graph with n vertices?', 'O(n)', 'O(n log n)', 'O(n^2)', 'O(1)', 'c', 'An adjacency matrix requires O(n^2) space for n vertices.', 'hard'),
  ('What is a circular queue?', 'A queue with no fixed size', 'A queue where the last position is connected back to the first, forming a circle', 'A queue that only stores circles', 'A stack variant', 'b', 'A circular queue wraps around, connecting the last position back to the first.', 'medium'),
  ('What does LIFO stand for?', 'Last In First Out', 'Last In Final Out', 'Linear In First Out', 'Last Index First Out', 'a', 'LIFO stands for Last In First Out.', 'easy'),
  ('What does FIFO stand for?', 'First In Final Out', 'First In First Out', 'Fixed In First Out', 'First Index First Out', 'b', 'FIFO stands for First In First Out.', 'easy'),
  ('What is the primary advantage of a linked list over an array?', 'Faster random access', 'Dynamic size and efficient insertion/deletion', 'Less memory usage always', 'Simpler syntax', 'b', 'Linked lists grow/shrink dynamically and allow efficient insertion and deletion.', 'medium'),
  ('What is a priority queue?', 'A queue that only stores integers', 'A queue where elements are dequeued based on priority rather than order of insertion', 'A stack with priorities', 'A queue with fixed size only', 'b', 'A priority queue serves elements based on priority, not insertion order.', 'medium'),
  ('What is the time complexity of binary search on a sorted array of n elements?', 'O(1)', 'O(n)', 'O(log n)', 'O(n^2)', 'c', 'Binary search halves the search space each step, giving O(log n).', 'medium'),
  ('What is a self-balancing binary search tree used for?', 'To increase memory usage', 'To maintain O(log n) height for efficient operations', 'To slow down insertions', 'To store only sorted arrays', 'b', 'Self-balancing BSTs keep height logarithmic, ensuring efficient operations.', 'hard'),
  ('What is an array?', 'A collection of unordered key-value pairs', 'A collection of elements stored in contiguous memory, identified by index', 'A tree-based structure', 'A type of linked list', 'b', 'An array stores elements in contiguous memory, accessible by index.', 'easy')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'data-structures';
