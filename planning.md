# PathwayAPI

### 📝 Description

PathwayAPI is a robust and flexible application programming interface (API) designed to help users create, manage, and track personalized roadmaps for achieving various goals.

It enables users to follow predefined roadmaps or create their own custom plans, breaking them down into manageable steps with detailed descriptions, deadlines, and progress tracking.

### 🔑 Key features

* **CRUD Operations for Roadmaps and Steps**: Create, Read, Update, and Delete roadmaps and individual steps
* **Default Roadmaps**: Preloaded with industry-standard roadmaps
* **Progress Tracking**: Mark steps as completed and track overall progress.

### 💻 Technical Overview

##### 🤖 Models

* **Roadmap**: title, description, *steps*, completed
* **Category**: name
* **Step**: title, description, order
* **User**: roadmaps

##### 📌 Endpoints

* Authentication
* Roadmaps
* Steps

##### 💭 Considerations

* Postgres database
* API versioning
* Authentication and Authorization (devise gem)
* Token-based authentication
* Sanitize inputs (security)

##### 🚀 Deployment

* **DB**: Neon.tech
* **Webservice**: Render.com