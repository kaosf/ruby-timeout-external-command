require "open3"

4.times do |i|
  p "Loop #{i}"
  output = nil
  exitstatus = 0
  Open3.popen3("timeout", "3", "./extern.sh", "#{i}") do |stdin, stdout, _, wait_thr|
    stdin.close
    output = ""
    stdout.each_line do |l|
      output += l.chomp
    end
    exitstatus = wait_thr.value.exitstatus
  end
  if exitstatus == 124
    p "Timeout!"
    exit 0
  end

  p output
  p "Loop #{i} finished"
end
