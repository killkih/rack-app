require_relative 'time_determinant'

class App

  def call(env)
    @request = Rack::Request.new(env)
    result
  end

  private

  def result
    case @request.path
    when "/time"
      body = TimeDeterminant.new(@request.params['format']).call

      if body =~ /^Unknown/
        status = 400
      else
        status = 200
      end
    else
      body, status = ["Not found", 404]
    end

    set_response(status, body)
  end

  def set_response(status, body)
    response = Rack::Response.new(body, status, {'content-type' => 'text/plain'})
    response.finish
  end

end
