# PathwayAPI

PathwayAPI is a robust and flexible API designed to help users create, manage, and track personalized roadmaps for achieving various goals. It enables users to follow predefined roadmaps or create their own custom plans, breaking them down into manageable steps with detailed descriptions, deadlines, and progress tracking.

`pathwayapi.onrender.com/api/v1/` hosts a public instance of the API. 

> [!WARNING]
> The first request may take up to 60 seconds due to tier restrictions. (Next ones will be normalized)

## 🚀 Getting Started

This section will guide you through using PathwayAPI, including how to authenticate and access the available features.

#### 🔐 Authentication / Authorization

Each endpoint requires previous authentication based on bearer token. This token can be obtained after sign up and/or login as returned header. The token has 30 days expiration date.

**POST** /signup
```
{
    "user": {
        "email": "[your-email@email.com]",
        "password": "[your-password]",
        "name": "[your-username]"
    }
}
```

**POST** /login
```
{
    "user": {
        "email": "[your-email@email.com]",
        "password": "[your-password]"
    }
}
```
In the response headers you can see you got your **authorization token** that will be needed in every request you make to the available endpoints.

#### 📍 Endpoints

**GET** /roadmaps <br/>
**GET** /roadmaps/:id

**DELETE** /roadmaps/:id

**POST** /roadmaps <br/>
**PUT** /roadmaps/:id
```
{
    "roadmap": {
        "title": "First Roadmap",
        "description": "First description of the new roadmap",
        "category_ids": [2,6],
        "steps_attributes": [
            {
                "title": "First Step",
                "description": "First Step Description",
                "order": 1
            }
        ]
    }
}
```
*steps_attributes* is **optional** and in update action (PUT /:id) it **appends to existent steps**, does not override unlike the other fields

**GET** /roadmaps/:id/steps <br/>
**POST** /roadmaps/:id/steps
```
{
    "step": {
        "title": "Step title",
        "description": "Step description",
        "order": 1
    }
}
```

**POST** /roadmaps/:id/steps/batch_steps
```
{
    "steps": [
        { "title": "Step 1", "description": "Description 1", "order": 1 },
        { "title": "Step 2", "description": "Description 2", "order": 2 },
        { "title": "Step 3", "description": "Description 3", "order": 3 }
    ]
}
```

---

**GET** /categories <br/>
**GET** /categories/:id

---

**GET** /steps/:id <br/>
**PUT** /steps/:id
```
{
    "step": {
        "title": "Step title",
        "description": "Step description",
        "order": 1
    }
}
```

---

