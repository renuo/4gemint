def periodically_sleeping_thread(seconds)
  Thread.new do
    loop do
      sleep(seconds)
      yield
    end
  end
end
