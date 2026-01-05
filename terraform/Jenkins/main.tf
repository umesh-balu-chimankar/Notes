provider "aws" {
    region = "eu-west-3"
}

resource "aws_instance" "jenkins_terraform" {
    ami = var.image_id
    instance_type = var.machine_type
    key_name = "paris-key"
    vpc_security_group_ids = ["sg-035d9053b01e56d1a"]
    
    user_data = <<-EOF
             #!/bin/bash
             sudo -i
             yum update -y
             wget -O /etc/yum.repos.d/jenkins.repo \
             https://pkg.jenkins.io/redhat-stable/jenkins.repo 
             rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key 
             yum upgrade
             yum install java -y 
             yum install jenkins -y 
             systemctl enable jenkins
             systemctl start jenkins
             systemctl status jenkins 
             EOF 
    

    tags = {
        Name = "jenkins-terraform" 
        env  =  "dev"
    } 


}   