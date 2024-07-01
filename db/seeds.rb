# Delete all records
RoadmapCategory.delete_all
Category.delete_all
Roadmap.delete_all

# Reset IDs
ActiveRecord::Base.connection.reset_pk_sequence!('roadmap_categories')
ActiveRecord::Base.connection.reset_pk_sequence!('categories')
ActiveRecord::Base.connection.reset_pk_sequence!('roadmaps')

categories = [
  { name: "Roles" },
  { name: "Skills" },
  { name: "Web Development" },
  { name: "Frameworks" },
  { name: "Languages" },
  { name: "DevOps" },
  { name: "Databases" },
  { name: "Game Development" },
  { name: "Design" }
]

roadmaps = [
  {
    title: "Frontend Developer",
    description: "Comprehensive guide to becoming a frontend developer, including HTML, CSS, JavaScript, and frameworks."
  },
  {
    title: "Backend Developer",
    description: "Comprehensive guide to becoming a proficient backend developer, focusing on server-side programming, database management, API development, and integration with frontend technologies. You'll explore various programming languages, frameworks, and tools to build robust and scalable server applications."
  },
  {
    title: "Java Developer",
    description: "Roadmap for becoming a proficient Java developer, covering core Java, frameworks, and tools."
  }
]

# Create categories
created_categories = {}
categories.each do |category|
  created_categories[category[:name]] = Category.create!(category)
end

# Create roadmaps
created_roadmaps = {}
roadmaps.each do |roadmap|
  created_roadmaps[roadmap[:title]] = Roadmap.create!(roadmap)
end

# Associate roadmaps with categories
created_roadmaps["Frontend Developer"].categories << created_categories["Roles"]
created_roadmaps["Backend Developer"].categories << created_categories["Roles"]
created_roadmaps["Java Developer"].categories << created_categories["Skills"]
created_roadmaps["Java Developer"].categories << created_categories["Languages"]