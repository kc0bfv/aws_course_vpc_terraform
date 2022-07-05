resource "aws_security_group" "allow_SSH_4k" {
  name        = "allow_SSH_4k"
  description = "Allow SSH and 4000 incoming, everything outgoing"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 4000
    to_port          = 4000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

variable "ami" {
  default = "ami-02d1e544b84bf7502"
}

variable "instance" {
  default = "t2.micro"
}

resource "aws_key_pair" "key" {
  key_name   = "course_key"
  public_key = file("course_key.pub")
}

resource "aws_instance" "public" {
  ami                    = var.ami
  instance_type          = var.instance
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.allow_SSH_4k.id]
  subnet_id              = aws_subnet.public.id
}

resource "aws_instance" "private" {
  ami                    = var.ami
  instance_type          = var.instance
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.allow_SSH_4k.id]
  subnet_id              = aws_subnet.private.id
}

output "public_inst_public_ip_address" {
  value = aws_instance.public.public_ip
}

output "public_inst_private_ip_address" {
  value = aws_instance.public.private_ip
}

output "private_inst_public_ip_address" {
  value = aws_instance.private.public_ip
}

output "private_inst_private_ip_address" {
  value = aws_instance.private.private_ip
}
