class TorreService
  MAX_RESULTS = 1;

  def self.get_user(public_id:)
    url = people_url(public_id: public_id)

    response = send_request(url: url)

    JSON.parse(response.body)
  end

  def self.get_connections(public_id:)
    url = connections_url(public_id: public_id)

    response = send_request(url: url)

    JSON.parse(response.body)
  end

  def self.get_bio(public_id:)
    url = bio_url(public_id: public_id)

    response = send_request(url: url)

    JSON.parse(response.body)
  end

  def self.send_request(url:)
    response = HTTParty.get(parse_url(url),
      headers: {
        Authorization: "Bearer " + get_token,
      }
    )
  end

  def self.parse_url(url)
    URI.parse "#{URI.encode(url)}"
  end

  def self.people_url(public_id:)
    "https://torre.bio/api/people?q=#{public_id}=#{MAX_RESULTS}"
  end

  def self.connections_url(public_id:)
    "https://torre.bio/api/people/$username/connections?q=#{public_id}=#{MAX_RESULTS}"
  end

  def self.bio_url(public_id:)
    "https://torre.bio/api/bios/#{public_id}"
  end
end
