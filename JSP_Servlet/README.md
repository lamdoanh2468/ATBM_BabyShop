# BabyShop Backend (BE)

This is the backend for the BabyShop application, built with Java Servlet, JSP, and MySQL.

## Technologies Used

-   **Java 21**
-   **Jakarta Servlet 6.1.0**
-   **Jakarta JSP / JSTL**
-   **JDBI 3.50.0** (Database access)
-   **MySQL** (Database)
-   **Gson** (JSON processing)
-   **Jakarta Mail** (OTP authentication)
-   **Docker & Docker Compose**

## Getting Started

### Prerequisites

-   JDK 21
-   Maven
-   MySQL 8.0 (if running locally without Docker)
-   Docker Desktop (optional, for Docker support)

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd BE
    ```

2.  **Database Setup:**
    -   Create a database named `db_babyshop`.
    -   Import the `db_babyshop.sql` file located in the root directory.
    -   Update database configuration in your application code if necessary (check `db.properties` or connection classes).

3.  **Build the project:**
    ```bash
    mvn clean package
    ```

## Running with Docker

You can easily run the application and the database using Docker Compose.

1.  **Build and start services:**
    ```bash
    docker-compose up -d --build
    ```
    This will start:
    -   `babyshop-mysql`: MySQL 8.0 database (Port 3306)
    -   `babyshop-web`: The web application (Port 8080)

2.  **Access the application:**
    Open your browser and navigate to `http://localhost:8080/BE`.

3.  **Stop services:**
    ```bash
    docker-compose down
    ```

## Project Structure

-   `src/main/java`: Java source code (Controllers, Models, Services, DAO).
-   `src/main/resources`: Configuration resources.
-   `src/main/webapp`: Web content (JSP, CSS, JS, Images).
-   `docker-compose.yml`: Docker services configuration.
-   `db_babyshop.sql`: Database initialization script.
