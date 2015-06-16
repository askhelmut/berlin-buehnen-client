module BerlinBuehnen
  class ListResponse < Response

    META = "meta"
    OBJECTS = "objects"

    NEXT = "next"
    PREVIOUS = "previous"
    OFFSET = "offset"
    LIMIT = "limit"
    TOTAL_COUNT = "total_count"

    def data
      @data ||= @json_response[OBJECTS]
    end

    def next?
      !meta[NEXT].nil?
    end

    def previous?
      !meta[PREVIOUS].nil?
    end

    def limit
      meta[LIMIT]
    end

    def offset
      meta[OFFSET]
    end

    def total_count
      meta[TOTAL_COUNT]
    end

    private
    def meta
      @meta ||= @json_response[META]
    end

  end
end
