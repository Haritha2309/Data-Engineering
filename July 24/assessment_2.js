use lib_management

db.books.insertMany([
{ book_id: 201, title: "The Alchemist", author: "Paulo Coelho", genre: "Fiction",
copies: 10 },
{ book_id: 202, title: "Atomic Habits", author: "James Clear", genre: "Self-Help",
copies: 5 },
{ book_id: 203, title: "Sapiens", author: "Yuval Noah Harari", genre: "History",
copies: 7 },
{ book_id: 204, title: "The Lean Startup", author: "Eric Ries", genre: "Business",
copies: 3 },
{ book_id: 205, title: "Deep Work", author: "Cal Newport", genre: "Productivity",
copies: 4 }
])

db.members.insertMany([
{ member_id: 101, name: "Ayesha Khan", joined_on: new Date("2024-01-15") },
{ member_id: 102, name: "Rahul Verma", joined_on: new Date("2024-03-12") },
{ member_id: 103, name: "Nikita Rao", joined_on: new Date("2024-04-10") }
])

db.borrowed.insertMany([
{ borrow_id: 1, member_id: 101, book_id: 201, date: new Date("2024-06-01"),
returned: true },
{ borrow_id: 2, member_id: 101, book_id: 203, date: new Date("2024-06-15"),
returned: false },
{ borrow_id: 3, member_id: 102, book_id: 202, date: new Date("2024-06-20"),
returned: false },
{ borrow_id: 4, member_id: 103, book_id: 204, date: new Date("2024-06-22"),
returned: true }
])

// 1.
db.books.find({genre:"Self-Help"})

// 2.
db.members.find({ joined_on: { $gt: new Date("2024-03-31") } })

// 3.
db.borrowed.find({ returned: false })

// 4.
db.books.find({ copies: { $lt: 5 } })

// 5.
db.books.find({ author: "Cal Newport" })

// 6.
db.borrowed.aggregate([
  {$lookup: {from: "books",localField: "book_id",foreignField: "book_id",as: "book"}},
  { $unwind: "$book" },
  {$lookup: {from: "members", localField: "member_id", foreignField: "member_id", as: "member" }},
  { $unwind: "$member" },
  {$project: {  _id: 0,  borrow_id: 1,  date: 1,  returned: 1,  book_title: "$book.title",  member_name: "$member.name" }}
])

// 7. 
db.borrowed.aggregate([
  {$lookup: {  from: "books",  localField: "book_id",  foreignField: "book_id",  as: "book"}},
  { $unwind: "$book" },
  { $match: { "book.title": "Sapiens" } },
  {$lookup: {from: "members",localField: "member_id",foreignField: "member_id",as: "member"}},
  { $unwind: "$member" },
  {$project: {_id: 0,member_name: "$member.name",book_title: "$book.title",date: 1,returned: 1}}
])

// 8.
db.members.aggregate([
  {$lookup: {  from: "borrowed",  localField: "member_id",  foreignField: "member_id",  as: "borrows"}},
  {$lookup: {  from: "books",  localField: "borrows.book_id",  foreignField: "book_id",  as: "borrowed_books"}},
  { $project: {_id: 0, member_name: "$name", borrowed_books: "$borrowed_books.title"}}
])

// 9.
db.borrowed.aggregate([
  { $match: { returned: false } },
  {$lookup: {from: "members",localField: "member_id",foreignField: "member_id",as: "member"}},
  { $unwind: "$member" },
  {$group: {_id: "$member.member_id",name: { $first: "$member.name" }}}
])

// 10.
db.borrowed.aggregate([
  { $group: {_id: "$book_id",borrow_count: { $sum: 1 } }},
  {$lookup: {from: "books",localField: "_id",foreignField: "book_id",as: "book"} },
  { $unwind: "$book" },
  {$project: {  _id: 0,  book_title: "$book.title", borrow_count: 1  } }
])

// 11.
db.borrowed.aggregate([
  {$group: {_id: "$member_id",total_borrowed: { $sum: 1 }}},
  { $lookup: {from: "members", localField: "_id", foreignField: "member_id", as: "member"}},
  { $unwind: "$member" },
  {$project: { _id: 0, member_name: "$member.name", total_borrowed: 1 }}
])

// 12.
db.books.aggregate([
  {$group: {_id: "$genre",total_copies: { $sum: "$copies" }} },
  { $sort: { total_copies: -1 } },
  { $limit: 1 }
])


// 13.
db.borrowed.aggregate([
  {$group: {_id: "$book_id",borrow_count: { $sum: 1 } } },
  { $lookup: { from: "books", localField: "_id", foreignField: "book_id", as: "book"}},
  { $unwind: "$book" },
  {$project: { _id: 0, book_title: "$book.title", borrow_count: 1 } },
  { $sort: { borrow_count: -1 } },
  { $limit: 2 }
])

// 14.
db.books.aggregate([
  { $group: { _id: "$genre", avg_copies: { $avg: "$copies" } }},
  {$project: { _id: 0,  genre: "$_id",  avg_copies: { $round: ["$avg_copies", 2] } }}
])

// 15.
db.borrowed.aggregate([
  { $match: { returned: false } },
  {$group: {_id: null,total_borrowed: { $sum: 1 } }},
  {$project: { _id: 0, total_borrowed: 1 }}
])

// 16.
db.members.insertOne({
  member_id: 104,
  name: "Ishaan Mehta",
  joined_on: new Date("2024-07-01")
})
db.members.aggregate([
  {$lookup: {from: "borrowed",localField: "member_id",foreignField: "member_id",as: "borrows"}},
  { $match: { borrows: { $eq: [] } } },
  {$project: {_id: 0,member_name: "$name"}}
])

// 17.
db.books.aggregate([
  {$lookup: {from: "borrowed",localField: "book_id",foreignField: "book_id",as: "borrows"}},
  { $match: { borrows: { $eq: [] } } },
  {$project: {  _id: 0,  title: 1,  author: 1}}
])

// 18.
db.borrowed.aggregate([
  {$group: {  _id: "$member_id",  borrow_count: { $sum: 1 }}},
  { $match: { borrow_count: { $gt: 1 } } },
  {$lookup: {  from: "members",  localField: "_id",  foreignField: "member_id",  as: "member"}},
  { $unwind: "$member" },
  {$project: {  _id: 0,  member_name: "$member.name",  borrow_count: 1}}
])

// 19.
db.borrowed.aggregate([
  {$group: {  _id: {    $dateToString: { format: "%Y-%m-%d", date: "$date" }  },  total_borrowed: { $sum: 1 }}},
  {$project: {   _id: 0,date: "$_id",total_borrowed: 1}},
  { $sort: { date: 1 } }
])

// 20.
db.borrowed.aggregate([
  {$lookup: { from: "books", localField: "book_id", foreignField: "book_id", as: "book"}},
  { $unwind: "$book" },
  { $match: { "book.copies": { $lt: 5 } } },
  {$project: { _id: 0, borrow_id: 1, book_title: "$book.title", copies_at_borrow: "$book.copies", date: 1 }}
])

// bonus
// 1.
db.borrowed.updateMany({}, [
  {$set: {due_date: {  $dateAdd: {startDate: "$date",unit: "day",amount: 14 }}}}
])
db.borrowed.aggregate([
  {$match: {  returned: false,  due_date: { $lt: new Date() }}},
  { $lookup: { from: "members", localField: "member_id", foreignField: "member_id", as: "member" }},
  { $unwind: "$member" },
  {$lookup: { from: "books",localField: "book_id",foreignField: "book_id",as: "book" }},
  { $unwind: "$book" },
  {$project: {_id: 0,member_name: "$member.name",book_title: "$book.title",borrowed_on: "$date",due_date: 1}}
])

// 2.
db.borrowed.aggregate([
  {$lookup: {from: "books",  localField: "book_id",  foreignField: "book_id",  as: "book"}},
  { $unwind: "$book" },
  {$group: { _id: "$book.genre", borrowed_count: { $sum: 1 } }},
  {$project: {   _id: 0,genre: "$_id",borrowed_count: 1}},
  { $sort: { borrowed_count: -1 } }
])
