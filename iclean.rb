#!/usr/bin/env ruby

# Name:         iclean (clean up iTunes directory)
# Version:      0.0.1
# Release:      1
# License:      CC-BA (Creative Commons By Attribution)
#               http://creativecommons.org/licenses/by/4.0/legalcode
# Group:        System
# Source:       N/A
# URL:          http://lateralblast.com.au/
# Distribution: UNIX
# Vendor:       Lateral Blast
# Packager:     Richard Spindler <richard@lateralblast.com.au>
# Description:  Script to clean up iTunes directory

require 'getopt/std'

# Set up some global variables/defaults

$script     = $0
$options    = "adhi:loV"
$itunes_dir = ENV["HOME"]+"/Music/iTunes"

def print_usage()
  puts
  puts "Usage: "+$script+" -["+$options+"]"
  puts
  puts "-h: Print usage information"
  puts "-V: Print version information"
  puts "-a: Handle old versions of application"
  puts "-l: List (used in conjunction with -a)"
  puts "-o: List old applications (used in conjunction with -a)"
  puts "-d: Delete old (used in conjunction with -a)"
  puts "-i: Set iTunes directory"
  puts
  return
end

# Get version

def get_version()
  file_array = IO.readlines $0
  version    = file_array.grep(/^# Version/)[0].split(":")[1].gsub(/^\s+/,'').chomp
  packager   = file_array.grep(/^# Packager/)[0].split(":")[1].gsub(/^\s+/,'').chomp
  name       = file_array.grep(/^# Name/)[0].split(":")[1].gsub(/^\s+/,'').chomp
  return version,packager,name
end

# Print script version information

def print_version()
  (version,packager,name) = get_version()
  puts name+" v. "+version+" "+packager
  exit
end

# Get application file list

def get_app_file_list()
  if !File.directory?($itunes_dir) and !File.symlink?($itunes_dir)
    puts "Could not find iTunes directory "+$itunes_dir
    exit
  end
  app_dir   = $itunes_dir+"/iTunes Media/Mobile Applications"
  if !File.directory?(app_dir) and !File.symlink?(app_dir)
    puts "Could not find Mobile Applications directory "+app_dir
    exit
  end
  file_list = Dir.entries(app_dir)
  return file_list
end

# Print application list

def print_app_list(app_file_list)
  app_list = []
  app_file_list.each do |file_name|
    if file_name.match(/ipa$/)
      app_name = file_name.split(/\./)[0]
      app_name = app_name.split(/\s+/)[0..-2].join(" ")
      app_list.push(app_name)
    end
  end
  app_list = app_list.uniq
  app_list.each do |app_name|
    puts app_name
  end
  return
end

# Print old application list

def print_old_list(app_file_list,rm_file)
  if !File.directory?($itunes_dir) and !File.symlink?($itunes_dir)
    puts "Could not find iTunes directory "+$itunes_dir
    exit
  end
  app_dir   = $itunes_dir+"/iTunes Media/Mobile Applications"
  if !File.directory?(app_dir) and !File.symlink?(app_dir)
    puts "Could not find Mobile Applications directory "+app_dir
    exit
  end
  app_list = {}
  app_file_list.each do |file_name|
    if file_name.match(/ipa$/)
      file_info = file_name.split(/(\s+)/)
      if file_info[-3].match(/[0-9]\./) and file_info[-1].match(/\.ipa/)
        app_name  = file_info[0..-5].join
        app_ver   = file_info[-3]
      else
        app_name  = file_info[0..-3].join
        app_ver   = file_info[-1].split(/\./)[0..-2].join(".")
      end
      if !app_list[app_name]
        app_list[app_name] = app_ver
        lat_ver  = app_ver
      else
        cur_ver  = app_list[app_name]
        versions = [ cur_ver, app_ver ]
        lat_ver  = versions.map{ |v| (v.split '.').collect(&:to_i) }.max.join '.'
      end
      app_list[app_name] = lat_ver
    end
  end
  app_file_list.each do |file_name|
    if file_name.match(/ipa$/)
      file_info = file_name.split(/(\s+)/)
      if file_info[-3].match(/[0-9]\./) and file_info[-1].match(/\.ipa/)
        app_name  = file_info[0..-5].join
        app_ver   = file_info[-3]
      else
        app_name  = file_info[0..-3].join
        app_ver   = file_info[-1].split(/\./)[0..-2].join(".")
      end
      lat_ver   = app_list[app_name]
      if lat_ver != app_ver
        app_file = app_dir+"/"+file_name
        if rm_file == "y"
          puts "Deleting:    "+app_file
          File.delete(app_file)
        else
          puts "Application: "+app_name
          puts "Newest:      "+lat_ver
          puts "Older:       "+app_ver
        end
      end
    end
  end
  return
end

# Get command line arguments
# Print help if given none

if !ARGV[0]
  print_usage()
end

begin
  opt = Getopt::Std.getopts($options)
rescue
  print_usage()
  exit
end

# Set iTunes directory if given -i

if opt["i"]
  $itunes_dir = opt["i"]
end

# Print version

if opt["V"]
  print_version()
  exit
end

# Prient usage

if opt["h"]
  print_usage()
end

# Delete file if given -d

if opt["d"]
  rm_file = "y"
else
  rm_file = "n"
end

# Handle application option

if opt["a"]
  if !opt["l"] and !opt["d"] and !opt["o"]
    print_usage()
    exit
  end
  if opt["l"] or opt["d"] or opt["o"]
    app_file_list = get_app_file_list()
  end
  if opt["l"]
    print_app_list(app_file_list)
  end
  if opt["o"] or opt["d"]
    print_old_list(app_file_list,rm_file)
  end
end
