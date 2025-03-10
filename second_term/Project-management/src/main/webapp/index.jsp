<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TaskFlow - Project Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #7209b7;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #38b000;
            --gray: #6c757d;
            --gray-light: #e9ecef;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--light);
            color: var(--dark);
            line-height: 1.6;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header Styles */
        header {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .logo i {
            margin-right: 10px;
        }

        .nav-links {
            display: flex;
            gap: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--dark);
            font-weight: 500;
            transition: color 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .nav-links a:hover {
            color: var(--primary);
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: var(--primary);
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s, transform 0.2s;
        }

        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-outline {
            background-color: transparent;
            border: 2px solid var(--primary);
            color: var(--primary);
        }

        .btn-outline:hover {
            background-color: var(--primary);
            color: white;
        }

        /* Hero Section */
        .hero {
            padding: 80px 0;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e7eb 100%);
        }

        .hero-content {
            display: flex;
            align-items: center;
            gap: 40px;
        }

        .hero-text {
            flex: 1;
        }

        .hero-image {
            flex: 1;
            text-align: center;
        }

        .hero-image img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: var(--dark);
            line-height: 1.2;
        }

        .hero-text p {
            font-size: 1.1rem;
            margin-bottom: 30px;
            color: var(--gray);
        }

        .hero-buttons {
            display: flex;
            gap: 15px;
        }

        /* Features Section */
        .features {
            padding: 80px 0;
            background-color: white;
        }

        .section-title {
            text-align: center;
            margin-bottom: 50px;
        }

        .section-title h2 {
            font-size: 2rem;
            color: var(--dark);
            margin-bottom: 15px;
        }

        .section-title p {
            color: var(--gray);
            max-width: 600px;
            margin: 0 auto;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }

        .feature-card {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 20px;
        }

        .feature-card h3 {
            font-size: 1.3rem;
            margin-bottom: 15px;
            color: var(--dark);
        }

        .feature-card p {
            color: var(--gray);
        }

        /* CTA Section */
        .cta {
            padding: 80px 0;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            text-align: center;
        }

        .cta h2 {
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .cta p {
            max-width: 600px;
            margin: 0 auto 30px;
            opacity: 0.9;
        }

        .btn-light {
            background-color: white;
            color: var(--primary);
        }

        .btn-light:hover {
            background-color: var(--gray-light);
        }

        /* Footer */
        footer {
            background-color: var(--dark);
            color: white;
            padding: 50px 0 20px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .footer-column h3 {
            font-size: 1.2rem;
            margin-bottom: 20px;
            color: white;
        }

        .footer-column ul {
            list-style: none;
        }

        .footer-column ul li {
            margin-bottom: 10px;
        }

        .footer-column a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-column a:hover {
            color: white;
        }

        .copyright {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.5);
            font-size: 0.9rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-content {
                flex-direction: column;
            }

            .hero-image {
                order: -1;
            }

            h1 {
                font-size: 2rem;
            }

            .navbar {
                flex-direction: column;
                gap: 20px;
            }

            .hero-buttons {
                flex-direction: column;
                align-items: flex-start;
            }

            .btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <div class="container">
        <nav class="navbar">
            <a href="#" class="logo">
                <i class="fas fa-tasks"></i> TaskFlow
            </a>
            <div class="nav-links">
                <a href="#features"><i class="fas fa-star"></i> Features</a>
                <a href="#about"><i class="fas fa-info-circle"></i> About</a>
                <a href="hello-servlet"><i class="fas fa-code"></i> API</a>
            </div>
        </nav>
    </div>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <div class="hero-content">
            <div class="hero-text">
                <h1>Streamline Your Projects with TaskFlow</h1>
                <p>A powerful project management system designed to help teams collaborate effectively, track progress, and deliver projects on time.</p>
                <div class="hero-buttons">
                    <a href="login" class="btn"><i class="fas fa-sign-in-alt"></i> Login</a>
                    <a href="signup" class="btn btn-outline"><i class="fas fa-user-plus"></i> Register</a>
                </div>
            </div>
            <div class="hero-image">
                <img src="https://via.placeholder.com/600x400?text=Project+Management" alt="Project Management Dashboard">
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="features" id="features">
    <div class="container">
        <div class="section-title">
            <h2>Powerful Features</h2>
            <p>Everything you need to manage your projects efficiently</p>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-tasks"></i>
                </div>
                <h3>Task Management</h3>
                <p>Create, assign, and track tasks with ease. Set priorities, deadlines, and monitor progress in real-time.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3>Progress Tracking</h3>
                <p>Visualize project progress with interactive charts and dashboards. Identify bottlenecks early.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h3>Team Collaboration</h3>
                <p>Foster teamwork with built-in communication tools, file sharing, and collaborative workspaces.</p>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta">
    <div class="container">
        <h2>Ready to Boost Your Productivity?</h2>
        <p>Join thousands of teams who have transformed their project management process with TaskFlow.</p>
        <a href="signup" class="btn btn-light">Get Started for Free</a>
    </div>
</section>

<!-- About Section -->
<section class="features" id="about">
    <div class="container">
        <div class="section-title">
            <h2>About TaskFlow</h2>
            <p>Our mission is to simplify project management for teams of all sizes</p>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-rocket"></i>
                </div>
                <h3>Our Mission</h3>
                <p>We're dedicated to creating tools that help teams work smarter, not harder. Our platform is designed to eliminate complexity and focus on what matters.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h3>Security First</h3>
                <p>Your data security is our priority. We implement industry-leading security measures to keep your projects and information safe.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-headset"></i>
                </div>
                <h3>24/7 Support</h3>
                <p>Our dedicated support team is always ready to help you with any questions or issues you might encounter.</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-column">
                <h3>TaskFlow</h3>
                <ul>
                    <li><a href="#features">Features</a></li>
                    <li><a href="#about">About Us</a></li>
                    <li><a href="#">Pricing</a></li>
                    <li><a href="#">Careers</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Resources</h3>
                <ul>
                    <li><a href="#">Documentation</a></li>
                    <li><a href="#">API</a></li>
                    <li><a href="#">Community</a></li>
                    <li><a href="#">Blog</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Legal</h3>
                <ul>
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Security</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Connect</h3>
                <ul>
                    <li><a href="#"><i class="fab fa-twitter"></i> Twitter</a></li>
                    <li><a href="#"><i class="fab fa-linkedin"></i> LinkedIn</a></li>
                    <li><a href="#"><i class="fab fa-github"></i> GitHub</a></li>
                </ul>
            </div>
        </div>
        <div class="copyright">
            &copy; <%= new java.util.Date().getYear() + 1900 %> TaskFlow. All rights reserved.
        </div>
    </div>
</footer>
</body>
</html>