#
# Copyright 2015 Ettus Research
#

if [expr $argc < 5] {
    error "ERROR: Invalid arguments."
    exit
}

set cmd         [lindex $argv 0]
set ip_name     [lindex $argv 1]
set ip_vlnv     [lindex $argv 2]
set part_name   [lindex $argv 3]
set ip_dir      [lindex $argv 4]

if { [string compare $cmd "create"] == 0 } {
    create_project -in_memory -ip -name inmem_ip_proj -part $part_name
    create_ip -vlnv $ip_vlnv -module_name $ip_name -dir $ip_dir
} elseif { [string compare $cmd "modify"] == 0 } {
    create_project -in_memory -ip -name inmem_ip_proj -part $part_name
    read_ip $ip_dir/$ip_name/$ip_name.xci
} elseif { [string compare $cmd "list"] == 0 } {
    create_project -in_memory -ip -name inmem_ip_proj -part $part_name
    puts "Supported IP for device ${part_name}:"
    foreach ip [lsort [get_ipdefs]] {
        puts "- $ip"
    }
} else {
    error "ERROR: Invalid command: $cmd"
}