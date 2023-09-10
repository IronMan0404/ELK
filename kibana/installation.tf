provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "elasticsearch_sg" {
  name        = "elasticsearch-sg"
  description = "Elasticsearch Security Group"
  
  # Define your security group rules here (e.g., allow SSH, Elasticsearch, and Kibana ports)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9200  # Elasticsearch HTTP port
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5601  # Kibana port
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add any other necessary rules here
}

resource "aws_instance" "elasticsearch_instance" {
  ami           = "ami-xxxxxxxxxxxxxx"  # Amazon Linux AMI in us-east-1
  instance_type = "t2.micro"  # Adjust instance type as needed
  key_name      = "your-ssh-key-pair-name"  # Replace with your SSH key pair name
  security_groups = [aws_security_group.elasticsearch_sg.name]
  user_data = <<-EOF
              #!/bin/bash
              # Install Elasticsearch 8.x and Java 11 Corretto
              sudo yum update -y
              sudo amazon-linux-extras install -y java-openjdk11
              sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
              sudo tee /etc/yum.repos.d/elasticsearch.repo <<EOF1
              [elasticsearch-8.x]
              name=Elasticsearch repository for 8.x packages
              baseurl=https://artifacts.elastic.co/packages/8.x/yum
              gpgcheck=1
              gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
              enabled=1
              autorefresh=1
              type=rpm-md
              EOF1
              sudo yum install -y elasticsearch
              sudo systemctl start elasticsearch
              sudo systemctl enable elasticsearch

              # Install Kibana
              sudo yum install -y kibana
              sudo systemctl start kibana
              sudo systemctl enable kibana
              EOF
}
