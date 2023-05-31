class TimeDeterminant

  TIMES = { 'year' => '%Y', 'month' => '%m', 'day' => '%d',
            'hour' => '%H', 'minute' => '%M', 'second' => '%S' }.freeze

  def initialize(format)
    @format = format
    @converted_format = []
    @unknown_formats = []
  end

  def call
    convert_format = convert_format(@format) if @format != nil

    if valid?
      Time.now.strftime(convert_format)
    else
      "Unknown formats: #{@unknown_formats.join(", ")}"
    end
  end

  private

  def valid?
    @unknown_formats.empty? && @format != nil
  end


  def convert_format(format)
    format.split(',').each do |element|
      if TIMES[element]
        @converted_format << TIMES[element]
      else
        @unknown_formats << element
      end
    end

    @converted_format.join('-')
  end
end
