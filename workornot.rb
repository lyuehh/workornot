#! /usr/bin/env ruby

require 'yaml'

def doit(date_str)
    work = "too bad, work day~"
    free = "haha, have a rest~"
    date = date_str.to_i
    year = date_str[0..3]
    if date_str.length != 8
        puts "not a date string"
        return
    end
    conf = nil
    File.open('data/holiday.' + year + '.yaml') do |f|
      conf = YAML::load(f)
    end
    
    # 先检查假期，假期里有则表示休息
    if conf['free'].include?(date)
        puts free
        return
    else
        # 再检查工作日，工作日里有则表示工作
        if conf['work'].include?(date)
            puts work
            return
        else
            # 如果通过以上的检测，则周末休息，平时工作
            begin
                d = Date.strptime(date_str, '%Y%m%d')
            rescue ArgumentError
                puts "not a date string"
                return
            end
            if d.sunday? || d.saturday?
                puts free
            else
                puts work
            end
        end
    end
end

if ARGV.length != 1
    puts "Usage: ./workornot.rb 20130101"
else
    doit(ARGV[0])
end

