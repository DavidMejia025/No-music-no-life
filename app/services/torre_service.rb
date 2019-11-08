class TorreService
  MAX_RESULTS = 1;

  def self.get_people(public_id:)
    url = people_url(public_id: public_id)

    response = send_request(url: url)

    JSON.parse(response.body)
  end

  def self.get_connections(public_id:, name:)
    url = connections_url(public_id: public_id, name: 'manuel')

    response = send_request(url: url)

    JSON.parse(response.body)
  end

  def self.get_bio(public_id:)
    url = bio_url(public_id: public_id)

    response = send_request(url: url)

    TorreParserService.bio(bio_response: JSON.parse(response.body))
    #JSON.parse(response.body)
  end

  def self.send_request(url:)
    response = HTTParty.get(parse_url(url),
      headers: {
        "Accept" => "application/json"
      }
    #  response = HTTParty.get("https://torre.bio/api/people/danielaavila/connections?q='manuel'&limit=1", headers: { })
    )
  end

  def self.parse_url(url)
    URI.parse "#{URI.encode(url)}"
  end

  def self.people_url(public_id:)
    "https://torre.bio/api/people?q='#{public_id}'&limit=#{MAX_RESULTS}"
  end

  def self.connections_url(public_id:, name:)
    "https://torre.bio/api/people/#{public_id}/connections?q='#{name}'&limit=#{MAX_RESULTS}"
  end

  def self.bio_url(public_id:)
    "https://torre.bio/api/bios/#{public_id}"
  end
end
