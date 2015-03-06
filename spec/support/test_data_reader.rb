class TestDataReader
  def initialize(file)
    @file = file
  end

  def get_test(num)
    if !@data
      test_reader
    end
    @data[num]
  end

  def data
    @data
  end

  def test_reader
    test_id = 0
    test_details = {}
    @data = []
    @file.readlines.each do |line|
      items = line.split(',')
      if (items[0].length > 0) && (items[0] != test_id)
        @data << test_details
        test_id = items[0]
        test_details = {
          :id         => items[0],
          :rx_date    => items[1],
          :evaluable  => items[4],
          :response   => items[5],
          :normalised => items[6],
          :note       => items[7],
          :results    => []
        }
      end
      test_details[:results] << {:date => items[2], :value => items[3]}
    end
    @data << test_details
  end
end
