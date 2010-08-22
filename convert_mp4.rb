#!/usr/bin/env ruby

FFMPEG = 'ffmpeg'

BASE_DIR = ARGV[0].sub /\/$/, ''
OUT_DIR = "#{BASE_DIR}/mp4"

require 'convert_utils'

input_dir = ARGV[1]

files = Dir.glob("#{input_dir}/**/*.mov")

files.map do |f|
  convert_mov_to_mp4(f, BASE_DIR, OUT_DIR)
end