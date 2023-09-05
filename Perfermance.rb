def run_command(command)
  `#{command}`.chomp
end

def display_system_info
  # Get CPU usage using 'top' command
  cpu_usage = run_command("top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/'")

  # Get RAM usage using 'free' command
  used_ram = run_command("free -m | awk 'NR==2{print $3}'").to_i
  total_ram = run_command("free -m | awk 'NR==2{print $2}'").to_i
  ram_percentage = (used_ram.to_f / total_ram) * 100

  # Get disk usage using 'df' command
  disk_info = run_command("df -h / | awk 'NR==2{print $3, $2}'")

  # Print the results
  puts "CPU Usage: #{cpu_usage}%"
  puts "RAM Usage: Used #{used_ram}MB out of #{total_ram}MB (#{ram_percentage.round(2)}%)"
  puts "Disk Usage: #{disk_info}"
end

# Run the code in a loop every 1 seconds
loop do
  display_system_info
  sleep 1
end