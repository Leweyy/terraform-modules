locals {

  this_id                           = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.id) : join(",", aws_instance.this.*.id))}"
  this_availability_zone            = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.availability_zone) : join(",", aws_instance.this.*.availability_zone))}"
  this_key_name                     = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.key_name) : join(",", aws_instance.this.*.key_name))}"
  this_public_dns                   = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.public_dns) : join(",", aws_instance.this.*.public_dns))}"
  this_public_ip                    = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.public_ip) : join(",", aws_instance.this.*.public_ip))}"
  this_primary_network_interface_id = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.primary_network_interface_id) : join(",", aws_instance.this.*.primary_network_interface_id))}"
  this_private_dns                  = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.private_dns) : join(",", aws_instance.this.*.private_dns))}"
  this_private_ip                   = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.private_ip) : join(",", aws_instance.this.*.private_ip))}"
  this_security_groups              = "${split(",", var.spot ? join(",", flatten(aws_spot_instance_request.this.*.security_groups)) : join(",", flatten(aws_instance.this.*.security_groups)))}"
  this_vpc_security_group_ids       = "${split(",", var.spot ? join(",", flatten(aws_spot_instance_request.this.*.vpc_security_group_ids)) : join(",", flatten(aws_instance.this.*.vpc_security_group_ids)))}"
  this_subnet_id                    = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.subnet_id) : join(",", aws_instance.this.*.subnet_id))}"
  //this_tags                         = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.tags) : join(",", aws_instance.this.*.tags))}"
  //this_volume_tags                  = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.volume_tags) : join(",", aws_instance.this.*.volume_tags))}"
  this_placement_group              = "${split(",", var.spot ? join(",", aws_spot_instance_request.this.*.placement_group) : join(",", aws_instance.this.*.placement_group))}"

}

output "id" {
  description = "List of IDs of instances"
  value       = ["${local.this_id}"]
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = ["${local.this_availability_zone}"]
}

output "placement_group" {
  description = "List of placement groups of instances"
  value       = ["${local.this_placement_group}"]
}

output "key_name" {
  description = "List of key names of instances"
  value       = ["${local.this_key_name}"]
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = ["${local.this_public_dns}"]
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${local.this_public_ip}"]
}

output "primary_network_interface_id" {
  description = "List of IDs of the primary network interface of instances"
  value       = ["${local.this_primary_network_interface_id}"]
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = ["${local.this_private_dns}"]
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = ["${local.this_private_ip}"]
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = ["${local.this_security_groups}"]
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = ["${local.this_vpc_security_group_ids}"]
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value = ["${local.this_subnet_id}"]
}

/*output "tags" {
  description = "List of tags of instances"
  value       = ["${local.this_tags}"]
}

output "volume_tags" {
  description = "List of volume tags of instances"
  value       = ["${local.this_volume_tags}"]
}*/

#==================
# Spot
#==================

output "spot_bid_status" {
  description = "The current bid status of the Spot Instance Request."
  value       = ["${aws_spot_instance_request.this.*.spot_bid_status}"]
}

output "spot_request_state" {
  description = "The current request state of the Spot Instance Request."
  value       = ["${aws_spot_instance_request.this.*.spot_request_state}"]
}

output "spot_instance_id" {
  description = "The Instance ID (if any) that is currently fulfilling the Spot Instance request."
  value       = ["${aws_spot_instance_request.this.*.spot_instance_id}"]
}