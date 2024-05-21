#!/bin/bash

# Install Apache on Ubuntu
sudo yum check-update
sudo yum -y update
# apache installation, enabling and status check
sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd | grep Active
# firewall installation, start and status check
sudo yum install firewalld
sudo systemctl start firewalld
sudo systemctl status firewalld | grep Active
# adding http services
sudo firewall-cmd — permanent — add-service=http
# reloading the firewall
sudo firewall-cmd — reload


sudo cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevOps Culture and Terraform with AWS</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
        }
        h1 {
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        p {
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <header>
        <h1>The Importance of DevOps Culture and Terraform with AWS</h1>
    </header>
    <div class="container">
        <p>DevOps is not just a set of tools and practices; it's a culture that emphasizes collaboration, communication, and integration between development and operations teams. By fostering a DevOps culture, organizations can streamline their software development processes, improve deployment frequency, and achieve faster time-to-market.</p>
        <p>One key tool in the DevOps toolkit is Terraform, a widely-used infrastructure as code (IaC) tool that allows you to define and provision infrastructure resources using a declarative configuration language. With Terraform, you can easily manage your infrastructure as code, enabling reproducible and consistent deployments across different environments.</p>
        <p>When combined with AWS (Amazon Web Services), Terraform becomes even more powerful. AWS offers a vast array of cloud services and resources that can be provisioned and managed using Terraform, including compute instances, storage, databases, networking components, and more. By leveraging Terraform with AWS, organizations can automate their infrastructure provisioning, scale resources as needed, and maintain infrastructure as code alongside their application code.</p>
        <p>In summary, embracing a DevOps culture and adopting Terraform with AWS can lead to greater agility, reliability, and efficiency in software development and operations, ultimately helping organizations deliver better products and services to their customers.</p>
    </div>
</body>
</html>

EOF