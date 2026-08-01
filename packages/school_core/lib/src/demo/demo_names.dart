/// Names for the demo data set.
///
/// Real Pakistani names, not `Student 1`..`Student 50`. The video is going to
/// a school in Pakistan, and a register full of placeholder names reads as a
/// toy — the principal is looking for something that could plausibly hold
/// their actual students tomorrow.
library;

const List<String> demoBoyNames = [
  'Ahmed Raza',
  'Muhammad Hasnain',
  'Bilal Ahmed',
  'Usman Ghani',
  'Hamza Tariq',
  'Abdullah Khan',
  'Talha Mehmood',
  'Zain Ul Abideen',
  'Saad Bin Aslam',
  'Danish Iqbal',
  'Faizan Ali',
  'Umair Sheikh',
  'Ibrahim Yousaf',
  'Arsalan Haider',
  'Shahzaib Malik',
  'Hassan Javed',
  'Owais Anwar',
  'Rehan Siddiqui',
  'Junaid Akram',
  'Waleed Nasir',
  'Ayan Rashid',
  'Musa Kamal',
  'Areeb Farooq',
  'Sufyan Qureshi',
  'Anas Bashir',
];

const List<String> demoGirlNames = [
  'Ayesha Siddiqa',
  'Fatima Noor',
  'Zainab Riaz',
  'Maryam Khalid',
  'Hafsa Naveed',
  'Iqra Shahid',
  'Amna Sattar',
  'Sana Pervaiz',
  'Rabia Aslam',
  'Noor Fatima',
  'Laiba Ahmed',
  'Eman Zahra',
  'Hira Mansoor',
  'Anum Waheed',
  'Areeba Saleem',
  'Mahnoor Abbas',
  'Kinza Yasmin',
  'Sidra Munir',
  'Alishba Rauf',
  'Warda Naeem',
  'Zoya Hameed',
  'Tooba Arshad',
  'Nimra Baig',
  'Saba Younas',
  'Bisma Iftikhar',
];

/// Fathers' names, cycled independently so siblings do not accidentally appear.
const List<String> demoFatherNames = [
  'Muhammad Aslam',
  'Raza Hussain',
  'Khalid Mehmood',
  'Abdul Rehman',
  'Tariq Javed',
  'Nasir Ali',
  'Iftikhar Ahmed',
  'Shahid Bashir',
  'Pervaiz Akhtar',
  'Munir Hussain',
  'Zafar Iqbal',
  'Saleem Akhtar',
  'Rashid Minhas',
  'Anwar Baig',
  'Yousaf Kamal',
  'Riaz Ahmed',
  'Sattar Khan',
  'Naveed Anjum',
  'Waheed Murad',
  'Arshad Mahmood',
];

/// The subjects every class takes. Same for all sections — that is the school
/// model, versus the university one where each student picked their own
/// courses (CLAUDE.md §11).
const List<({String name, String code, String icon})> demoSubjects = [
  (name: 'Mathematics', code: 'MATH', icon: 'calculate'),
  (name: 'English', code: 'ENG', icon: 'menu_book'),
  (name: 'Urdu', code: 'URD', icon: 'translate'),
  (name: 'Islamiat', code: 'ISL', icon: 'mosque'),
  (name: 'Pakistan Studies', code: 'PKST', icon: 'public'),
  (name: 'Physics', code: 'PHY', icon: 'science'),
  (name: 'Chemistry', code: 'CHEM', icon: 'biotech'),
  (name: 'Computer Science', code: 'CS', icon: 'computer'),
];
