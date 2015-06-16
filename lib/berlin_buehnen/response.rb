module BerlinBuehnen
  class Response < Hashie::Mash
    attr_reader :response

    def initialize(response=nil, *args)
      debugger
      @response = response
      super(response, *args)
    end
  end
end
