# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

roadmaps = [
  {
    title: "Frontend Developer",
    description: "Comprehensive guide to becoming a frontend developer, including HTML, CSS, JavaScript, and frameworks.",
    category: "Roles"
  },
  {
    title: "Backend Developer",
    description: "Comprehensive guide to becoming a proficient backend developer, focusing on server-side programming, database management, API development, and integration with frontend technologies. You’ll explore various programming languages, frameworks, and tools to build robust and scalable server applications.",
    category: "Roles"
  },
]

roadmaps.each do |roadmap|
  Roadmap.find_or_create_by(title: roadmap[:title]) do |r|
    r.description = roadmap[:description]
    r.category = roadmap[:category]
  end
end