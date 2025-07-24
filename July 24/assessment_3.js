use job_portal
db.jobs.insertMany([
  {
    job_id: 101, title: "Backend Developer", company: "TechNova", location: "Bangalore",
    salary: 1200000, job_type: "remote", posted_on: new Date("2025-07-10")
  },
  {
    job_id: 102, title: "Frontend Developer", company: "InnovateX", location: "Delhi",
    salary: 950000, job_type: "on-site", posted_on: new Date("2025-07-02")
  },
  {
    job_id: 103, title: "Data Analyst", company: "DataWise", location: "Mumbai",
    salary: 1050000, job_type: "hybrid", posted_on: new Date("2025-06-25")
  },
  {
    job_id: 104, title: "DevOps Engineer", company: "TechNova", location: "Remote",
    salary: 1300000, job_type: "remote", posted_on: new Date("2025-07-18")
  },
  {
    job_id: 105, title: "ML Engineer", company: "AI Labs", location: "Hyderabad",
    salary: 1600000, job_type: "remote", posted_on: new Date("2025-07-05")
  }
])

db.applicants.insertMany([
  {
    applicant_id: 201, name: "Arjun Rao", skills: ["Python", "MongoDB"], experience: 3,
    city: "Hyderabad", applied_on: new Date("2025-07-10")
  },
  {
    applicant_id: 202, name: "Meera Iyer", skills: ["React", "Node.js"], experience: 2,
    city: "Bangalore", applied_on: new Date("2025-07-11")
  },
  {
    applicant_id: 203, name: "Zoya Khan", skills: ["MongoDB", "Express", "JavaScript"],
    experience: 4, city: "Chennai", applied_on: new Date("2025-07-13")
  },
  {
    applicant_id: 204, name: "Rakesh Mehta", skills: ["SQL", "Java"], experience: 1,
    city: "Mumbai", applied_on: new Date("2025-07-01")
  },
  {
    applicant_id: 205, name: "Divya Nair", skills: ["Python", "Machine Learning"],
    experience: 2, city: "Hyderabad", applied_on: new Date("2025-07-15")
  }
])

db.applications.insertMany([
  {
    application_id: 301, applicant_id: 201, job_id: 101,
    application_status: "interview scheduled", interview_scheduled: true,
    feedback: "Technical round cleared"
  },
  {
    application_id: 302, applicant_id: 202, job_id: 102,
    application_status: "applied", interview_scheduled: false, feedback: ""
  },
  {
    application_id: 303, applicant_id: 203, job_id: 105,
    application_status: "interview scheduled", interview_scheduled: true,
    feedback: "Awaiting HR round"
  },
  {
    application_id: 304, applicant_id: 203, job_id: 103,
    application_status: "rejected", interview_scheduled: false,
    feedback: "Not a fit"
  },
  {
    application_id: 305, applicant_id: 205, job_id: 105,
    application_status: "applied", interview_scheduled: false, feedback: ""
  }
])

// 1.
db.jobs.find({ job_type: "remote", salary: { $gt: 1000000 }})

// 2.
db.applicants.find({skills: "MongoDB"})

// 3.
db.jobs.countDocuments({
  posted_on: { $gte: new Date(new Date().setDate(new Date().getDate() - 30)) }
})

// 4.
db.applications.find({application_status: "interview scheduled"})

// 5.
db.jobs.aggregate([
  {$group: {_id: "$company",total_jobs: { $sum: 1 }}},
  {$match: {total_jobs: { $gt: 2 } } }
])

// 6.
db.applications.aggregate([
  { $lookup: {from: "jobs",localField: "job_id",foreignField: "job_id",as: "job_info"}},
  { $unwind: "$job_info" },
  { $lookup: { from: "applicants", localField: "applicant_id", foreignField: "applicant_id", as: "applicant_info"}},
  { $unwind: "$applicant_info" },
  { $project: {_id: 0,applicant_name: "$applicant_info.name",job_title: "$job_info.title"} }
])

// 7.
db.applications.aggregate([
  { $group: {_id: "$job_id", total_applications: { $sum: 1 }}},
  { $lookup: {from: "jobs", localField: "_id",foreignField: "job_id", as: "job_info"}},
  { $unwind: "$job_info" },
  { $project: {_id: 0, job_title: "$job_info.title", total_applications: 1}}
])

// 8.
db.applications.aggregate([
  { $group: {_id: "$applicant_id", applications_count: { $sum: 1 }}},
  { $match: { applications_count: { $gt: 1 } } },
  { $lookup: {from: "applicants", localField: "_id",foreignField: "applicant_id", as: "applicant"}},
  { $unwind: "$applicant" },
  { $project: {_id: 0,applicant_name: "$applicant.name",applications_count: 1}}
])

// 9.
db.applicants.aggregate([
  { $group: {_id: "$city", total_applicants: { $sum: 1 }}},
  { $sort: { total_applicants: -1 } },
  { $limit: 3 },
  { $project: {_id: 0,city: "$_id", total_applicants: 1}}
])

// 10.
db.jobs.aggregate([
  { $group: {_id: "$job_type",avg_salary: { $avg: "$salary" } }},
  { $project: {_id: 0,job_type: "$_id", avg_salary: { $round: ["$avg_salary", 2] }}}
])

// 11.
db.applications.updateOne(
  { application_id: 301 },
  { $set: { application_status: "offer made" } }
)

// 12.
db.jobs.deleteMany({
  job_id: { $nin: db.applications.distinct("job_id")}
})

// 13.
db.applications.updateMany({},
    { $set: { shortlisted: false } 
})

// 14.
db.applicants.updateMany({ 
    city: "Hyderabad" },
    { $inc: { experience: 1 } 
})

// 15.
db.applicants.deleteMany({
    applicant_id: {$nin: db.applications.distinct("applicant_id")}
})

