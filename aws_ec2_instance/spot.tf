locals {
  spot_is_t_instance_type = "${replace(var.instance_type, "/^t[23]{1}\\..*$/", "1") == "1" ? "1" : "0"}"
}
######
# EC2 spot instance
######
resource "aws_spot_instance_request" "this" {
  //count = "${var.spot && !local.spot_is_t_instance_type ? var.instance_count : 0}"
  count = "${var.spot ? var.instance_count : 0}"

  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  user_data              = "${var.user_data}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  monitoring             = "${var.monitoring}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  iam_instance_profile   = "${var.iam_instance_profile}"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  private_ip                  = "${var.private_ip}"
  ipv6_address_count          = "${var.ipv6_address_count}"
  ipv6_addresses              = "${var.ipv6_addresses}"

  ebs_optimized          = "${var.ebs_optimized}"
  volume_tags            = "${var.volume_tags}"
  root_block_device      = "${var.root_block_device}"
  ebs_block_device       = "${var.ebs_block_device}"
  ephemeral_block_device = "${var.ephemeral_block_device}"

  source_dest_check                    = "${var.source_dest_check}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  availability_zone                    = "${var.availability_zone}"
  placement_group                      = "${var.placement_group}"
  tenancy                              = "${var.tenancy}"

  spot_price                      = "${var.spot_price}"
  wait_for_fulfillment            = "${var.wait_for_fulfillment}"
  spot_type                       = "${var.spot_type}"
  instance_interruption_behaviour = "${var.instance_interruption_behaviour}"
  launch_group                    = "${var.launch_group}"
  block_duration_minutes          = "${var.block_duration_minutes}"
  //valid_from                      = "${var.valid_from}"
  //valid_until                     = "${var.valid_until}"

  timeouts {
    create = "${var.create_timeout}"
    delete = "${var.delete_timeout}"
  }

  # Note: network_interface can't be specified together with associate_public_ip_address
  # network_interface = "${var.network_interface}"

  tags        = "${merge(var.tags, map("Name", format("%s-%d", var.name, count.index+1)))}"
  volume_tags = "${merge(map("Name", (var.instance_count > 1) || (var.use_num_suffix == "true") ? format("%s-%d", var.name, count.index+1) : var.name), var.volume_tags)}"

}

/*
resource "aws_spot_instance_request" "this_t2" {
  count = "${var.spot && local.spot_is_t_instance_type ? var.instance_count : 0}"

  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  user_data              = "${var.user_data}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  monitoring             = "${var.monitoring}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  iam_instance_profile   = "${var.iam_instance_profile}"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  private_ip                  = "${var.private_ip}"
  ipv6_address_count          = "${var.ipv6_address_count}"
  ipv6_addresses              = "${var.ipv6_addresses}"

  ebs_optimized          = "${var.ebs_optimized}"
  volume_tags            = "${var.volume_tags}"
  root_block_device      = "${var.root_block_device}"
  ebs_block_device       = "${var.ebs_block_device}"
  ephemeral_block_device = "${var.ephemeral_block_device}"

  source_dest_check                    = "${var.source_dest_check}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  availability_zone                    = "${var.availability_zone}"
  placement_group                      = "${var.placement_group}"
  tenancy                              = "${var.tenancy}"

  spot_price                      = "${var.spot_price}"
  wait_for_fulfillment            = "${var.wait_for_fulfillment}"
  spot_type                       = "${var.spot_type}"
  instance_interruption_behaviour = "${var.instance_interruption_behaviour}"
  launch_group                    = "${var.launch_group}"
  block_duration_minutes          = "${var.block_duration_minutes}"
  //valid_from                      = "${var.valid_from}"
  //valid_until                     = "${var.valid_until}"

  timeouts {
    create = "${var.create_timeout}"
    delete = "${var.delete_timeout}"
  }

  credit_specification {
    cpu_credits = "${var.cpu_credits}"
  }

  # Note: network_interface can't be specified together with associate_public_ip_address
  # network_interface = "${var.network_interface}"

  tags        = "${merge(var.tags, map("Name", format("%s-%d", var.name, count.index+1)))}"
  volume_tags = "${merge(map("Name", (var.instance_count > 1) || (var.use_num_suffix == "true") ? format("%s-%d", var.name, count.index+1) : var.name), var.volume_tags)}"

}*/
