# Blog with Users

This is a Flask-based blog application with user authentication and authorization. Users can register, log in, create posts, comment on posts, and view all posts. The application also includes an admin-only section for managing posts.

## Features

- User registration and login
- Password hashing for security
- Create, edit, and delete blog posts (admin only)
- Comment on blog posts
- Gravatar integration for user profile images
- CSRF protection
- Responsive design with Bootstrap 5

## Installation

### Prerequisites

- Python 3.9 or higher
- Docker (optional, for containerized deployment)

### Clone the Repository

```sh
git clone https://github.com/yourusername/blog-with-users.git
cd blog-with-users
```

### Create a Virtual Environment
```sh
python -m venv .venv
source .venv/bin/activate  # On Windows use `.venv\Scripts\activate`
```

### Install Dependencies
```sh
pip install -r requirements.txt
```

### Set Environment Variables
Create a `.env` file in the project root and add the following environment variables:
```sh
APP_SECRET_KEY=your_generated_secret_key_here
DB_URI=sqlite:///posts.db  # Or your preferred database URI
```

### Run the Application
```sh
flask run
```

The application will be available at `http://127.0.0.1:5000`.

## Docker Deployment

### Build the Docker Image
```sh
docker build -t blog-with-users .
```

### Run the Docker Container
```sh
docker run -d -p 5000:5000 --name blog-with-users blog-with-users
```

The application will be available at `http://127.0.0.1:5000`.

## Project Structure
```plaintext
blog-with-users/
├── .venv/
├── templates/
│   ├── about.html
│   ├── contact.html
│   ├── footer.html
│   ├── header.html
│   ├── index.html
│   ├── login.html
│   ├── make-post.html
│   ├── post.html
│   ├── register.html
│   └── ...
├── static/
│   ├── assets/
│   │   ├── img/
│   │   │   ├── login-bg.jpg
│   │   │   └── ...
│   │   └── ...
│   └── ...
├── forms.py
├── main.py
├── requirements.txt
├── Dockerfile
└── README.md
```

## Usage

### Register
Navigate to `/register` to create a new user account.

### Login
Navigate to `/login` to log in with an existing account.

### Create a Post
Navigate to `/new-post` (admin only) to create a new blog post.

### Edit a Post
Navigate to `/edit-post/<post_id>` (admin only) to edit an existing blog post.

### Delete a Post
Navigate to `/delete/<post_id>` (admin only) to delete a blog post.

### Comment on a Post
Navigate to `/post/<post_id>` to view and comment on a blog post.