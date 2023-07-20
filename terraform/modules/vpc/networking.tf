# Creating a VPC:
resource "aws_vpc" "myvpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name = "myvpc"
  }
}

# Creating public subnet:
resource "aws_subnet" "public" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr}"

  tags = {
    Name = "public"
  }
}

output "vpc_id" {
  value = "${aws_vpc.myvpc.id}"

}

output "subnet_id" {
  value = "${aws_subnet.public.id}"
}

# Creating a Internet Gateway:
resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "igw"
  }
}

output "igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}


#Creating a Routing Tabel For Public Subnet with routes(vpc and igw):
resource "aws_route_table" "pub-route" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "${var.pub-route_cidr}"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "pub-route"
  }
}

output "route_table_id" {
  value = "${aws_route_table.pub-route.id}"
}


# Creating Route Table Subnets Association For Public:
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.pub-route.id
}