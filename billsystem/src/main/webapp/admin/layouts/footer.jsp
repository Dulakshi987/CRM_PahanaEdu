<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 16/07/2025
  Time: 5:36 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
   <style>
       /* Footer Styles */
       .main-footer {
           background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
           color: white;
           margin-top: 50px;
           position: relative;
       }

       .footer-container {
           max-width: 1200px;
           margin: 0 auto;
           padding: 0 20px;
       }

       .footer-content {
           display: grid;
           grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
           gap: 40px;
           padding: 50px 0 30px;
       }

       .footer-section h5 {
           color: #e7993c;
           margin-bottom: 20px;
           font-size: 20px;
           font-weight: 600;
           display: flex;
           align-items: center;
           gap: 10px;
       }

       .footer-section h6 {
           color: #ecf0f1;
           margin-bottom: 15px;
           font-size: 16px;
           font-weight: 600;
       }

       .footer-section p {
           color: #bdc3c7;
           line-height: 1.6;
           margin-bottom: 15px;
       }

       .footer-section ul {
           list-style: none;
           padding: 0;
           margin: 0;
       }

       .footer-section ul li {
           margin-bottom: 8px;
       }

       .footer-section ul li a {
           color: #bdc3c7;
           text-decoration: none;
           transition: all 0.3s ease;
           display: flex;
           align-items: center;
           gap: 8px;
       }

       .footer-section ul li a:hover {
           color: #e7993c;
           transform: translateX(5px);
       }

       .social-links {
           display: flex;
           gap: 15px;
           margin-top: 20px;
       }

       .social-links a {
           width: 40px;
           height: 40px;
           background: rgba(255, 255, 255, 0.1);
           border-radius: 50%;
           display: flex;
           align-items: center;
           justify-content: center;
           color: #bdc3c7;
           font-size: 18px;
           transition: all 0.3s ease;
       }

       .social-links a:hover {
           background: #e7993c;
           color: white;
           transform: translateY(-3px);
       }

       .contact-info p {
           display: flex;
           align-items: center;
           gap: 10px;
           margin-bottom: 10px;
       }

       .contact-info i {
           color: #e7993c;
           width: 16px;
           text-align: center;
       }

       .footer-bottom {
           border-top: 1px solid rgba(255, 255, 255, 0.1);
           padding: 20px 0;
       }

       .footer-bottom-content {
           display: flex;
           justify-content: space-between;
           align-items: center;
           flex-wrap: wrap;
           gap: 20px;
       }

       .footer-bottom p {
           color: #bdc3c7;
           margin: 0;
       }

       .footer-links {
           display: flex;
           gap: 20px;
       }

       .footer-links a {
           color: #bdc3c7;
           text-decoration: none;
           font-size: 14px;
           transition: all 0.3s ease;
       }

       .footer-links a:hover {
           color: #e7993c;
       }

       /* Back to Top Button */
       .back-to-top {
           position: fixed;
           bottom: 30px;
           right: 30px;
           width: 50px;
           height: 50px;
           background: linear-gradient(135deg, #e7993c, #d4831f);
           color: white;
           border-radius: 50%;
           display: none;
           align-items: center;
           justify-content: center;
           cursor: pointer;
           box-shadow: 0 4px 15px rgba(231, 153, 60, 0.4);
           transition: all 0.3s ease;
           z-index: 1000;
       }

       .back-to-top:hover {
           transform: translateY(-3px);
           box-shadow: 0 6px 20px rgba(231, 153, 60, 0.6);
       }

       .back-to-top i {
           font-size: 18px;
       }

       /* Responsive Footer */
       @media (max-width: 991.98px) {
           .footer-content {
               grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
               gap: 30px;
               padding: 40px 0 20px;
           }

           .footer-bottom-content {
               flex-direction: column;
               text-align: center;
           }

           .footer-links {
               justify-content: center;
           }
       }

       @media (max-width: 576px) {
           .footer-content {
               grid-template-columns: 1fr;
               gap: 25px;
               padding: 30px 0 20px;
           }

           .footer-container {
               padding: 0 15px;
           }

           .social-links {
               justify-content: center;
           }

           .footer-links {
               flex-direction: column;
               gap: 10px;
           }

           .back-to-top {
               bottom: 20px;
               right: 20px;
               width: 45px;
               height: 45px;
           }

           .back-to-top i {
               font-size: 16px;
           }
       }

       /* Footer spacing adjustment for content */
       .content {
           margin-bottom: 0;
           padding-bottom: 0;
       }
   </style>
</head>
<body>
<!-- footer.jsp -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.querySelector('.sidebar-overlay');
        sidebar.classList.toggle('active');
        overlay.classList.toggle('active');
    }

    function closeSidebar() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.querySelector('.sidebar-overlay');
        sidebar.classList.remove('active');
        overlay.classList.remove('active');
    }

    document.querySelectorAll('.sidebar a').forEach(link => {
        link.addEventListener('click', function () {
            if (window.innerWidth <= 991) {
                closeSidebar();
            }
        });
    });

    window.addEventListener('resize', function () {
        if (window.innerWidth > 991) {
            closeSidebar();
        }
    });
</script>

</body>
</html>
