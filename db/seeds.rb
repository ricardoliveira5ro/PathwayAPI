# Delete all records and reset ids
Roadmap.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('roadmaps')

roadmaps = [
  {
    title: "Frontend Developer",
    description: "Comprehensive guide to becoming a frontend developer, including HTML, CSS, JavaScript, and frameworks.",
    category: "Roles"
  },
  {
    title: "Backend Developer",
    description: "Comprehensive guide to becoming a proficient backend developer, focusing on server-side programming, database management, API development, and integration with frontend technologies. You'll explore various programming languages, frameworks, and tools to build robust and scalable server applications.",
    category: "Roles"
  },
  {
    title: "Java Developer",
    description: "Roadmap for becoming a proficient Java developer, covering core Java, frameworks, and tools.",
    category: "Skills"
  }
]

roadmaps.each do |roadmap|
  Roadmap.create(roadmap)
end