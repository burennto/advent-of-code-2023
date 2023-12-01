require 'rake'
require 'rake/testtask'
require 'fileutils'
require 'erb'

task :test do
  Rake::TestTask.new do |t|
    t.libs << "src"
    t.warning = true
    t.verbose = true

    t.pattern = 'src/**/*.rb'
  end

end

desc "Clone template for the next day's challenge"
task :next_day do
  max_days = 31
  template_dir = '.template'
  destination_dir = 'src'
  base_day_name = 'Day'

  # Find the next available day number
  next_day_num = (1..max_days).detect { |num| !File.directory?("#{destination_dir}/#{base_day_name.downcase}#{num}") }
  raise "All 31 days have been generated." unless next_day_num

  # Create the new day directory
  new_day_dir = File.join(destination_dir, "#{base_day_name.downcase}#{next_day_num.to_s}")

  puts "Creating directory for #{new_day_dir}"
  FileUtils.mkdir_p(new_day_dir)

  Dir.glob(File.join(template_dir, '*.txt')).each do |file|
    FileUtils.cp(file, new_day_dir)
  end

  @module_name = "#{base_day_name}#{next_day_num}"
  template = ERB.new(File.read(File.join(template_dir, 'solution.rb.erb')))
  File.open(File.join(new_day_dir , 'solution.rb'), 'w') do |file|
    file.puts template.result(binding)
  end

  puts "Day #{next_day_num} has been set up successfully."
end
