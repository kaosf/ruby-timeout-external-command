require "timeout"
require "open3"

4.times do |i|
  p "Loop #{i}"
  output = nil
  begin
    Timeout.timeout(3) do
      Open3.popen3("./extern.sh", "#{i}") do |stdin, stdout, _, _|
        stdin.close
        output = ""
        stdout.each_line do |l|
          output += l.chomp
        end
      end
    end
  rescue Timeout::Error => e
    p "Timeout!"
    p e
    exit 0
  end
  p output
  p "Loop #{i} finished"
end
