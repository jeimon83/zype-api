module Zype
  class Pagination
    def paginate(data)
      {
        current_page: data['current'],
        next_page: data['next'],
        previous_page: data['previous'],
        total_pages: data['pages']
      }
    end
  end
end