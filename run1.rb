require "timeout"

4.times do |i|
  p "Loop #{i}"
  output = nil
  begin
    Timeout.timeout(3) do
      output = system("./extern.sh #{i}")
    end
  rescue Timeout::Error => e
    p "Timeout!"
    p e
    exit 0
  end
  p output
  p "Loop #{i} finished"
end
