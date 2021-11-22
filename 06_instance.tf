resource "aws_eip" "Final_mgmt_eip"{
  count                = 1
  instance             = aws_instance.mgmt[count.index].id
  vpc                  = true
  tags = {
    Name = "Final-mgmt-eip"
  }
}


# instance

resource "aws_instance" "mgmt" {
  count                  = 1
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.mgmt_sg.id]
  availability_zone      = "${var.region}${var.zone[count.index]}"
  private_ip             = null
  subnet_id              = aws_subnet.pub_subnet[count.index].id
  tags = {
    Name                 = "Final-mgmt"
    }
}




resource "aws_instance" "web_apache" {
  count                  = length(var.zone)
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  availability_zone      = "${var.region}${var.zone[count.index]}"
  private_ip             = null
  subnet_id              = aws_subnet.web_subnet[count.index].id
  tags = {
    Name                 = "Final-web-${var.zone[count.index]}"
    Type                 = "apache-${var.zone[count.index]}"
    }
}

resource "aws_instance" "web_nginx" {
  count                  = length(var.zone)
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  availability_zone      = "${var.region}${var.zone[count.index]}"
  private_ip             = null
  subnet_id              = aws_subnet.web_subnet[count.index].id
  tags = {
    Name                 = "Final-web-${var.zone[count.index]}"
    Type                 = "nginx-${var.zone[count.index]}"
    }
}


resource "aws_instance" "was" {
  count                  = length(var.zone)
  ami                    = var.ami
  instance_type          = "t2.xlarge"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.was_sg.id]
  availability_zone      = "${var.region}${var.zone[count.index]}"
  private_ip             = null
  subnet_id              = aws_subnet.was_subnet[count.index].id
  tags = {
    Name                 = "Final-was-${var.zone[count.index]}"
    }
}