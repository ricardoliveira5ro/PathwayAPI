# Delete all records
RoadmapCategory.delete_all
Category.delete_all
Step.delete_all
Roadmap.delete_all

# Reset IDs
ActiveRecord::Base.connection.reset_pk_sequence!('roadmap_categories')
ActiveRecord::Base.connection.reset_pk_sequence!('categories')
ActiveRecord::Base.connection.reset_pk_sequence!('steps')
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

steps = {
  "Frontend Developer" => [
    { title: "HTML", description: "HTML stands for HyperText Markup Language. It is used on the frontend and gives the structure to the webpage which you can style using CSS and make interactive using JavaScript.", order: 1 },
    { title: "CSS", description: "CSS or Cascading Style Sheets is the language used to style the frontend of any website. CSS is a cornerstone technology of the World Wide Web, alongside HTML and JavaScript.", order: 2 },
    { title: "JavaScript", description: "JavaScript allows you to add interactivity to your pages. Common examples that you may have seen on the websites are sliders, click interactions, popups and so on.", order: 3 },
    { title: "Frontend Framework", description: "Web frameworks are designed to write web applications. Frameworks are collections of libraries that aid in the development of a software product or website. Frameworks for web application development are collections of various tools. Frameworks vary in their capabilities and functions, depending on the tasks set. They define the structure, establish the rules, and provide the development tools required.", order: 4 },
    { title: "Testing", description: "Before delivering your application to users, you need to be sure that your app meets the requirements it was designed for, and that it doesn't do any weird, unintended things (called bugs). To accomplish this, we test our applications in different ways.", order: 5 },
    { title: "Web Security", description: "Web security refers to the protective measures taken by the developers to protect the web applications from threats that could affect the business", order: 6 },
  ],
  "Backend Developer" => [
    { title: "Language", description: "Start with a server-side language like Node.js, Python, or Java.", order: 1 },
    { title: "Relational Databases", description: "A relational database is a type of database that stores and provides access to data points that are related to one another. Relational databases store data in a series of tables. Interconnections between the tables are specified as foreign keys. A foreign key is a unique reference from one row in a relational table to another row in a table, which can be the same table but is most commonly a different table.", order: 2 },
    { title: "APIs", description: "API is the acronym for Application Programming Interface, which is a software intermediary that allows two applications to talk to each other.", order: 3 },
    { title: "Web Security", description: "Web security refers to the protective measures taken by the developers to protect the web applications from threats that could affect the business", order: 4 },
    { title: "Testing", description: "A key to building software that meets requirements without defects is testing. Software testing helps developers know they are building the right software. When tests are run as part of the development process (often with continuous integration tools), they build confidence and prevent regressions in the code.", order: 5 },
    { title: "CI/CD", description: "CI/CD (Continuous Integration/Continuous Deployment) is the practice of automating building, testing, and deployment of applications with the main goal of detecting issues early, and provide quicker releases to the production environment.", order: 6 },
    { title: "Architectural Patterns", description: "An architectural pattern is a general, reusable solution to a commonly occurring problem in software architecture within a given context. The architectural patterns address various issues in software engineering, such as computer hardware performance limitations, high availability and minimization of a business risk.", order: 7 }
    
  ],
  "Java Developer" => [
    { title: "Fundamentals", description: "Learn about the fundamentals of Java such as basic syntax, data types, variables, conditionals, functions, data structures, packages, etc.", order: 1 },
    { title: "Build tools", description: "A build tool is a program or command-line utility that automates the process of compiling, assembling, and deploying software. Build tools are not only limited to compiling code; they can also help with package management, dependency handling, and continuous integration systems.", order: 2 },
    { title: "Object-Relational Mapping", description: "A programming method to map objects in Java to relational entities in a database. In other words, converting data between relational databases and object-oriented programming languages. Some popular ORM tools/frameworks in Java are Spring Data JPA, Hibernate, Ebean", order: 3 },
    { title: "JDBC", description: "JDBC is an API(Application programming interface) used in java programming to interact with databases. The classes and interfaces of JDBC allow the application to send requests made by users to the specified database.", order: 4 }
  ]
}

roadmaps = [
  {
    title: "Frontend Developer",
    description: "Comprehensive guide to becoming a frontend developer, including HTML, CSS, JavaScript, and frameworks.",
    categories: ["Roles"]
  },
  {
    title: "Backend Developer",
    description: "Comprehensive guide to becoming a proficient backend developer, focusing on server-side programming, database management, API development, and integration with frontend technologies. You'll explore various programming languages, frameworks, and tools to build robust and scalable server applications.",
    categories: ["Roles"]
  },
  {
    title: "Java Developer",
    description: "Roadmap for becoming a proficient Java developer, covering core Java, frameworks, and tools.",
    categories: ["Skills", "Languages"]
  }
]

# Create categories
created_categories = {}
categories.each do |category|
  created_categories[category[:name]] = Category.create!(category)
end

# Create roadmaps with categories
created_roadmaps = {}
roadmaps.each do |roadmap|
  roadmap_categories = roadmap.delete(:categories).map { |name| created_categories[name] }
  created_roadmaps[roadmap[:title]] = Roadmap.create!(roadmap.merge(categories: roadmap_categories))
end

# Create and associate steps with roadmaps
steps.each do |roadmap_title, steps_array|
  roadmap = created_roadmaps[roadmap_title]
  steps_array.each do |step|
    roadmap.steps.create!(step)
  end
end