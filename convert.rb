#!/usr/bin/env ruby

# This is the script we used to use to deal with converting things to mov files

DIR         = ARGV[0].sub /\/$/, ''
INPUT_DIR   = "#{DIR}"
STAGING_DIR = "#{DIR}/../Staging"
VIDEO_DIR   = "#{DIR}/../Video"
MUSIC_DIR   = "#{DIR}/../Music"
OTHER_DIR   = "#{DIR}/../Other"

MUX_MOVIE = 'Resources/muxmovie'
NOTHING   = 'Resources/nothing.mov'

require 'convert_utils'

puts
puts "Conversion at " + Time.now.to_s

puts "Staging files.."
# files = Dir.glob("#{INPUT_DIR}/**/*.avi")
# scan out directories
files = ARGV[1..-1].map do |f|
  if File.directory?(f)
    Dir.glob "#{f}/**/*.*"
  else
    f
  end
end.flatten


files.map! { |f| stage_file(f) }
clean_dir(INPUT_DIR)

puts "Converting files.."
files.map do |f|
  if f =~ /.avi$/
    convert_file(f)
  elsif f =~ /.(m4v|mp4|mov)/
    move_file(f, STAGING_DIR, VIDEO_DIR)
  elsif f =~ /.(mp3|m4a|aac)/
    move_file(f, STAGING_DIR, MUSIC_DIR)
  else
    move_file(f, STAGING_DIR, OTHER_DIR)
  end
end
clean_dir(STAGING_DIR)

puts "Done at " + Time.now.to_s